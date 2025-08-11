import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../authentication/domain/entity/user.dart';
import '../../domain/entities/chat_entity.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/usecases/connect_socket.dart';
import '../../domain/usecases/create_chat.dart';
import '../../domain/usecases/delete_chat.dart';
import '../../domain/usecases/get_all_users.dart';
import '../../domain/usecases/get_chat_messages.dart';
import '../../domain/usecases/get_logged_user.dart';
import '../../domain/usecases/get_user_chats.dart';
import '../../domain/usecases/listen_for_delivered_messages.dart';
import '../../domain/usecases/listen_for_received_messages.dart';
import '../../domain/usecases/send_message.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetAllUsers getAllUsers;
  final ConnectSocket connectSocket;
  final DeleteChat deleteChat;
  final GetChatMessages getChatMessages;
  final GetUserChats getUserChats;
  final SendMessage sendMessage;
  final GetLoggedUser getLoggedUser;
  final CreateChat createChat;
  final ListenForDeliveredMessages listenForDeliveredMessages;
  final ListenForReceivedMessages listenForReceivedMessages;

  StreamSubscription<MessageEntity>? _receivedMessagesSubscription;
  StreamSubscription<MessageEntity>? _deliveredMessagesSubscription;

  ChatBloc({
    required this.getAllUsers,
    required this.connectSocket,
    required this.deleteChat,
    required this.getChatMessages,
    required this.getUserChats,
    required this.sendMessage,
    required this.getLoggedUser,
    required this.createChat,
    required this.listenForDeliveredMessages,
    required this.listenForReceivedMessages,
  }) : super(ChatInitial()) {
    on<LoadUsersEvent>(_onLoadUsers);
    on<ConnectSocketEvent>(_onConnectSocket);
    on<DeleteChatEvent>(_onDeleteChat);
    on<LoadMessagesEvent>(_onLoadMessages);
    on<LoadChatsEvent>(_onLoadChats);
    on<SendMessageEvent>(_onSendMessage);
    on<CreateChatEvent>(_onCreateChat);

    on<StartMessageListenersEvent>(_onStartMessageListeners);
    on<MessageDeliveredEvent>(_onMessageDelivered);
    on<MessageReceivedEvent>(_onMessageReceived);
  }

  void _onStartMessageListeners(
    StartMessageListenersEvent event,
    Emitter<ChatState> emit,
  ) {
    // Cancel any old subscriptions before starting new ones
    _receivedMessagesSubscription?.cancel();
    _deliveredMessagesSubscription?.cancel();

    // Listen for messages from others
    _receivedMessagesSubscription = listenForReceivedMessages().listen((
      message,
    ) {
      add(MessageReceivedEvent(message));
    });

    // Listen for delivery confirmation of your messages
    _deliveredMessagesSubscription = listenForDeliveredMessages().listen((
      message,
    ) {
      add(MessageDeliveredEvent(message));
    });
  }

  FutureOr<void> _onLoadUsers(
    LoadUsersEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    final result = await getAllUsers();
    result.fold(
      (failure) => emit(ChatError(failure.messege)),
      (users) => emit(UsersLoaded(users)),
    );
  }

  FutureOr<void> _onConnectSocket(
    ConnectSocketEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    final result = await connectSocket();
    result.fold(
      (failure) => emit(ChatError(failure.messege)),
      (success) => emit(SocketConnected(success.messege)),
    );
  }

  FutureOr<void> _onDeleteChat(
    DeleteChatEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    final result = await deleteChat(chatId: event.chatId);
    result.fold(
      (failure) => emit(ChatError(failure.messege)),
      (_) => emit(ChatDeleted()),
    );
  }

  FutureOr<void> _onLoadMessages(
    LoadMessagesEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    final result = await getChatMessages(chatId: event.chatId);
    result.fold(
      (failure) => emit(ChatError(failure.messege)),
      (messages) => emit(MessagesLoaded(messages)),
    );
  }

  FutureOr<void> _onLoadChats(
    LoadChatsEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    final result = await getUserChats();
    final loggedUser = await getLoggedUser();
    late final User user; //* for displaying chat names
    loggedUser.fold(
      (failure) => emit(ChatError(failure.messege)),
      (res) => user = res,
    );

    result.fold(
      (failure) => emit(ChatError(failure.messege)),
      (chats) => emit(ChatsLoaded(chats, user)),
    );
  }

  FutureOr<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    connectSocket();
    final result = await sendMessage(
      chatId: event.chatId,
      content: event.content,
      type: event.type,
    );
    result.fold(
      (failure) => emit(ChatError(failure.messege)),
      (_) => emit(MessageSent()),
    );
  }

  FutureOr<void> _onMessageDelivered(
    MessageDeliveredEvent event,
    Emitter<ChatState> emit,
  ) {
    final currentState = state;
    if (currentState is MessagesLoaded) {
      final updatedMessages = List<MessageEntity>.from(currentState.messages)
        ..add(event.message);
      emit(MessagesLoaded(updatedMessages));
    }
  }

  FutureOr<void> _onMessageReceived(
    MessageReceivedEvent event,
    Emitter<ChatState> emit,
  ) {
    final currentState = state;
    if (currentState is MessagesLoaded) {
      final updatedMessages = List<MessageEntity>.from(currentState.messages)
        ..add(event.message);
      emit(MessagesLoaded(updatedMessages));
    }
  }

  FutureOr<void> _onCreateChat(
    CreateChatEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    final result = await createChat(userId: event.userId);
    final loggedUser = await getLoggedUser();
    late final User user; //* for displaying chat names
    loggedUser.fold(
      (failure) => emit(ChatError(failure.messege)),
      (res) => user = res,
    );
    result.fold(
      (failure) => emit(ChatError(failure.messege)),
      (chat) => emit(ChatCreated(chat, user)),
    );
  }

   // 5. CLEANUP
  @override
  Future<void> close() {
    _receivedMessagesSubscription?.cancel();
    _deliveredMessagesSubscription?.cancel();
    return super.close();
  }
}
