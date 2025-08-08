import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/message_entity.dart';
import '../repositories/chat_repositories.dart';

class SendMessage {
  final ChatRepository repository;

  const SendMessage({required this.repository});

  Future<Either<Failure, void>> call({required MessageEntity message}) {
    return repository.sendMessage(message: message);
  }
}
