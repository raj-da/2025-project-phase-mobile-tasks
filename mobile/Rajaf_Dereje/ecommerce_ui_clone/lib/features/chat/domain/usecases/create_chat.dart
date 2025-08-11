import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/chat_entity.dart';
import '../repositories/chat_repositories.dart';

class CreateChat {
  final ChatRepository repository;

  const CreateChat({required this.repository});
  Future<Either<Failure, ChatEntity>> call({required userId}) {
    return repository.createChat(userId: userId);
  }
}
