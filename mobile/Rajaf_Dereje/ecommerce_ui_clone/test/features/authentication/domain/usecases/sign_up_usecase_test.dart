import 'package:dartz/dartz.dart';
import 'package:ecommerce_ui_clone/core/error/failures.dart';
import 'package:ecommerce_ui_clone/core/success/success.dart';
import 'package:ecommerce_ui_clone/features/authentication/domain/repository/auth_repository.dart';
import 'package:ecommerce_ui_clone/features/authentication/domain/usecase/sign_up_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'log_in_usecase_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late SignUpUsecase signUpUsecase;
  late MockAuthRepository mockRepository;

  const String name = 'test123';
  const String password = 'password123';
  const String email = 'email123@gmail.com';

  setUp(() {
    mockRepository = MockAuthRepository();
    signUpUsecase = SignUpUsecase(repository: mockRepository);
  });

  test('should return an Success if SignIn successfuly', () async {
    // Arrange
    when(
      mockRepository.signUpUser(
        name: anyNamed('name'),
        email: anyNamed('email'),
        password: anyNamed('password'),
      ),
    ).thenAnswer((_) async => const Right(SignUpSucess()));

    // Act
    final result = await signUpUsecase(name, email, password);

    // Assert
    verify(
      mockRepository.signUpUser(name: name, email: email, password: password),
    ).called(1);
    expect(result, const Right(SignUpSucess()));
  });

  test('should return an Failure if Sign in fails', () async {
    // Arrange
    when(
      mockRepository.signUpUser(
        name: anyNamed('name'),
        email: anyNamed('email'),
        password: anyNamed('password'),
      ),
    ).thenAnswer((_) async => const Left(SignInFailure()));

    // Act
    final result = await signUpUsecase(name, email, password);

    // Assert
    verify(
      mockRepository.signUpUser(name: name, email: email, password: password),
    ).called(1);
    expect(result, const Left(SignInFailure()));
  });
}
