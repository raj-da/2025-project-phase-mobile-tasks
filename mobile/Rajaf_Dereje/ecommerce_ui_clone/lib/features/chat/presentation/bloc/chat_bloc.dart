import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../authentication/domain/entity/user.dart';
import '../../domain/entities/chat_entity.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/usecases/connect_socket.dart';
import '../../domain/usecases/delete_chat.dart';
import '../../domain/usecases/get_all_users.dart';
import '../../domain/usecases/get_chat_messages.dart';
import '../../domain/usecases/get_logged_user.dart';
import '../../domain/usecases/get_user_chats.dart';
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
  ChatBloc({
    required this.getAllUsers,
    required this.connectSocket,
    required this.deleteChat,
    required this.getChatMessages,
    required this.getUserChats,
    required this.sendMessage,
    required this.getLoggedUser,
  }) : super(ChatInitial()) {
    on<LoadUsersEvent>(_onLoadUsers);
    on<ConnectSocketEvent>(_onConnectSocket);
    on<DeleteChatEvent>(_onDeleteChat);
    on<LoadMessagesEvent>(_onLoadMessages);
    on<LoadChatsEvent>(_onLoadChats);
    on<SendMessageEvent>(_onSendMessage);
    on<MessageDeliveredEvent>(_onMessageDelivered);
    on<MessageReceivedEvent>(_onMessageReceived);
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
    emit(MessageDelivered(event.message));
  }

  FutureOr<void> _onMessageReceived(
    MessageReceivedEvent event,
    Emitter<ChatState> emit,
  ) {
    emit(MessageReceived(event.message));
  }
}
