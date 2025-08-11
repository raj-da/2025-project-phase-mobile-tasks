import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
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
  final NetworkInfo networkInfo;

  ChatRepositoryImpl({
    required this.remoteDataSource,
    required this.socketDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<User>>> getUsers() async {
    if (await networkInfo.isConnected) {
      try {
        final String token = await remoteDataSource.getToken();
        final users = await remoteDataSource.getAllUsers(token: token);
        return Right(
          users
              .map((e) => User(id: e.id, email: e.email, name: e.name))
              .toList(),
        );
      } catch (e) {
        return const Left(ServerFailure(messege: 'Failed to load users'));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Success>> connectToSocket() async {
    if (await networkInfo.isConnected) {
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
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, ChatEntity>> createChat({
    required String userId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        debugPrint('##################before getting token##################');
        final token = await remoteDataSource.getToken();
        debugPrint(
          '##################before getting chat token##################',
        );

        debugPrint('User id: $userId');
        debugPrint('token: $token ');

        final chat = await remoteDataSource.initiateChat(
          userId: userId,
          token: token,
        );

        debugPrint(
          '##################after getting chat token##################',
        );

        return Right(chat);
      } catch (e) {
        debugPrint('$e');
        return const Left(ServerFailure(messege: 'Failure creating a chat'));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteChat({required String chatId}) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await remoteDataSource.getToken();
        await remoteDataSource.deleteChat(chatId: chatId, token: token);
        return const Right(null);
      } catch (e) {
        return const Left(ServerFailure(messege: 'Failure deleting chat'));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Success>> disconnectFromSocket() async {
    if (await networkInfo.isConnected) {
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
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<ChatEntity>>> getChats() async {
    if (await networkInfo.isConnected) {
      try {
        final token = await remoteDataSource.getToken();
        final chats = await remoteDataSource.getUserChats(token: token);
        return Right(chats);
      } catch (e) {
        return const Left(ServerFailure(messege: 'Failed to get chats'));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<MessageEntity>>> getMessages({
    required String chatId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await remoteDataSource.getToken();

        final messages = await remoteDataSource.getChatMessages(
          chatId: chatId,
          token: token,
        );
        return Right(messages);
      } catch (e) {
        return const Left(
          ServerFailure(messege: 'Failed to load chat message'),
        );
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> sendMessage({
    required String chatId,
    required content,
    type = 'text',
  }) async {
    if (await networkInfo.isConnected) {
      try {
        socketDataSource.connect();
        socketDataSource.sendMessage(
          chatId: chatId,
          content: content,
          type: type,
        );
        debugPrint(
          '#############################message sent#####################',
        );
        return const Right(null);
      } catch (e) {
        debugPrint(
          '#############################Exception#################################',
        );
        debugPrint('$e');
        return const Left(ServerFailure(messege: 'Error sending message'));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getLoggedUser() async {
    try {
      final userModel = await remoteDataSource.getLoggedUser();
      return Right(userModel.toUser());
    } catch (e) {
      return const Left(ServerFailure(messege: 'Unable to get logged user'));
    }
  }

  @override
  Stream<MessageEntity> onMessageDelivered() {
    // It does the same for the delivered messages stream.
    return socketDataSource.onMessageDelivered().map(
      (messageModel) => messageModel.toEntity(),
    );
  }

  @override
  Stream<MessageEntity> onMessageReceived() {
    // This listens to the socket data source's stream of models
    // and converts each model into an entity.
    return socketDataSource.onMessageReceived().map(
      (messageModel) => messageModel.toEntity(),
    );
  }
}
