import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/chat_entity.dart';
import '../repositories/chat_repositories.dart';

class GetUserChats {
  final ChatRepository repository;

  const GetUserChats({required this.repository});

  Future<Either<Failure, List<ChatEntity>>> call() {
    return repository.getChats();
  }
}