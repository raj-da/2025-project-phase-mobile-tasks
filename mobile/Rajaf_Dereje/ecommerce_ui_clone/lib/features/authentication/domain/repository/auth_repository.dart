import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/success/success.dart';

abstract class AuthRepository {
  Future<Either<Failure, Success>> signUpUser({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, void>> logInUser({required String email,  required String password});
  Future<Either<Failure, Success>> logOutUser();
}
