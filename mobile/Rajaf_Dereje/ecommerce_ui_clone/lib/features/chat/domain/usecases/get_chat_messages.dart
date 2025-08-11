import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/message_entity.dart';
import '../repositories/chat_repositories.dart';

class GetChatMessages {
  final ChatRepository repository;

  const GetChatMessages({required this.repository});

  Future<Either<Failure, List<MessageEntity>>> call({required String chatId}) {
    return repository.getMessages(chatId: chatId);
  }
}
