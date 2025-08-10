import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../models/message_model.dart';
import 'chat_socket_data_source.dart';

class ChatSocketDataSourceImpl implements ChatSocketDataSource {
  late IO.Socket _socket;
  final String _baseUrl = 'wss://g5-flutter-learning-path-be-tvum.onrender.com';

  @override
  void connect() {
    _socket = IO.io(
      _baseUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );
    _socket.connect();
  }

  @override
  void disconnect() {
    _socket.disconnect();
  }

  @override
  void sendMessage({
    required String chatId,
    required String content,
    required String type,
  }) {
    _socket.emit('message:send', {
      'chatId': chatId,
      'content': content,
      'type': type,
    });
  }

  @override
  void onMessageDelivered(Function(MessageModel p1) callback) {
    _socket.on('message:delivered', (data) {
      callback(MessageModel.fromJson(data));
    });
  }

  @override
  void onMessageReceived(Function(MessageModel p1) callback) {
    _socket.on('message:received', (data) {
      callback(MessageModel.fromJson(data));
    });
  }
}
