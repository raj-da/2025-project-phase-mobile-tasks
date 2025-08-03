import 'package:dio/dio.dart';
import 'package:ecommerce_ui_clone/core/error/exception.dart';
import 'package:ecommerce_ui_clone/features/product/data/datasources/product_remote_data_source_impl.dart';
import 'package:ecommerce_ui_clone/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late ProductRemoteDataSourceImpl dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = ProductRemoteDataSourceImpl(dio: mockDio);
  });

  group('getAllProducts', () {
    // dummy response for testing
    //todo: Fix price to double
    final responsePayload = {
      'statusCode': 200,
      'message': '',
      'data': [
        {
          'id': '123',
          'name': 'Anime website',
          'description': 'Explore anime characters.',
          'price': '123',
          'imageUrl': 'https://example.com/image.jpg',
        },
      ],
    };

    test(
      'should return List<Productmodel> when response code is 200 ',
      () async {
        // Arrange
        when(mockDio.get(any)).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: ''),
            data: responsePayload,
            statusCode: 200,
          ),
        );

        // Act
        final result = await dataSource.getAllProducts();

        // Assert
        expect(result, isA<List<ProductModel>>());
        expect(result.first.id, '123');
        verify(mockDio.get(any)).called(1);
      },
    );

    test(
      'should throw ServerException when response code is not 200',
      () async {
        // Arrange
        when(mockDio.get(any)).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: ''),
            data: {},
            statusCode: 500,
          ),
        );

        // Act & Assert
        expect(
          () => dataSource.getAllProducts(),
          throwsA(isA<ServerException>()),
        );
      },
    );
  }); // get all products group

  group('getProductById', () {
    final id = '6672776eb905525c145fe0bb';
    //todo: change price type to double
    final responsePayLoad = {
      'statusCode': 200,
      'message': '',
      'data': {
        'id': '6672776eb905525c145fe0bb',
        'name': 'Anime website',
        'description': 'Explore anime characters.',
        'price': '123',
        'imageUrl': 'https://test.jpg',
      },
    };

    test('should return ProductModel when response code is 200', () async {
      // Arrange
      when(mockDio.get(any)).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: responsePayLoad,
        ),
      );
      // Act
      final result = await dataSource.getProductById(id);

      // Assert
      expect(result, isA<ProductModel>());
      expect(result.id, id);
    });

    test(
      'should throw ServerException when response code is not 200',
      () async {
        // Arrange
        when(mockDio.get(any)).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: ''),
            data: {},
            statusCode: 500,
          ),
        );

        // Act & Assert
        expect(
          () => dataSource.getProductById(id),
          throwsA(isA<ServerException>()),
        );
      },
    );
  }); // get product by id group

  group('updateProduct', () {
    //todo: change price to double
    final tproduct = const ProductModel(
      id: 'any',
      name: 'PC',
      description: 'long description',
      price: '123',
      imageUrl: '/path/to/image.png',
    );

    test('should update product successfly when status code is 200', () async {
      // Arrange
      when(mockDio.put(any, data: anyNamed('data'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: {},
        ),
      );

      // Act
      final call = dataSource.updateProduct;

      // Assert
      expect(() => call(tproduct), returnsNormally);
    });

    test('should throw ServerError when status code is not 200', () async {
      // Arrange
      when(mockDio.put(any, data: anyNamed('data'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 500,
          data: {},
        ),
      );

      // Act
      final call = dataSource.updateProduct;

      // Assert
      expect(() => call(tproduct), throwsA(isA<ServerException>()));
    });
  }); // update product group

  group('deleteProduct', () {
    final id = 'test_id';
    test('should delete product successfuly when code is 200', () async {
      // Arrange
      when(mockDio.delete(any)).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: {},
        ),
      );

      // Act
      final call = dataSource.deleteProduct;

      // Assert
      expect(() => call(id), returnsNormally);
    });

    test('should throw ServerException if response code is not 200', () async {
      // Arrange
      when(mockDio.delete(any)).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 500,
          data: {},
        ),
      );

      // Act
      final call = dataSource.deleteProduct;

      // Assert
      expect(() => call(id), throwsA(isA<ServerException>()));
    });
  }); // delete product group
}