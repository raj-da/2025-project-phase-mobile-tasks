import 'package:dio/dio.dart';
import 'package:ecommerce_ui_clone/core/error/exception.dart';
import 'package:ecommerce_ui_clone/features/authentication/data/datasource/auth_local_data_source_impl.dart';
import 'package:ecommerce_ui_clone/features/authentication/data/model/user_model.dart';
import 'package:ecommerce_ui_clone/features/chat/data/datasources/chat_remote_data_source_impl.dart';
import 'package:ecommerce_ui_clone/features/chat/data/models/chat_model.dart';
import 'package:ecommerce_ui_clone/features/chat/data/models/message_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'chat_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([Dio, AuthLocalDataSourceImpl])
void main() {
  late ChatRemoteDataSourceImpl dataSource;
  late MockDio mockDio;
  late MockAuthLocalDataSourceImpl mockAuthLocalDataSourceImpl;

  setUp(() {
    mockDio = MockDio();
    mockAuthLocalDataSourceImpl = MockAuthLocalDataSourceImpl();
    dataSource = ChatRemoteDataSourceImpl(
      dio: mockDio,
      authLocalDataSource: mockAuthLocalDataSourceImpl,
    );
  });

  const token = 'test_token';

  group('getAllUsers', () {
    final responseData = {
      'statusCode': 200,
      'message': '',
      'data': [
        {
          '_id': '6891c0bbfa0604c7c17f079d',
          'name': 'ermi',
          'email': 'user@gmail.com',
          'password': 'test',
          '__v': 0,
        },
        {
          '_id': '6893161b3f94e073b1b65b74',
          'name': 'abu',
          'email': 'abu@gmail.com',
          'password': 'test',
          '__v': 0,
        },
        {
          '_id': '689346d9c293c0e593bf69c9',
          'name': 'mes',
          'email': 'mes@gmail.com',
          'password': 'test',
          '__v': 0,
        },
      ],
    };

    final data = responseData['data'] as List;
    final users = data.map((e) => UserModel.fromJson(e)).toList();

    test('should return list of UserModel when response is 200', () async {
      // Arrange
      when(mockDio.get(any, options: anyNamed('options'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: responseData,
          statusCode: 200,
        ),
      );

      // Act
      final result = await dataSource.getAllUsers(token: token);

      // Assert
      expect(result, isA<List<UserModel>>());
      expect(result.first.id, users.first.id);
      expect(result.first.name, users.first.name);
      expect(result.first.email, users.first.email);
    });

    test('should throw ServerException on non-200 response', () async {
      // Arrange
      when(mockDio.get(any, options: anyNamed('options'))).thenAnswer(
        (_) async => Response(
          data: {},
          statusCode: 400,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      // Act and Assert
      expect(
        () async => await dataSource.getAllUsers(token: token),
        throwsA(isA<ServerException>()),
      );
    });
  }); // get all users group

  group('getUserChats', () {
    final responseData = {
      'statusCode': 200,
      'message': '',
      'data': [
        {
          '_id': '689604a2edd3b049e337f788',
          'user1': {
            '_id': '6895138587b81e087f98245d',
            'name': 'chief',
            'email': 'chief@gmail.com',
            '__v': 0,
          },
          'user2': {
            '_id': '6894aa6b7f5355bfec5d55c5',
            'name': 'raj',
            'email': 'raj@gmail.com',
            '__v': 0,
          },
          'createdAt': '2025-08-08T14:07:30.433Z',
          'updatedAt': '2025-08-08T14:07:30.433Z',
          '__v': 0,
        },
      ],
    };

    final data = responseData['data'] as List;
    final chats = data.map((e) => ChatModel.fromJson(e)).toList();

    test('should return list of ChatModel when response is 200', () async {
      // Arrange
      when(mockDio.get(any, options: anyNamed('options'))).thenAnswer(
        (_) async => Response(
          data: responseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      // Act
      final result = await dataSource.getUserChats(token: token);

      // Assert
      expect(result, isA<List<ChatModel>>());
      expect(result.first.id, chats.first.id);
    });

    test('should ServerException on non-200 response', () async {
      // Arrange
      when(mockDio.get(any, options: anyNamed('options'))).thenAnswer(
        (_) async => Response(
          data: {},
          statusCode: 400,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      // Act and Assert
      expect(
        () async => await dataSource.getUserChats(token: token),
        throwsA(isA<ServerException>()),
      );
    });
  }); // get user chats group

  group('getChatmessages', () {
    final responseData = {
      'statusCode': 200,
      'message': '',
      'data': [
        {
          '_id': '68960affedd3b049e337fdc7',
          'sender': {
            '_id': '6895138587b81e087f98245d',
            'name': 'chief',
            'email': 'chief@gmail.com',
            '__v': 0,
          },
          'chat': {
            '_id': '689604a2edd3b049e337f788',
            'user1': {
              '_id': '6895138587b81e087f98245d',
              'name': 'chief',
              'email': 'chief@gmail.com',
              '__v': 0,
            },
            'user2': {
              '_id': '6894aa6b7f5355bfec5d55c5',
              'name': 'raj',
              'email': 'raj@gmail.com',
              '__v': 0,
            },
            'createdAt': '2025-08-08T14:07:30.433Z',
            'updatedAt': '2025-08-08T14:07:30.433Z',
            '__v': 0,
          },
          'type': 'text',
          'content': 'eza mado kewenzu bashager',
          'createdAt': '2025-08-08T14:34:39.344Z',
          'updatedAt': '2025-08-08T14:34:39.344Z',
          '__v': 0,
        },
        {
          '_id': '68960c8eedd3b049e337fe20',
          'sender': {
            '_id': '6895138587b81e087f98245d',
            'name': 'chief',
            'email': 'chief@gmail.com',
            '__v': 0,
          },
          'chat': {
            '_id': '689604a2edd3b049e337f788',
            'user1': {
              '_id': '6895138587b81e087f98245d',
              'name': 'chief',
              'email': 'chief@gmail.com',
              '__v': 0,
            },
            'user2': {
              '_id': '6894aa6b7f5355bfec5d55c5',
              'name': 'raj',
              'email': 'raj@gmail.com',
              '__v': 0,
            },
            'createdAt': '2025-08-08T14:07:30.433Z',
            'updatedAt': '2025-08-08T14:07:30.433Z',
            '__v': 0,
          },
          'type': 'text',
          'content': 'eza mado kewenzu bashager',
          'createdAt': '2025-08-08T14:41:18.333Z',
          'updatedAt': '2025-08-08T14:41:18.333Z',
          '__v': 0,
        },
      ],
    };

    final data = responseData['data'] as List;
    final messages = data.map((e) => MessageModel.fromJson(e)).toList();

    test('should return a list of MessageModel when response is 200', () async {
      // Arrange
      when(mockDio.get(any, options: anyNamed('options'))).thenAnswer(
        (_) async => Response(
          data: responseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      // Act
      final result = await dataSource.getChatMessages(
        chatId: 'chat1',
        token: token,
      );

      // Assert
      expect(result, isA<List<MessageModel>>());
      expect(result.first.id, messages.first.id);
    });

    test('throws ServerException on non-200 response', () async {
      when(mockDio.get(any, options: anyNamed('options'))).thenAnswer(
        (_) async => Response(
          data: {},
          statusCode: 400,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      expect(
        () async =>
            await dataSource.getChatMessages(chatId: 'chat1', token: token),
        throwsA(isA<ServerException>()),
      );
    });
  }); // get chat messages group

  group('initiateChat', () {
    final responseData = {
      'statusCode': 201,
      'message': '',
      'data': {
        '_id': '689604a2edd3b049e337f788',
        'user1': {
          '_id': '6895138587b81e087f98245d',
          'name': 'chief',
          'email': 'chief@gmail.com',
          '__v': 0,
        },
        'user2': {
          '_id': '6894aa6b7f5355bfec5d55c5',
          'name': 'raj',
          'email': 'raj@gmail.com',
          '__v': 0,
        },
        'createdAt': '2025-08-08T14:07:30.433Z',
        'updatedAt': '2025-08-08T14:07:30.433Z',
        '__v': 0,
      },
    };

    final chat = ChatModel.fromJson(
      responseData['data'] as Map<String, dynamic>,
    );

    test('should return a ChatModel when response is 201', () async {
      // Arrange
      when(
        mockDio.post(any, data: anyNamed('data'), options: anyNamed('options')),
      ).thenAnswer(
        (_) async => Response(
          data: responseData,
          statusCode: 201,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      // Act
      final result = await dataSource.initiateChat(userId: '2', token: token);

      // Assert
      expect(result, isA<ChatModel>());
      expect(result.id, chat.id);
    });

    test('throws ServerException on non-201 response', () async {
      when(
        mockDio.post(any, data: anyNamed('data'), options: anyNamed('options')),
      ).thenAnswer(
        (_) async => Response(
          data: {},
          statusCode: 400,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      expect(
        () async => await dataSource.initiateChat(userId: '2', token: token),
        throwsA(isA<ServerException>()),
      );
    });
  }); // initiate chat group

  group('deleteChat', () {
    test('completes when response is 200 or 204', () async {
      when(mockDio.delete(
        any,
        options: anyNamed('options'),
      )).thenAnswer((_) async => Response(
            data: {},
            statusCode: 204,
            requestOptions: RequestOptions(path: ''),
          ));

      expect(
        () async => await dataSource.deleteChat(chatId: 'chat1', token: token),
        returnsNormally,
      );
    });

    test('throws ServerException on non-200/204 response', () async {
      when(mockDio.delete(
        any,
        options: anyNamed('options'),
      )).thenAnswer((_) async => Response(
            data: {},
            statusCode: 400,
            requestOptions: RequestOptions(path: ''),
          ));

      expect(
        () async => await dataSource.deleteChat(chatId: 'chat1', token: token),
        throwsA(isA<ServerException>()),
      );
    });
  }); // delete chat group
}
