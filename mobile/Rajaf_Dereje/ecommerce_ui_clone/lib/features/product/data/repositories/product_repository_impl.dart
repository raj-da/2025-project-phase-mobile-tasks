import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_data_source.dart';
import '../datasources/product_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, void>> createproduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.createProduct(product as ProductModel);
        return Right(null);
      } on ServerException {
        return Left(ServerFailure('Server Error'));
      }
    } else {
      return Left(NetworkFailure('Lost Network connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteProduct(id);
        return Right(null);
      } on ServerException {
        return Left(ServerFailure('Server Error'));
      }
    } else {
      return Left(NetworkFailure('Lost Network connection'));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getAllProduct() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getAllProducts();
        await localDataSource.cacheProductList(remoteProducts);
        return Right(remoteProducts);
      } on ServerException {
        return Left(ServerFailure('Server Error'));
      }
    } else {
      try {
        final localProducts = await localDataSource.getCachedProducts();
        return Right(localProducts);
      } on CacheException {
        return Left(CachedFailure('Error no internet connection'));
      }
    }
  }

  @override
  Future<Either<Failure, Product?>> getProductById(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final product = await remoteDataSource.getProductById(id);
        return Right(product);
      } on ServerException {
        return Left(ServerFailure('Server Error'));
      }
    } else {
      return Left(NetworkFailure('Lost Network connection'));
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updateProduct(product as ProductModel);
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure('Server Error'));
      }
    } else {
      return Left(NetworkFailure('Lost Network connection'));
    }
  }
}
