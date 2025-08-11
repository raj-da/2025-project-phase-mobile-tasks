import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../authentication/domain/entity/user.dart';
import '../repositories/chat_repositories.dart';

class GetLoggedUser {
  final ChatRepository repository;

  GetLoggedUser({required this.repository});
  Future<Either<Failure, User>> call() {
    return repository.getLoggedUser();
  }
}
