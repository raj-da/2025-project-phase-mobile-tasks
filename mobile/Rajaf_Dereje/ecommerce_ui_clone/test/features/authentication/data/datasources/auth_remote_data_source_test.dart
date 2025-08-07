import 'package:dio/dio.dart';
import 'package:ecommerce_ui_clone/core/error/exception.dart';
import 'package:ecommerce_ui_clone/features/authentication/data/datasource/auth_remote_data_source_impl.dart';
import 'package:ecommerce_ui_clone/features/authentication/data/model/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Import the generated mock file
import 'auth_data_source_test.mocks.mocks.dart'; // Make sure this path is correct

void main() {
  late AuthRemoteDataSourceImpl dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = AuthRemoteDataSourceImpl(dio: mockDio);
  });

  group('logInUser', () {
    const String tEmail = 'test@example.com';
    const String tPassword = 'password123';
    const String tAccessToken = 'test_access_token';

    final tResponsePayload = {
      'statusCode': 201,
      'message': '',
      'data': {'access_token': tAccessToken}
    };

    test('should return access token on successful login (statusCode 201)', () async {
      // Arrange
      when(mockDio.post(any, data: anyNamed('data'))).thenAnswer(
        (_) async => Response(
          data: tResponsePayload,
          statusCode: 201,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      // Act
      final result = await dataSource.logInUser(email: tEmail, password: tPassword);

      // Assert
      expect(result, equals(tAccessToken));
      verify(mockDio.post(
        '${AuthRemoteDataSourceImpl.baseUrl}/auth/login',
        data: {'email': tEmail, 'password': tPassword},
      )).called(1);
    });

    test('should throw ServerException on non-201 status code', () async {
      // Arrange
      when(mockDio.post(any, data: anyNamed('data'))).thenAnswer(
        (_) async => Response(
          data: {},
          statusCode: 400, // Example of a non-201 status code
          requestOptions: RequestOptions(path: ''),
        ),
      );

      // Act
      final call = dataSource.logInUser;

      // Assert
      expect(() => call(email: tEmail, password: tPassword), throwsA(isA<ServerException>()));
      verify(mockDio.post(
        '${AuthRemoteDataSourceImpl.baseUrl}/auth/login',
        data: {'email': tEmail, 'password': tPassword},
      )).called(1);
    });

    test('should throw ServerException on DioError', () async {
      // Arrange
      when(mockDio.post(any, data: anyNamed('data'))).thenThrow(
        DioException(requestOptions: RequestOptions(path: '')),
      );

      // Act
      final call = dataSource.logInUser;

      // Assert
      expect(() => call(email: tEmail, password: tPassword), throwsA(isA<ServerException>()));
      verify(mockDio.post(
        '${AuthRemoteDataSourceImpl.baseUrl}/auth/login',
        data: {'email': tEmail, 'password': tPassword},
      )).called(1);
    });
  });

  group('signUpUser', () {
    const String tName = 'Mr. User';
    const String tEmail = 'user@gmail.com';
    const String tPassword = 'userpassword';
    const String tUserId = '66bde36e9bbe07fc39034cdd';

    final tUserModel = const UserModel(id: tUserId, name: tName, email: tEmail);
    final tResponsePayload = {
      'statusCode': 201,
      'message': '',
      'data': {
        'id': tUserId,
        'name': tName,
        'email': tEmail,
      }
    };

    test('should return UserModel on successful registration (statusCode 201)', () async {
      // Arrange
      when(mockDio.post(any, data: anyNamed('data'))).thenAnswer(
        (_) async => Response(
          data: tResponsePayload,
          statusCode: 201,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      // Act
      final result = await dataSource.signUpUser(name: tName, email: tEmail, password: tPassword);

      // Assert
      expect(result, equals(tUserModel));
      verify(mockDio.post(
        '${AuthRemoteDataSourceImpl.baseUrl}/auth/register',
        data: {'name': tName, 'email': tEmail, 'password': tPassword},
      )).called(1);
    });

    test('should throw ServerException on non-201 status code for sign up', () async {
      // Arrange
      when(mockDio.post(any, data: anyNamed('data'))).thenAnswer(
        (_) async => Response(
          data: {},
          statusCode: 400,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      // Act
      final call = dataSource.signUpUser;

      // Assert
      expect(() => call(name: tName, email: tEmail, password: tPassword), throwsA(isA<ServerException>()));
      verify(mockDio.post(
        '${AuthRemoteDataSourceImpl.baseUrl}/auth/register',
        data: {'name': tName, 'email': tEmail, 'password': tPassword},
      )).called(1);
    });

    test('should throw ServerException on DioError for sign up', () async {
      // Arrange
      when(mockDio.post(any, data: anyNamed('data'))).thenThrow(
        DioException(requestOptions: RequestOptions(path: '')),
      );

      // Act
      final call = dataSource.signUpUser;

      // Assert
      expect(() => call(name: tName, email: tEmail, password: tPassword), throwsA(isA<ServerException>()));
      verify(mockDio.post(
        '${AuthRemoteDataSourceImpl.baseUrl}/auth/register',
        data: {'name': tName, 'email': tEmail, 'password': tPassword},
      )).called(1);
    });
  });

  group('getCurrentUser', () {
    const String tToken = 'bearer_token_123';
    const String tUserId = '66bde36e9bbe07fc39034cdd';
    const String tName = 'Mr. User';
    const String tEmail = 'user@gmail.com';

    final tUserModel = UserModel(id: tUserId, name: tName, email: tEmail);
    final tResponsePayload = {
      'statusCode': 200,
      'message': '',
      'data': {
        '_id': tUserId,
        'name': tName,
        'email': tEmail,
        '__v': 0
      }
    };

    test('should return UserModel on successful get current user (statusCode 200)', () async {
      // Arrange
      when(mockDio.get(any, options: anyNamed('options'))).thenAnswer(
        (_) async => Response(
          data: tResponsePayload,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      // Act
      final result = await dataSource.getCurrentUser(token: tToken);

      // Assert
      expect(result, equals(tUserModel));
      verify(mockDio.get(
        '${AuthRemoteDataSourceImpl.baseUrl}/users/me',
        options: anyNamed('options'), // Verify options are passed, but don't deep check here unless necessary
      )).called(1);
    });

    test('should throw ServerException on non-200 status code for get current user', () async {
      // Arrange
      when(mockDio.get(any, options: anyNamed('options'))).thenAnswer(
        (_) async => Response(
          data: {},
          statusCode: 401, // Unauthorized
          requestOptions: RequestOptions(path: ''),
        ),
      );

      // Act
      final call = dataSource.getCurrentUser;

      // Assert
      expect(() => call(token: tToken), throwsA(isA<ServerException>()));
      verify(mockDio.get(
        '${AuthRemoteDataSourceImpl.baseUrl}/users/me',
        options: anyNamed('options'),
      )).called(1);
    });

    test('should throw ServerException on DioError for get current user', () async {
      // Arrange
      when(mockDio.get(any, options: anyNamed('options'))).thenThrow(
        DioException(requestOptions: RequestOptions(path: '')),
      );

      // Act
      final call = dataSource.getCurrentUser;

      // Assert
      expect(() => call(token: tToken), throwsA(isA<ServerException>()));
      verify(mockDio.get(
        '${AuthRemoteDataSourceImpl.baseUrl}/users/me',
        options: anyNamed('options'),
      )).called(1);
    });
  });
}
