import 'package:dartz/dartz.dart';
import 'package:ecommerce_ui_clone/core/error/failures.dart';
import 'package:ecommerce_ui_clone/core/success/success.dart';
import 'package:ecommerce_ui_clone/features/authentication/domain/repository/auth_repository.dart';
import 'package:ecommerce_ui_clone/features/authentication/domain/usecase/log_out_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'log_in_usecase_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late LogOutUsecase logOutUsecase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    logOutUsecase = LogOutUsecase(repository: mockRepository);
  });

  test('should return an access tocken if logging out successfuly', () async {
    // Arrange
    when(
      mockRepository.logOutUser(),
    ).thenAnswer((_) async => const Right(LogOutSuccess()));

    // Act
    final result = await logOutUsecase();

    // Assert
    verify(mockRepository.logOutUser()).called(1);
    expect(result, const Right(LogOutSuccess()));
  });

  test('should return an Failure if logging out fails', () async {
    // Arrange
    when(
      mockRepository.logOutUser(),
    ).thenAnswer((_) async => const Left(LogOutFailure()));

    // Act
    final result = await logOutUsecase();

    // Assert
    verify(mockRepository.logOutUser()).called(1);
    expect(result, const Left(LogOutFailure()));
  });
}
