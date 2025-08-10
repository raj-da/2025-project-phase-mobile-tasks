import 'package:flutter/rendering.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../authentication/data/datasource/auth_local_data_source.dart';
import '../models/message_model.dart';
import 'chat_socket_data_source.dart';

class ChatSocketDataSourceImpl implements ChatSocketDataSource {
  late IO.Socket _socket;
  final String _baseUrl = 'wss://g5-flutter-learning-path-be-tvum.onrender.com';
  final AuthLocalDataSource authLocalDataSource;

  ChatSocketDataSourceImpl({required this.authLocalDataSource});

  @override
  Future<void> connect() async {
    try {
      final token = await authLocalDataSource.getAuthToken();

      _socket = IO.io(
        _baseUrl,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .setExtraHeaders({
              'Authorization': 'Bearer $token', // ✅ same as Postman
            })
            .disableAutoConnect()
            .build(),
      );
      _socket.connect();

      _socket.onConnect((_) {
        debugPrint('✅ Socket connected successfully!');
      });

      _socket.onConnectError((err) {
        debugPrint('❌ Connection error: $err');
      });

      _socket.onDisconnect((_) {
        debugPrint('🔌 Socket disconnected');
      });
    } catch (e) {
      debugPrint('⚠️ Failed to connect to socket: $e');
    }
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
