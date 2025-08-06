import 'package:ecommerce_ui_clone/core/error/exception.dart';
import 'package:ecommerce_ui_clone/features/authentication/data/datasource/auth_local_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Import the generated mock file
import 'auth_data_source_test.mocks.mocks.dart'; // Make sure this path is correct

void main() {
  late AuthLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = AuthLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('cacheAuthToken', () {
    const String tAuthToken = 'test_auth_token';

    test('should call setString on SharedPreferences with the correct key and token', () async {
      // Arrange
      when(mockSharedPreferences.setString(any, any)).thenAnswer((_) async => true);

      // Act
      await dataSource.cacheAuthToken(authToken: tAuthToken);

      // Assert
      verify(mockSharedPreferences.setString(CACHED_AUTH_TOKEN, tAuthToken)).called(1);
    });

    test('should throw a CacheException when setString fails', () async {
      // Arrange
      when(mockSharedPreferences.setString(any, any)).thenAnswer((_) async => false);

      // Act
      final call = dataSource.cacheAuthToken;

      // Assert
      expect(() => call(authToken: tAuthToken), throwsA(isA<CacheException>()));
      verify(mockSharedPreferences.setString(CACHED_AUTH_TOKEN, tAuthToken)).called(1);
    });
  });

  group('deletedToken', () {
    test('should call remove on SharedPreferences with the correct key', () async {
      // Arrange
      when(mockSharedPreferences.remove(any)).thenAnswer((_) async => true);

      // Act
      await dataSource.deletedToken();

      // Assert
      verify(mockSharedPreferences.remove(CACHED_AUTH_TOKEN)).called(1);
    });

    test('should throw a CacheException when remove fails', () async {
      // Arrange
      when(mockSharedPreferences.remove(any)).thenAnswer((_) async => false);

      // Act
      final call = dataSource.deletedToken;

      // Assert
      expect(() => call(), throwsA(isA<CacheException>()));
      verify(mockSharedPreferences.remove(CACHED_AUTH_TOKEN)).called(1);
    });
  });

  group('getAuthToken', () {
    const String tAuthToken = 'test_auth_token';

    test('should return the cached token when it exists', () async {
      // Arrange
      when(mockSharedPreferences.getString(any)).thenReturn(tAuthToken);

      // Act
      final result = await dataSource.getAuthToken();

      // Assert
      expect(result, equals(tAuthToken));
      verify(mockSharedPreferences.getString(CACHED_AUTH_TOKEN)).called(1);
    });

    test('should throw a CacheException when no token is cached', () async {
      // Arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      // Act
      final call = dataSource.getAuthToken;

      // Assert
      expect(() => call(), throwsA(isA<CacheException>()));
      verify(mockSharedPreferences.getString(CACHED_AUTH_TOKEN)).called(1);
    });
  });
}
