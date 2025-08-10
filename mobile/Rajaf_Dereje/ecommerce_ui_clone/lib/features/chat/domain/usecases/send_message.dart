import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/chat_repositories.dart';

class SendMessage {
  final ChatRepository repository;

  const SendMessage({required this.repository});

  Future<Either<Failure, void>> call({required String chatId, required String content, String type = 'text'}) {
    return repository.sendMessage(chatId: chatId, content: content, type: type);
  }
}
