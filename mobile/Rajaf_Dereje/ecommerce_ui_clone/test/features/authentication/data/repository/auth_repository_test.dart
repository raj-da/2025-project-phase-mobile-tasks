import 'package:dartz/dartz.dart';
import 'package:ecommerce_ui_clone/core/error/exception.dart';
import 'package:ecommerce_ui_clone/core/error/failures.dart';
import 'package:ecommerce_ui_clone/core/network/network_info.dart';
import 'package:ecommerce_ui_clone/core/success/success.dart';
import 'package:ecommerce_ui_clone/features/authentication/data/datasource/auth_local_data_source.dart';
import 'package:ecommerce_ui_clone/features/authentication/data/datasource/auth_remote_data_source.dart';
import 'package:ecommerce_ui_clone/features/authentication/data/model/user_model.dart';
import 'package:ecommerce_ui_clone/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:ecommerce_ui_clone/features/authentication/domain/entity/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'auth_repository_test.mocks.dart';

@GenerateMocks([AuthLocalDataSource, AuthRemoteDataSource, NetworkInfo])
void main() {
  late AuthRepositoryImpl repository;
  late MockAuthLocalDataSource mockLocalDataSource;
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockLocalDataSource = MockAuthLocalDataSource();
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repository = AuthRepositoryImpl(
      authRemoteDataSource: mockRemoteDataSource,
      authLocalDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('logInUser', () {
    const id = 'testID';
    const name = 'testName';
    const email = 'test@example.com';
    const password = '123456';
    const token = 'abc123';

    test('should return User model when login is successful', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        mockRemoteDataSource.logInUser(email: email, password: password),
      ).thenAnswer((_) async => token);

      when(
        mockLocalDataSource.cacheAuthToken(authToken: token),
      ).thenAnswer((_) async => Future.value());

      when(mockRemoteDataSource.getCurrentUser(token: token)).thenAnswer((
        _,
      ) async {
        final value = const UserModel(id: id, email: email, name: name);
        return value;
      });

      // Act
      final result = await repository.logInUser(
        email: email,
        password: password,
      );

      // Assert
      expect(result, const Right(User(id: id, email: email, name: name)));
      verify(mockRemoteDataSource.logInUser(email: email, password: password));
      verify(mockLocalDataSource.cacheAuthToken(authToken: token));
    });

    test('should return ServerFailure on server exception', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        mockRemoteDataSource.logInUser(email: email, password: password),
      ).thenThrow(ServerException());

      final result = await repository.logInUser(
        email: email,
        password: password,
      );

      expect(
        result,
        equals(const Left(ServerFailure(messege: 'Server Error logging in'))),
      );
    });

    test('should return NetworkFailure when device is offline', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.logInUser(
        email: email,
        password: password,
      );

      expect(result, equals(const Left(NetworkFailure())));
    });
  }); // log in user group

  group('signUpUser', () {
    const name = 'User';
    const email = 'test@example.com';
    const password = '123456';

    test('should return SignUpSuccess when sign up is successful', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        mockRemoteDataSource.signUpUser(
          name: name,
          email: email,
          password: password,
        ),
      ).thenAnswer(
        (_) async => const UserModel(id: '1', name: name, email: email),
      );

      // Act
      final result = await repository.signUpUser(
        name: name,
        email: email,
        password: password,
      );

      // Assert

      expect(result, equals(const Right(SignUpSucess())));
    });

    test('should return CacheFailure on cache error', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        mockRemoteDataSource.signUpUser(
          name: name,
          email: email,
          password: password,
        ),
      ).thenThrow(CacheException());

      final result = await repository.signUpUser(
        name: name,
        email: email,
        password: password,
      );

      expect(
        result,
        equals(const Left(CachedFailure(messege: 'Error deleting token'))),
      );
    });

    test('should return NetworkFailure when offline', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.signUpUser(
        name: name,
        email: email,
        password: password,
      );

      expect(result, equals(const Left(NetworkFailure())));
    });
  }); // sign up user group

  group('logoutUser', () {
    test('should return LogOutSuccess when logout succeeds', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        mockLocalDataSource.deletedToken(),
      ).thenAnswer((_) async => Future.value());

      final result = await repository.logOutUser();

      expect(result, equals(const Right(LogOutSuccess())));
      verify(mockLocalDataSource.deletedToken());
    });

    test('should return CachedFailure on error deleting token', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockLocalDataSource.deletedToken()).thenThrow(CacheException());

      final result = await repository.logOutUser();

      expect(
        result,
        equals(const Left(CachedFailure(messege: 'Error deleting token'))),
      );
    });

    test('should return NetworkFailure when offline', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.logOutUser();

      expect(result, equals(const Left(NetworkFailure())));
    });
  }); // log out user group
}
