import '../models/message_model.dart';

abstract class ChatSocketDataSource {
  void connect();
  void disconnect();
  void sendMessage({
    required String chatId,
    required String content,
    required String type,
  });

  void onMessageDelivered(Function(MessageModel) callback);
  void onMessageReceived(Function(MessageModel) callback);
}
