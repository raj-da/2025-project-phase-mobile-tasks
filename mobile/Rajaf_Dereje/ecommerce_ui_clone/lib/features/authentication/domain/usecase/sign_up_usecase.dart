import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/success/success.dart';
import '../repository/auth_repository.dart';

class SignUpUsecase {
  final AuthRepository repository;

  SignUpUsecase({required this.repository});
  Future<Either<Failure, Success>> call (name, email, password) async{
    return await repository.signUpUser(name: name, email: email, password: password);
  }
}
