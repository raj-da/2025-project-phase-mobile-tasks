

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repository/auth_repository.dart';

class LogInUsecase {
  final AuthRepository repository;

  LogInUsecase({required this.repository});
  Future<Either<Failure, void>> call(email, password) async {
    return await repository.logInUser(email: email, password: password);
  }
}

