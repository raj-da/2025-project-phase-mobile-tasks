import '../entities/message_entity.dart';
import '../repositories/chat_repositories.dart';

class ListenForReceivedMessages {
  final ChatRepository repository;

  const ListenForReceivedMessages({required this.repository});

  // It calls the repository and returns the stream directly.
  Stream<MessageEntity> call() {
    return repository.onMessageReceived();
  }
}
