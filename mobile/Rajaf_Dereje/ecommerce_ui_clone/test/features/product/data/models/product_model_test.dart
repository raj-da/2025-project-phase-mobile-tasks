import 'package:ecommerce_ui_clone/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  //* dummy data to test toJson method
  const tproductModel = ProductModel(
    id: '1',
    name: 'Test Product',
    description: 'A test product',
    price: 99,
    imageUrl: 'test.png',
  );

  //* dummy data to test fromJson constructor
  final tproductJson = {
    'id': '1',
    'name': 'Test Product',
    'description': 'A test product',
    'price': 99,
    'imageUrl': 'test.png',
  };

  group('Product model', () {
    test(
      '''should return a valid ProductModel
     when fromJson is called with map<String, dynamic>''',
      () async {
        // Act
        final result = ProductModel.fromJson(tproductJson);

        // Assert
        expect(result, equals(tproductModel));
      },
    );

    test('toJson should return a valid map', () async {
      // Act
      final result = tproductModel.toJson();

      // Assert
      expect(result, equals(tproductJson));
    });
  }); // product model group
}
