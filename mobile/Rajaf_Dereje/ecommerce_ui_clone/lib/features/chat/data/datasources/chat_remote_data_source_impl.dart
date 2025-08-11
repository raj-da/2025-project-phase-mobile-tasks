import 'package:dio/dio.dart';

import '../../../../core/error/exception.dart';
import '../../../authentication/data/datasource/auth_local_data_source.dart';
import '../../../authentication/data/datasource/auth_remote_data_source.dart';
import '../../../authentication/data/model/user_model.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';
import 'chat_remote_data_source.dart';

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final Dio dio;
  final AuthLocalDataSource authLocalDataSource;
  final AuthRemoteDataSource authRemoteDataSource;

  static const String baseUrl =
      'https://g5-flutter-learning-path-be-tvum.onrender.com/api/v3';

  ChatRemoteDataSourceImpl({
    required this.dio,
    required this.authLocalDataSource,
    required this.authRemoteDataSource,
  });

  @override
  Future<UserModel> getLoggedUser() async {
    return authRemoteDataSource.getCurrentUser(token: await getToken());
  }

  @override
  Future<String> getToken() async {
    return await authLocalDataSource.getAuthToken();
  }

  @override
  Future<List<UserModel>> getAllUsers({required String token}) async {
    try {
      final response = await dio.get(
        '$baseUrl/users',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200) {
        final users = response.data['data'] as List;
        return users.map((e) => UserModel.fromJson(e)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<ChatModel>> getUserChats({required String token}) async {
    try {
      final response = await dio.get(
        '$baseUrl/chats/',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200) {
        final chats = response.data['data'] as List;
        return chats.map((e) => ChatModel.fromJson(e)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<MessageModel>> getChatMessages({
    required String chatId,
    required String token,
  }) async {
    try {
      final response = await dio.get(
        '$baseUrl/chats/$chatId/messages',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200) {
        final messages = response.data['data'] as List;
        return messages.map((e) => MessageModel.fromJson(e)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<ChatModel> initiateChat({
    required String userId,
    required String token,
  }) async {
    try {
      final response = await dio.post(
        '$baseUrl/chats',
        data: {'userId': userId},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 201) {
        return ChatModel.fromJson(response.data['data']);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteChat({
    required String chatId,
    required String token,
  }) async {
    try {
      final response = await dio.delete(
        '$baseUrl/chats/$chatId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<MessageModel> sendMessage({
    required String chatId,
    required String content,
    required String type,
    required String token,
  }) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }
}
