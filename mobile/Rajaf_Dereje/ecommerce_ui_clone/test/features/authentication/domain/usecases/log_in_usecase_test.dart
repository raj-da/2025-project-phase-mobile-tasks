import 'package:dartz/dartz.dart';
import 'package:ecommerce_ui_clone/core/error/failures.dart';
import 'package:ecommerce_ui_clone/features/authentication/domain/repository/auth_repository.dart';
import 'package:ecommerce_ui_clone/features/authentication/domain/usecase/log_in_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'log_in_usecase_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late LogInUsecase logInUsecase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    logInUsecase = LogInUsecase(repository: mockRepository);
  });

  const String name = 'test123';
  const String password = 'password123';
  const String expectedToken = 'access_token_123';

  test('should return an access tocken if logged in successfuly', () async {
    // Arrange
    when(
      mockRepository.logInUser(email: any, password: any),
    ).thenAnswer((_) async => const Right(expectedToken));

    // Act
    final result = await logInUsecase(name, password);

    // Assert
    verify(mockRepository.logInUser(email: name, password: password)).called(1);
    expect(result, const Right(expectedToken));
  });

  test('should return an Failure if logged fails', () async {
    // Arrange
    when(
      mockRepository.logInUser(email: any, password: any),
    ).thenAnswer((_) async => const Left(LogInFailure()));

    // Act
    final result = await logInUsecase(name, password);

    // Assert
    verify(mockRepository.logInUser(email: name, password: password)).called(1);
    expect(result, const Left(LogInFailure()));
  });
}
