import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/chat_repositories.dart';

class DeleteChat {
  final ChatRepository repository;

  const DeleteChat({required this.repository});

  Future<Either<Failure, void>> call({required String chatId}) {
    return repository.deleteChat(chatId: chatId);
  }
}
