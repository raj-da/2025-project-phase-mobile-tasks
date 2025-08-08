import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../authentication/domain/entity/user.dart';
import '../repositories/chat_repositories.dart';

class GetAllUsers {
  final ChatRepository repository;

  const GetAllUsers({required this.repository});

  Future<Either<Failure, List<User>>> call() {
    return repository.getUsers();
  }
}