abstract class AuthLocalDataSource {
  /// Fetches cached authentication token
  ///
  Future<String> getAuthToken();

  /// Caches an auth token
  ///
  Future<void> cacheAuthToken({required String authToken});

  /// Delets the auth token
  ///
  Future<void> deletedToken();
}
