import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final String chatId;
  final String userId;
  final String? lastMessage;

  const ChatEntity({
    required this.chatId,
    required this.userId,
    this.lastMessage,
  });

  @override
  List<Object?> get props => [chatId, userId, lastMessage];
}
