import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String id;
  final String chatId;
  final String senderId;
  final String content;

  const MessageEntity({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.content,
  });
  
  @override
  List<Object?> get props => [id, chatId, senderId, content];
}
