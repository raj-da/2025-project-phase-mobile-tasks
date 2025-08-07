import '../model/user_model.dart';

abstract class AuthRemoteDataSource {
  /// Sign in a user
  ///
  Future<UserModel> signUpUser({required String name, required String email, required String password});

  /// Logs in a user
  ///
  Future<String> logInUser({required String email, required String password});

  /// get user information
  /// 
  Future<UserModel> getCurrentUser({required String token});
}
