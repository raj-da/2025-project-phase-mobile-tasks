import '../entities/message_entity.dart';
import '../repositories/chat_repositories.dart';

class ListenForDeliveredMessages {
  final ChatRepository repository;

  const ListenForDeliveredMessages({required this.repository});

  // It also calls the repository and returns its stream.
  Stream<MessageEntity> call() {
    return repository.onMessageDelivered();
  }
}
