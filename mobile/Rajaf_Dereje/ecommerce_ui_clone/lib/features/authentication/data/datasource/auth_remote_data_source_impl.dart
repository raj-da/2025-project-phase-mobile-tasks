import 'package:dio/dio.dart';

import '../../../../core/error/exception.dart';
import '../model/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  static const String baseUrl =
      'https://g5-flutter-learning-path-be.onrender.com/api/v2';

  @override
  Future<UserModel> getCurrentUser({required String token}) async {
   try {
    final response = await dio.get(
      '$baseUrl/users/me',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode == 200) {
      final userJson = response.data['data'];
      return UserModel(
        id: userJson['_id'],
        name: userJson['name'],
        email: userJson['email'],
      );
    } else {
      throw ServerException();
    }
  } catch (e) {
    throw ServerException();
  }
  }

  @override
  Future<String> logInUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '$baseUrl/auth/login',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 201) {
        return response.data['data']['access_token'];
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> signUpUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '$baseUrl/auth/register',
        data: {'name': name, 'email': email, 'password': password},
      );

      if (response.statusCode == 201) {
        final userJson = response.data['data'];
        return UserModel(
          id: userJson['id'],
          name: userJson['name'],
          email: userJson['email'],
        );
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
