part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class UsersLoaded extends ChatState {
  final List<User> users;
  const UsersLoaded(this.users);

  @override
  List<Object> get props => [users];
}

class ChatsLoaded extends ChatState {
  final List<ChatEntity> chats;
  const ChatsLoaded(this.chats);
  @override
  List<Object> get props => [chats];
}

class MessagesLoaded extends ChatState {
  final List<MessageEntity> messages;
  const MessagesLoaded(this.messages);
  @override
  List<Object> get props => [messages];
}

class ChatCreated extends ChatState {
  final ChatEntity chat;
  const ChatCreated(this.chat);
  @override
  List<Object> get props => [chat];
}

class ChatDeleted extends ChatState {}

class MessageSent extends ChatState {}

class MessageDelivered extends ChatState {
  final MessageEntity message;
  const MessageDelivered(this.message);
  @override
  List<Object> get props => [message];
}

class MessageReceived extends ChatState {
  final MessageEntity message;
  const MessageReceived(this.message);
  @override
  List<Object> get props => [message];
}

class ChatError extends ChatState {
  final String message;
  const ChatError(this.message);
  @override
  List<Object> get props => [message];
}

class SocketConnected extends ChatState {
  final String message;
  const SocketConnected(this.message);
  
  @override
  List<Object> get props => [message];
}
