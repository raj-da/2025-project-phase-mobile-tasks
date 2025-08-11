import 'dart:async';

import 'package:flutter/rendering.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../authentication/data/datasource/auth_local_data_source.dart';
import '../models/message_model.dart';
import 'chat_socket_data_source.dart';

class ChatSocketDataSourceImpl implements ChatSocketDataSource {
  IO.Socket? _socket;
  final String _baseUrl = 'wss://g5-flutter-learning-path-be-tvum.onrender.com';
  final AuthLocalDataSource authLocalDataSource;

  // create StreamControllers
  final _messageReceivedController = StreamController<MessageModel>.broadcast();
  final _messageDeliveredController =
      StreamController<MessageModel>.broadcast();

  ChatSocketDataSourceImpl({required this.authLocalDataSource});

  @override
  Future<void> connect() async {
    try {
      final token = await authLocalDataSource.getAuthToken();
      debugPrint('#################token: $token#################');

      _socket = IO.io(
        _baseUrl,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableForceNew()
            .enableAutoConnect()
            .setExtraHeaders({
              'Authorization': 'Bearer $token', // ✅ same as Postman
            })
            .build(),
      );

      // Set up listeners to add data to the streams
      _socket!.on('message:received', (data) {
        _messageReceivedController.add(MessageModel.fromJson(data));
      });

      _socket!.on('message:delivered', (data) {
        _messageDeliveredController.add(MessageModel.fromJson(data));
      });

      _socket!.connect();

      _socket!.onConnect((_) {
        debugPrint('✅ Socket connected successfully!');
      });

      _socket!.onConnectError((err) {
        debugPrint('❌ Connection error: $err');
      });

      _socket!.onDisconnect((_) {
        debugPrint('🔌 Socket disconnected');
      });
    } catch (e) {
      debugPrint('⚠️ Failed to connect to socket: $e');
    }
  }

  @override
  void disconnect() {
    _socket?.disconnect();
  }

  @override
  void sendMessage({
    required String chatId,
    required String content,
    required String type,
  }) {
    _socket?.emit('message:send', {
      'chatId': chatId,
      'content': content,
      'type': type,
    });
  }

  @override
  Stream<MessageModel> onMessageDelivered() {
    return _messageDeliveredController.stream;
  }

  @override
  Stream<MessageModel> onMessageReceived() {
    return _messageReceivedController.stream;
  }

  void dispose() {
    _messageReceivedController.close();
    _messageDeliveredController.close();
    disconnect();
  }
}
