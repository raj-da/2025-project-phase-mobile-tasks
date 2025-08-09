import 'package:ecommerce_ui_clone/features/authentication/data/model/user_model.dart';
import 'package:ecommerce_ui_clone/features/chat/data/models/chat_model.dart';
import 'package:ecommerce_ui_clone/features/chat/data/models/message_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Map<String, dynamic> tJsonResponse = {
    '_id': '66c872f6346255dac2604bab',
    'sender': {
      '_id': '66bde36e9bbe07fc39034cdd',
      'name': 'Mr. User',
      'email': 'user@gmail.com',
      '__v': 0,
    },
    'chat': {
      '_id': '66c84151b7068ee15142f817',
      'user1': {
        '_id': '66c840e4b7068ee15142f7ef',
        'name': 'string',
        'email': 'cat@gmail.com',
        '__v': 0,
      },
      'user2': {
        '_id': '66bde36e9bbe07fc39034cdd',
        'name': 'Mr. User',
        'email': 'user@gmail.com',
        '__v': 0,
      },
      '__v': 0,
    },
    'content': 'Hello',
    '__v': 0,
    'type': 'text',
  };

  String tId = tJsonResponse['_id'];
  UserModel tSender = UserModel.fromJson(tJsonResponse['sender']);
  ChatModel tChat = ChatModel.fromJson(tJsonResponse['chat']);
  String tContent = tJsonResponse['content'];
  String tType = tJsonResponse['type'];

  MessageModel tMessageModel = MessageModel(
    id: tId,
    sender: tSender,
    chat: tChat,
    content: tContent,
    type: tType,
  );

  test('should create a valid MessageModel from JSON', () async {
      // Act
      MessageModel result = MessageModel.fromJson(tJsonResponse);

      // Assert
      expect(result, tMessageModel);
    });
}
