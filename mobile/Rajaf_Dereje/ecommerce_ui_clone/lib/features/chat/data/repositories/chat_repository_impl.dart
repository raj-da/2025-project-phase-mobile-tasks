import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/success/success.dart';
import '../../../authentication/domain/entity/user.dart';
import '../../domain/entities/chat_entity.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/repositories/chat_repositories.dart';
import '../datasources/chat_remote_data_source.dart';
import '../datasources/chat_socket_data_source.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;
  final ChatSocketDataSource socketDataSource;

  ChatRepositoryImpl({
    required this.remoteDataSource,
    required this.socketDataSource,
  });

  @override
  Future<Either<Failure, List<User>>> getUsers() async {
    try {
      final String token = await remoteDataSource.getToken();
      final users = await remoteDataSource.getAllUsers(token: token);
      return Right(
        users.map((e) => User(id: e.id, email: e.email, name: e.name)).toList(),
      );
    } catch (e) {
      return const Left(ServerFailure(messege: 'Failed to load users'));
    }
  }

  @override
  Future<Either<Failure, Success>> connectToSocket({
    required String url,
  }) async {
    try {
      socketDataSource.connect();
      return const Right(SocketConnectionSuccess());
    } catch (e) {
      return const Left(
        SocketConnectionFailure(
          messege: 'Failed to connect to socket server in connectToSocket',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ChatEntity>> createChat({
    required String userId,
  }) async {
    try {
      final token = await remoteDataSource.getToken();
      final chat = await remoteDataSource.initiateChat(
        userId: userId,
        token: token,
      );

      return Right(chat);
    } catch (e) {
      return const Left(ServerFailure(messege: 'Failure creating a chat'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteChat({required String chatId}) async {
    try {
      final token = await remoteDataSource.getToken();
      await remoteDataSource.deleteChat(chatId: chatId, token: token);
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure(messege: 'Failure deleting chat'));
    }
  }

  @override
  Future<Either<Failure, Success>> disconnectFromSocket() async {
    try {
      socketDataSource.disconnect();
      return const Right(
        SocketConnectionSuccess(messege: 'Socket discoonnected successfuly'),
      );
    } catch (e) {
      return const Left(
        SocketConnectionFailure(messege: 'Failed to disconnect form socket'),
      );
    }
  }

  @override
  Future<Either<Failure, List<ChatEntity>>> getChats() async {
    try {
      final token = await remoteDataSource.getToken();
      final chats = await remoteDataSource.getUserChats(token: token);
      return Right(chats);
    } catch (e) {
      return const Left(ServerFailure(messege: 'Failed to get chats'));
    }
  }

  @override
  Future<Either<Failure, List<MessageEntity>>> getMessages({
    required String chatId,
  }) async {
    try {
      final token = await remoteDataSource.getToken();

      final messages = await remoteDataSource.getChatMessages(chatId: chatId, token: token);
      return Right(messages);
    } catch (e) {
      return const Left(ServerFailure(messege: 'Failed to load chat message'));
    }
  }
  
  @override
  Future<Either<Failure, void>> sendMessage({required String chatId, required content, type = 'text'}) async {
    try {
      socketDataSource.sendMessage(
        chatId: chatId,
        content: content,
        type: type,
      );
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure(messege: 'Error sending message'));
    }
  }

  
}
