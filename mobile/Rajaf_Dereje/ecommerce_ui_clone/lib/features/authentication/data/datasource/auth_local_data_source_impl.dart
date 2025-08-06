import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';
import 'auth_local_data_source.dart';

const CACHED_AUTH_TOKEN = 'CACHED_AUTH_TOKEN';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheAuthToken({required String authToken}) async {
    final success = await sharedPreferences.setString(
      CACHED_AUTH_TOKEN,
      authToken,
    );
    if (!success) throw CacheException();
  }

  @override
  Future<void> deletedToken() async {
    final success = await sharedPreferences.remove(CACHED_AUTH_TOKEN);
    if (!success) throw CacheException();
  }

  @override
  Future<String> getAuthToken() async {
    final token = sharedPreferences.getString(CACHED_AUTH_TOKEN);
    if (token == null) throw CacheException();
    return token;
  }
}
