import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/success/success.dart';
import '../repository/auth_repository.dart';

class LogOutUsecase {
  final AuthRepository repository;

  LogOutUsecase({required this.repository});
  Future<Either<Failure, Success>> call () async{
    return await repository.logOutUser();
  }
}