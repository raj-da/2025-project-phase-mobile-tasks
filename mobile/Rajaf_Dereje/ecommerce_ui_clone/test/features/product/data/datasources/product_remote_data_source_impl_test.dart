import 'package:ecommerce_ui_clone/core/error/exception.dart';
import 'package:ecommerce_ui_clone/core/error/failures.dart';
import 'package:ecommerce_ui_clone/features/product/data/datasources/product_remote_data_source_impl.dart';
import 'package:ecommerce_ui_clone/features/product/data/models/product_model.dart';
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import '../repositories/product_repository_impl_test.mocks.dart';
import 'product_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late ProductRemoteDataSourceImpl dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = ProductRemoteDataSourceImpl(dio: mockDio);
  });

  // Dummy data and helper function remain the same...
  final tProductModel = ProductModel(
    name: 'Test Product',
    price: '99.99',
    category: 'Test',
    description: 'Test Desc',
    imagePath: 'http://example.com/img.jpg',
    id: '1',
  );
  final tProductList = [tProductModel];

  Response<T> createSuccessResponse<T>(T data, int statusCode) {
    return Response(
      data: data,
      statusCode: statusCode,
      requestOptions: RequestOptions(path: ''),
    );
  }

  DioException createFailureResponse() {
    return DioException(
      requestOptions: RequestOptions(path: ''),
      response: Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 404,
      ),
    );
  }

  group('getAllProducts', () {
    final successJson = {
      'statusCode': 200,
      'message': '',
      'data': [
        {
          'id': '1',
          'name': 'Test Product',
          'description': 'Test Desc',
          'price': '99.99',
          'imageUrl': 'http://example.com/img.jpg',
        },
      ],
    };

    test(
      'should return List<ProductModel> when the response code is 200 (success)',
      () async {
        // Arrange
        when(
          mockDio.get(any),
        ).thenAnswer((_) async => createSuccessResponse(successJson, 200));

        // Act
        final result = await dataSource.getAllProducts();

        // Assert
        expect(result, isA<List<ProductModel>>());
        verify(mockDio.get('$BASE_URL/products'));
        verifyNoMoreInteractions(mockDio);
      },
    );

    test(
      'should throw a ServerException when the respond code is not 200',
      () async {
        // Arrange
        when(mockDio.get(any)).thenThrow(createFailureResponse());

        // Act
        final call = dataSource.getAllProducts;

        // Assert
        expect(() => call(), throwsA(isA<ServerException>()));
      },
    );
  }); // get all products group

  group('getProductById', () {
    final tId = '1';
    final successJson = {
      'statusCode': 200,
      'message': '',
      'data': {
        'id': '1',
        'name': 'Test Product',
        'description': 'Test Desc',
        'price': '99.99',
        'imageUrl': 'http://example.com/img.jpg',
      },
    };

    test('should return ProductModel when the response code is 200', () async {
      // Arrange
      when(
        mockDio.get(any),
      ).thenAnswer((_) async => createSuccessResponse(successJson, 200));

      // Act
      final result = await dataSource.getProductById(tId);

      // Assert
      expect(result, isA<ProductModel>());
      verify(mockDio.get('$BASE_URL/products/$tId'));
      verifyNoMoreInteractions(mockDio);
    });

    test('should return ServerException on failure', () async {
      // Arrange
      when(mockDio.get(any)).thenThrow(createFailureResponse());
      // Act
      final call = dataSource.getProductById;
      // Assert
      expect(() => call(tId), throwsA(isA<ServerException>()));
    });
  }); // get product by id group

  group('deleteProduct', () {
    final tId = '1';
    test('should complete successfluut when status code is 200', () async {
      // Arrange
      when(
        mockDio.delete(any),
      ).thenAnswer((_) async => createSuccessResponse(null, 200));
      // Act
      final call = dataSource.deleteProduct(tId);
      // Assert
      await expectLater(call, completes);
      verify(mockDio.delete('$BASE_URL/products/$tId'));
    });

    test('should return ServerException on failure', () async {
      // Arrange
      when(mockDio.delete(any)).thenThrow(createFailureResponse());

      // Act
      final call = dataSource.deleteProduct;

      // Assert
      expect(() => call(tId), throwsA(isA<ServerException>()));
    });
  }); // delete product group

  group('updateProduct', () {
    void updateSetup(int successCode) {
      when(
        mockDio.put(
          any,
          data: anyNamed('data'),
          queryParameters: anyNamed('queryParameters'),
          options: anyNamed('options'),
          cancelToken: anyNamed('cancelToken'),
          onSendProgress: anyNamed('onSendProgress'),
          onReceiveProgress: anyNamed('onReceiveProgress'),
        ),
      ).thenAnswer((_) async => createSuccessResponse(null, successCode));
    }

    test('should complete successfly when status code is 200', () async {
      // Arrange
      updateSetup(200);

      // Act
      final call = dataSource.updateProduct(tProductModel);

      // Assert
      await expectLater(call, completes);
    });

    test('should return Server Exception on failuer', () async {
      // Arrange
      updateSetup(500);

      // Act
      final call = dataSource.updateProduct;

      // Assert
      expect(() => call(tProductModel), throwsA(isA<ServerException>()));
    });
  }); // update product group
} // main
