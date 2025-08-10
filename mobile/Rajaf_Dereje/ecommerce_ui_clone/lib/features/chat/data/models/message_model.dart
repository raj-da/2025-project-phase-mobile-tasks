import '../../../authentication/data/model/user_model.dart';
import '../../domain/entities/message_entity.dart';
import 'chat_model.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.id,
    required super.chat,
    required super.sender,
    required super.content,
    required super.type,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['_id'],
      sender: UserModel.fromJson(json['sender']),
      chat: ChatModel.fromJson(json['chat']),
      type: json['type'],
      content: json['content'],
    );
  }

  factory MessageModel.fromEntity(MessageEntity message) {
    return MessageModel(
      id: message.id,
      chat: message.chat,
      sender: message.sender,
      content: message.content,
      type: message.type,
    );
  }
}
