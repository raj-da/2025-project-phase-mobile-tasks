part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class LoadUsersEvent extends ChatEvent {}

class ConnectSocketEvent extends ChatEvent {}

class DisconnectSocketEvent extends ChatEvent {}

class LoadChatsEvent extends ChatEvent {}

class CreateChatEvent extends ChatEvent {
  final String userId;
  const CreateChatEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

class DeleteChatEvent extends ChatEvent {
  final String chatId;
  const DeleteChatEvent(this.chatId);
  @override
  List<Object> get props => [chatId];
}

class LoadMessagesEvent extends ChatEvent {
  final String chatId;

  const LoadMessagesEvent(this.chatId);
  @override
  List<Object> get props => [chatId];
}

class SendMessageEvent extends ChatEvent {
  final String chatId;
  final String content;
  final String type;
  const SendMessageEvent({
    required this.chatId,
    required this.content,
    this.type = 'text',
  });
  @override
  List<Object> get props => [chatId, content, type];
}

// Socket events
class MessageDeliveredEvent extends ChatEvent {
  final MessageEntity message;
  const MessageDeliveredEvent(this.message);
  @override
  List<Object> get props => [message];
}

class MessageReceivedEvent extends ChatEvent {
  final MessageEntity message;
  const MessageReceivedEvent(this.message);
  @override
  List<Object> get props => [message];
}

class StartChatEvent extends ChatEvent {
  final String userId;
  const StartChatEvent(this.userId);

  @override
  List<Object> get props => [userId];
}


class StartMessageListenersEvent extends ChatEvent {}
