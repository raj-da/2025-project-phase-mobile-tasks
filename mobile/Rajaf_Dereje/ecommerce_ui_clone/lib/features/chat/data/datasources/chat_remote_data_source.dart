import '../../../authentication/data/model/user_model.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';

abstract class ChatRemoteDataSource {
  /// gets all registered users
  Future<List<UserModel>> getAllUsers({required String token});

  /// gets all chats of a user
  Future<List<ChatModel>> getUserChats({required String token});

  /// gets chat messages of a specific chat
  Future<List<MessageModel>> getChatMessages({
    required String chatId,
    required String token,
  });

  /// creates a new chat
  Future<ChatModel> initiateChat({
    required String userId,
    required String token,
  });

  /// deletes a chat
  Future<void> deleteChat({required String chatId, required String token});

  /// sends a message in a chat
  Future<MessageModel> sendMessage({
    required String chatId,
    required String content,
    required String type,
    required String token,
  });

  Future<String> getToken();

  Future<UserModel> getLoggedUser();
}
