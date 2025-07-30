import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks([SharedPreferences])

import 'dart:convert';
import 'package:ecommerce_ui_clone/features/product/data/datasources/product_local_data_source.dart';
import 'package:ecommerce_ui_clone/features/product/data/datasources/product_local_data_source_impl.dart';
import 'package:ecommerce_ui_clone/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'product_local_data_source_impl_test.mocks.dart';

void main() {
  late ProductLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = ProductLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  // Sample data for testing
  final tProductModel1 = ProductModel(
    name: 'Test Product 1',
    price: '100',
    category: 'Test Category',
    description: 'Test Description 1',
    imagePath: '/test1.jpg',
    id: '1',
  );
  final tProductModel2 = ProductModel(
    name: 'Test Product 2',
    price: '200',
    category: 'Test Category',
    description: 'Test Description 2',
    imagePath: '/test2.jpg',
    id: '2',
  );
  final tProductList = [tProductModel1, tProductModel2];
  final tProductJsonList = tProductList
      .map((tProduct) => json.encode(tProduct.toJson()))
      .toList();

  group('getCachedProducts', () {
    test(
      'should return List<ProductModel> from sharedPreferences when there is one in the cache',
      () async {
        // Arrange
        when(
          mockSharedPreferences.getStringList(CACHED_PRODUCTS),
        ).thenReturn(tProductJsonList);

        // Act
        final result = await dataSource.getCachedProducts();

        // Assert
        verify(mockSharedPreferences.getStringList(CACHED_PRODUCTS));
        expect(result, isA<List<ProductModel>>());
        expect(result, equals(tProductList));
      },
    );
  }); // get chached product group.
}
