import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/success/success.dart';
import '../../../authentication/domain/entity/user.dart';
import '../entities/chat_entity.dart';
import '../entities/message_entity.dart';

abstract class ChatRepository {
  // Create a new chat with a user
  Future<Either<Failure, ChatEntity>> createChat({required String userId});

  // Get all chats for the user
  Future<Either<Failure, List<ChatEntity>>> getChats();

  // Send a message in a chat
  Future<Either<Failure, void>> sendMessage({required String chatId, required content, type = 'text'});

  // Get messages for a specific chat
  Future<Either<Failure, List<MessageEntity>>> getMessages({required String chatId});

  // Delete a chat by ID
  Future<Either<Failure, void>> deleteChat({required String chatId});

  // Get all users for chat creation
  Future<Either<Failure, List<User>>> getUsers();

  // Connect to the chat socket
  Future<Either<Failure, Success>> connectToSocket({required String url});

  // Disconnect from the chat socket
  Future<Either<Failure, Success>> disconnectFromSocket();
}
