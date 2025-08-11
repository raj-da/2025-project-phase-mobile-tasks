import 'package:ecommerce_ui_clone/features/authentication/data/model/user_model.dart';
import 'package:ecommerce_ui_clone/features/authentication/domain/entity/user.dart';
import 'package:ecommerce_ui_clone/features/chat/data/models/chat_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Map<String, dynamic> tJsonResponse = {
    'statusCode': 201,
    'message': '',
    'data': {
      'user1': {
        '_id': '66c72bd1fc1a63830d084348',
        'name': 'string',
        'email': 'm@gmail.com',
        '__v': 0,
      },
      'user2': {
        '_id': '66c730840740f8c2bae904e0',
        'name': 'string',
        'email': 'a@a.com',
        '__v': 0,
      },
      '_id': '66c767d7944d8f950440bd9e',
      '__v': 0,
    },
  };

  String tChatId = tJsonResponse['data']['_id'];
  User tUser1 = UserModel.fromJson(tJsonResponse['data']['user1']);
  User tUser2 = UserModel.fromJson(tJsonResponse['data']['user2']);
  ChatModel tChatModel = ChatModel(
    id: tChatId,
    user1: tUser1,
    user2: tUser2,
  );

  test('should return a valid chat model from JSON', () async {
      // Act
      final result = ChatModel.fromJson(tJsonResponse['data']);

      // Assert
      expect(result, tChatModel);
    });
}
