// import 'dart:math';

// import 'dart:nativewrappers/_internal/vm/lib/math_patch.dart';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_ui_clone/core/error/exception.dart';
import 'package:ecommerce_ui_clone/core/error/failures.dart';
import 'package:ecommerce_ui_clone/core/network/network_info.dart';
import 'package:ecommerce_ui_clone/features/product/data/datasources/product_local_data_source.dart';
import 'package:ecommerce_ui_clone/features/product/data/datasources/product_remote_data_source.dart';
import 'package:ecommerce_ui_clone/features/product/data/models/product_model.dart';
import 'package:ecommerce_ui_clone/features/product/data/repositories/product_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

//* This annotation tells build_runner to generate a file with mock classes
//* for the classes listed here.
//* Run flutter pub run build_runner build
@GenerateMocks([ProductRemoteDataSource, ProductLocalDataSource, NetworkInfo])
import 'product_repository_impl_test.mocks.dart';

void main() {
  late ProductRepositoryImpl repository;
  late MockProductRemoteDataSource mockRemoteDataSource;
  late MockProductLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockProductRemoteDataSource();
    mockLocalDataSource = MockProductLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ProductRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  //* A helper function to run tests for both online and offline states
  void runTestsOnline(void Function() body) {
    group('device is online', () {
      setUp(() {
        // Stubbing: Tell mockito that whenever a function (in this case isConnected) is called,
        // it should return or behave a specific way
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(void Function() body) {
    group('device is offline', () {
      setUp(() {
        // Stubbing: Tell mockito that whenever a function (in this case isConnected) is called,
        // it should return or behave a specific way
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('getAllProduct', () {
    final tProductModelList = [
      const ProductModel(
        name: 'test',
        price: 'test',
        description: 'test',
        imageUrl: 'test',
        id: '1',
      ),
    ];

    // The entity list is what the UI layer expects
    final List<ProductModel> tProductList = tProductModelList;

    test('Should check if the device is online', () async {
      // Arrange
      // We set up the online state to ensure the test runs.
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // We need to stub the remote data source call to avoid an exception
      when(mockRemoteDataSource.getAllProducts()).thenAnswer((_) async => []);

      // Act
      await repository.getAllProduct();

      // Assert
      // Vertification: We check that the isConnected getter was called exactly once.
      // This confirms our repository's first step is to check the network status.
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
        'Should return remote data when the call to remote data source is successful',
        () async {
          // Arrange
          // Stubbing: When getAllProduct is called on the remote mock,
          // return our predefined list of product models.
          when(
            mockRemoteDataSource.getAllProducts(),
          ).thenAnswer((_) async => tProductModelList);

          // Act
          final result = await repository.getAllProduct();

          // Assert
          // Verification: Check if getAllProduct() was actually called on the remote source.
          verify(mockRemoteDataSource.getAllProducts());
          // Check that the result is a 'Right' containing oour product list.
          expect(result, equals(Right(tProductList)));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // Arrange
          when(
            mockRemoteDataSource.getAllProducts(),
          ).thenAnswer((_) async => tProductModelList);

          // Act
          await repository.getAllProduct();

          // Assert
          // Vertificatioin: Check that getAllProducts from remote was called.
          verify(mockRemoteDataSource.getAllProducts());
          // vertification: Check that we tried to cache the result.
          verify(mockLocalDataSource.cacheProductList(tProductModelList));
        },
      );

      test(
        'should return server failure when the call to remote data source fails',
        () async {
          // Arrange
          // Stubbing: Tell the mock to throw a ServerException when called.
          when(
            mockRemoteDataSource.getAllProducts(),
          ).thenThrow(ServerException());

          // Act
          final result = await repository.getAllProduct();

          //  Assert
          // We except the repository to catch the ServerException and return a Left(ServerFailure).
          expect(result, equals(const Left((ServerFailure()))));
        },
      );
    }); // runTestsOnline()

    runTestsOffline(() {
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          // Arrangematcher
          // Stubbing: Tell the local mock to return our product list.
          when(
            mockLocalDataSource.getCachedProducts(),
          ).thenAnswer((_) async => tProductModelList);

          // Act
          final result = await repository.getAllProduct();

          // Assert
          // Vertification: Check that we did not call the remote data source.
          verifyZeroInteractions(mockRemoteDataSource);
          // Vertification: Check that we called the local data source to get data.
          verify(mockLocalDataSource.getCachedProducts());
          // check that the result is the cahced list.
          expect(result, equals(Right(tProductList)));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // Arrange
          // Stubbing: Tell the local mock to throe an exception.
          when(
            mockLocalDataSource.getCachedProducts(),
          ).thenThrow(CacheException());

          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

          // Act
          final result = await repository.getAllProduct();

          // Assert
          // Verification: we did not call the remote source.
          verifyZeroInteractions(mockRemoteDataSource);
          // Verification: We tried to get data from the local source.
          verify(mockLocalDataSource.getCachedProducts());
          // Check that we got a CacheFailure.
          expect(result, const Left(CachedFailure()));
        },
      );
    }); // ofline test
  }); // get all product group

  group('Delete product', () {
    String id = 'AB';
    runTestsOnline(() {
      test('Should check if the deveice is online', () async {
        // Arrange
        when(
          mockRemoteDataSource.deleteProduct(any),
        ).thenAnswer((_) async => Future.value()); // Mocking a void Future

        // Act
        final result = await repository.deleteProduct(id);

        // Assert
        verify(mockNetworkInfo.isConnected);
        verify(mockRemoteDataSource.deleteProduct(id));
        expect(result, equals(const Right(null)));
      });

      test(
        'Should return ServerFaliur if connection to remoteDataSource is uncessesful',
        () async {
          // Arrange
          when(
            mockRemoteDataSource.deleteProduct(id),
          ).thenThrow(ServerException());

          final result = await repository.deleteProduct(id);
          // Assert
          verify(mockRemoteDataSource.deleteProduct(any));
          expect(result, const Left(ServerFailure()));
        },
      );
    }); // online test

    runTestsOffline(() {
      test('Should return NetworkFailure when device is offline', () async {
        // Act
        final result = await repository.deleteProduct(id);

        // Assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, const Left(NetworkFailure()));
      });
    });
  }); // delete product group

  group('Create product', () {
    ProductModel tproductModel = const ProductModel(
      name: 'test',
      price: 'test',
      description: 'test',
      imageUrl: 'test',
      id: '1',
    );

    runTestsOnline(() {
      test('Should check if the deveice is online', () async {
        // Arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(
          mockRemoteDataSource.createProduct(any),
        ).thenAnswer((_) async => Future.value());

        // Act
        final result = await repository.createproduct(tproductModel);

        // Assert
        verify(mockNetworkInfo.isConnected);
        verify(mockRemoteDataSource.createProduct(tproductModel));
        expect(result, equals(const Right(null)));
      });

      test(
        'Should return ServerFaliur if connection to remoteDataSource is uncessesful',
        () async {
          // Arrange
          when(
            mockRemoteDataSource.createProduct(any),
          ).thenThrow(ServerException());

          // Act
          final result = await repository.createproduct(tproductModel);
          // Assert
          verify(mockRemoteDataSource.createProduct(any));
          expect(result, const Left(ServerFailure()));
        },
      );
    }); // online test

    runTestsOffline(() {
      test('Should return NetworkFailure when device is offline', () async {
        // Act
        final result = await repository.createproduct(tproductModel);

        // Assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, const Left(NetworkFailure()));
      });
    }); // offline test
  }); // create product group

  group('get product by id', () {
    String id = '1';
    ProductModel tproductModel = const ProductModel(
      name: 'test',
      price: 'test',
      description: 'test',
      imageUrl: 'test',
      id: '1',
    );

    runTestsOnline(() {
      test('Should check if the deveice is online', () async {
        // Arrange
        when(
          mockRemoteDataSource.getProductById(any),
        ).thenAnswer((_) async => tproductModel);

        // Act
        final result = await repository.getProductById(id);

        // Assert
        verify(mockNetworkInfo.isConnected);
        verify(mockRemoteDataSource.getProductById(id));
        expect(result, Right(tproductModel));
      });

      test(
        'Should return ServerFaliur if connection to remoteDataSource is uncessesful',
        () async {
          // Arrange
          when(
            mockRemoteDataSource.getProductById(any),
          ).thenThrow(ServerException());

          // Act
          final result = await repository.getProductById(id);
          // Assert
          verify(mockRemoteDataSource.getProductById(id));
          expect(result, const Left(ServerFailure()));
        },
      );
    }); // online test

    runTestsOffline(() {
      test('Should return NetworkFailure when device is offline', () async {
        // Act
        final result = await repository.getProductById(id);

        // Assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, const Left(NetworkFailure()));
      });
    }); // offline test
  }); // get product by id group

  group('updateProduct', () {
    ProductModel tProductModel = const ProductModel(
      name: 'test',
      price: 'test',
      description: 'test',
      imageUrl: 'test',
      id: '1',
    );

    runTestsOnline(() {
      test(
        'should call remote data source and return success (Right(null))',
        () async {
          // Arrange
          when(
            mockRemoteDataSource.updateProduct(any),
          ).thenAnswer((_) async => Future.value());
          // Act
          final result = await repository.updateProduct(tProductModel);
          // Assert
          verify(mockRemoteDataSource.updateProduct(tProductModel));
          expect(result, equals(const Right(null)));
        },
      );

      test(
        'should return ServerFailure when the call to remote data source is unsuccessful',
        () async {
          // Arrange
          when(
            mockRemoteDataSource.updateProduct(any),
          ).thenThrow(ServerException());
          // Act
          final result = await repository.updateProduct(tProductModel);
          // Assert
          verify(mockRemoteDataSource.updateProduct(tProductModel));
          expect(result, const Left(ServerFailure()));
        },
      );
    }); // online test

    runTestsOffline(() {
      test('should return NetworkFailure when device is offline', () async {
        // Act
        final result = await repository.updateProduct(tProductModel);
        // Assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, const Left(NetworkFailure()));
      });
    }); // offline test
  }); // update product group
}
