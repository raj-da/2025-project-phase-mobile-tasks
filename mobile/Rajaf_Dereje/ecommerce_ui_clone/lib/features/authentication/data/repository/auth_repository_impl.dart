import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/success/success.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasource/auth_local_data_source.dart';
import '../datasource/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource authLocalDataSource;
  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, void>> logInUser({
    required String email,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await authRemoteDataSource.logInUser(
          email: email,
          password: password,
        );
        await authLocalDataSource.cacheAuthToken(authToken: token);
        return const Right(null);
      } on ServerException {
        return const Left(ServerFailure(messege: 'Server Error logging in'));
      } on CacheException {
        return const Left(CachedFailure(messege: 'Error Saving token'));
      }
    } else {
      return const Left((NetworkFailure()));
    }
  }

  @override
  Future<Either<Failure, Success>> logOutUser() async {
    if (await networkInfo.isConnected) {
      try {
        await authLocalDataSource.deletedToken();
        return const Right(LogOutSuccess());
      } on CacheException {
        return const Left(CachedFailure(messege: 'Error deleting token'));
      }
    } else {
      return const Left((NetworkFailure()));
    }
  }

  @override
  Future<Either<Failure, Success>> signUpUser({
    required String name,
    required String email,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDataSource.signUpUser(
          name: name,
          email: email,
          password: password,
        );
        return const Right(SignUpSucess());
      } on CacheException {
        return const Left(CachedFailure(messege: 'Error deleting token'));
      }
    } else {
      return const Left((NetworkFailure()));
    }
  }
}
