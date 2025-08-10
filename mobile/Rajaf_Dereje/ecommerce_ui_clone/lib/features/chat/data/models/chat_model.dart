import '../../../authentication/data/model/user_model.dart';
import '../../domain/entities/chat_entity.dart';

class ChatModel extends ChatEntity {
  const ChatModel({
    required super.id,
    required super.user1,
    required super.user2,
  });

  //todo: Please read the comment below before using this model
  //! The key for id is id in version 2 but might be _id in version 3 please check this if you get any error
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['_id'],
      user1: UserModel.fromJson(json['user1']),
      user2: UserModel.fromJson(json['user2']),
    );
  }

  factory ChatModel.fromEntity(ChatEntity chat) {
    return ChatModel(id: chat.id, user1: chat.user1, user2: chat.user2);
  }
}
