import '../models/message_model.dart';

abstract class ChatSocketDataSource {
  void connect();
  void disconnect();
  void sendMessage({
    required String chatId,
    required String content,
    required String type,
  });

  Stream<MessageModel> onMessageDelivered();
  Stream<MessageModel> onMessageReceived();
}
