import 'package:dartz/dartz.dart';
import 'package:ecommerce_ui_clone/core/success/success.dart';
import 'package:ecommerce_ui_clone/features/authentication/data/model/user_model.dart';
import 'package:ecommerce_ui_clone/features/authentication/domain/entity/user.dart';
import 'package:ecommerce_ui_clone/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:ecommerce_ui_clone/features/chat/data/datasources/chat_socket_data_source.dart';
import 'package:ecommerce_ui_clone/features/chat/data/models/chat_model.dart';
import 'package:ecommerce_ui_clone/features/chat/data/models/message_model.dart';
import 'package:ecommerce_ui_clone/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:ecommerce_ui_clone/features/chat/domain/entities/chat_entity.dart';
import 'package:ecommerce_ui_clone/features/chat/domain/entities/message_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'chat_repository_impl_test.mocks.dart';

@GenerateMocks([ChatRemoteDataSource, ChatSocketDataSource])
void main() {
  late ChatRepositoryImpl repository;
  late MockChatRemoteDataSource mockRemoteDataSource;
  late MockChatSocketDataSource mockSocketDataSource;

  setUp(() {
    mockRemoteDataSource = MockChatRemoteDataSource();
    mockSocketDataSource = MockChatSocketDataSource();
    repository = ChatRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      socketDataSource: mockSocketDataSource,
    );
  });

  group('getUsers', () {
    test('returns Right with user list on success', () async {
      when(mockRemoteDataSource.getToken()).thenAnswer((_) async => 'token');
      when(
        mockRemoteDataSource.getAllUsers(token: anyNamed('token')),
      ).thenAnswer(
        (_) async => [
          const UserModel(id: '1', name: 'Test', email: 'test@test.com'),
        ],
      );
      final result = await repository.getUsers();
      expect(result, isA<Right>());
      expect(result.getOrElse(() => []), isA<List<User>>());
    });

    test('returns Left on failure', () async {
      when(mockRemoteDataSource.getToken()).thenThrow(Exception());
      final result = await repository.getUsers();
      expect(result, isA<Left>());
    });
  }); // get users group

  group('connectToSocket', () {
    test('returns Right on success', () async {
      when(mockSocketDataSource.connect()).thenReturn(null);
      final result = await repository.connectToSocket();
      expect(result, isA<Right>());
      expect(
        result.getOrElse(() => const SocketConnectionSuccess()),
        isA<SocketConnectionSuccess>(),
      );
    });

    test('returns Left on failure', () async {
      when(mockSocketDataSource.connect()).thenThrow(Exception());
      final result = await repository.connectToSocket();
      expect(result, isA<Left>());
    });
  }); // connect to socket group

  group('createChat', () {
    final chatEntity = const ChatEntity(
      id: 'chat1',
      user1: User(id: '1', name: 'User1', email: 'user1@test.com'),
      user2: User(id: '2', name: 'User2', email: 'user2@test.com'),
    );

    test('returns Right with chat entity on success', () async {
      when(mockRemoteDataSource.getToken()).thenAnswer((_) async => 'token');
      when(
        mockRemoteDataSource.initiateChat(
          userId: anyNamed('userId'),
          token: anyNamed('token'),
        ),
      ).thenAnswer((_) async => ChatModel.fromEntity(chatEntity));
      final result = await repository.createChat(userId: '2');
      expect(result, isA<Right>());
      expect(result.getOrElse(() => chatEntity), isA<ChatEntity>());
    });

    test('returns Left on failure', () async {
      when(mockRemoteDataSource.getToken()).thenThrow(Exception());
      final result = await repository.createChat(userId: '2');
      expect(result, isA<Left>());
    });
  }); // create chat group

  group('deleteChat', () {
    test('returns Right on success', () async {
      when(mockRemoteDataSource.getToken()).thenAnswer((_) async => 'token');
      when(
        mockRemoteDataSource.deleteChat(
          chatId: anyNamed('chatId'),
          token: anyNamed('token'),
        ),
      ).thenAnswer((_) async => Future.value(null));
      final result = await repository.deleteChat(chatId: 'chat1');
      expect(result, isA<Right>());
    });

    test('returns Left on failure', () async {
      when(mockRemoteDataSource.getToken()).thenThrow(Exception());
      final result = await repository.deleteChat(chatId: 'chat1');
      expect(result, isA<Left>());
    });
  }); // delete chat group

  group('disconnectFromSocket', () {
    test('returns Right on success', () async {
      when(mockSocketDataSource.disconnect()).thenReturn(null);
      final result = await repository.disconnectFromSocket();
      expect(result, isA<Right>());
    });

    test('returns Left on failure', () async {
      when(mockSocketDataSource.disconnect()).thenThrow(Exception());
      final result = await repository.disconnectFromSocket();
      expect(result, isA<Left>());
    });
  }); // disconnect from socket group

  group('getChats', () {
    final chatEntityList = [
      const ChatEntity(
        id: 'chat1',
        user1: User(id: '1', name: 'User1', email: 'user1@test.com'),
        user2: User(id: '2', name: 'User2', email: 'user2@test.com'),
      ),
    ];

    test('returns Right with chat list on success', () async {
      when(mockRemoteDataSource.getToken()).thenAnswer((_) async => 'token');
      when(
        mockRemoteDataSource.getUserChats(token: anyNamed('token')),
      ).thenAnswer(
        (_) async =>
            chatEntityList.map((e) => ChatModel.fromEntity(e)).toList(),
      );
      final result = await repository.getChats();
      expect(result, isA<Right>());
      expect(result.getOrElse(() => []), isA<List<ChatEntity>>());
    });

    test('returns Left on failure', () async {
      when(mockRemoteDataSource.getToken()).thenThrow(Exception());
      final result = await repository.getChats();
      expect(result, isA<Left>());
    });
  }); // get chats group

  group('getMessages', () {
    final messageEntityList = [
      const MessageEntity(
        id: 'msg1',
        chat: ChatEntity(
          id: 'chat1',
          user1: User(id: '1', name: 'User1', email: 'user1@test.com'),
          user2: User(id: '2', name: 'User2', email: 'user2@test.com'),
        ),
        sender: User(id: '1', name: 'User1', email: 'user1@test.com'),
        content: 'Hello',
        type: 'text',
      ),
    ];

    test('returns Right with message list on success', () async {
      when(mockRemoteDataSource.getToken()).thenAnswer((_) async => 'token');
      when(
        mockRemoteDataSource.getChatMessages(
          chatId: anyNamed('chatId'),
          token: anyNamed('token'),
        ),
      ).thenAnswer(
        (_) async =>
            messageEntityList.map((e) => MessageModel.fromEntity(e)).toList(),
      );
      final result = await repository.getMessages(chatId: 'chat1');
      expect(result, isA<Right>());
      expect(result.getOrElse(() => []), isA<List<MessageEntity>>());
    });

    test('returns Left on failure', () async {
      when(mockRemoteDataSource.getToken()).thenThrow(Exception());
      final result = await repository.getMessages(chatId: 'chat1');
      expect(result, isA<Left>());
    });
  }); // get messages group

  group('sendMessage', () {
    test('returns Right on success', () async {
      when(
        mockSocketDataSource.sendMessage(
          chatId: anyNamed('chatId'),
          content: anyNamed('content'),
          type: anyNamed('type'),
        ),
      ).thenReturn(null);

      final result = await repository.sendMessage(
        chatId: 'chat1',
        content: 'Hello',
        type: 'text',
      );
      expect(result, isA<Right>());
    });

    test('returns Left on failure', () async {
      when(
        mockSocketDataSource.sendMessage(
          chatId: anyNamed('chatId'),
          content: anyNamed('content'),
          type: anyNamed('type'),
        ),
      ).thenThrow(Exception());

      final result = await repository.sendMessage(
        chatId: 'chat1',
        content: 'Hello',
        type: 'text',
      );
      expect(result, isA<Left>());
    });
  });
}
