import 'package:dartz/dartz.dart';
import 'package:ecommerce_ui_clone/core/error/failures.dart';
import 'package:ecommerce_ui_clone/core/utils/product_input_converter.dart';
import 'package:ecommerce_ui_clone/features/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('product input converter', () {
    Either<Failure, Product> defaultInput({
      name = 'Rajaf',
      description = 'Human',
      priceStr = '1000',
      imageUrl = '/image.png',
      id = '1123/15',
    }) {
      return ProductInputConverter().convertFormToProduct(
        name: name,
        description: description,
        priceStr: priceStr,
        imageUrl: imageUrl,
        id: id,
      );
    }

    test('should return a Product object when all inputs are valid', () async {
      // act
      final result = defaultInput();

      // Assert
      expect(result, isA<Right<Failure, Product>>());
    });

    test('should return InvalidNameFailure on invalid name input', () async {
      // Act
      final result = defaultInput(name: '');
      // Assert
      expect(result, equals(const Left(InvalidNameFailure())));
    });

    test(
      'should return InvalidDescriptionFailure on invalid description input',
      () async {
        // Act
        final result = defaultInput(description: '');
        // Assert
        expect(result, equals(const Left(InvalidDescriptionFailure())));
      },
    );

    test(
      'should return InvalidImageFailure when invalid path is uploaded',
      () async {
        final result = defaultInput(imageUrl: '');
        // Assert
        expect(result, equals(const Left(InvalidImageFailure())));
      },
    );

    test('should return InvalidPriceFailure on invalid price', () async {
      final result = defaultInput(priceStr: '');
      // Assert
      expect(result, equals(const Left(InvalidPriceFailure())));
    });

    test('should return InvalidIdFailure on invalid id', () async {
        final result = defaultInput(id: '');
        // Assert
        expect(result, equals(const Left(InvalidIdFailure())));
      });
  }); // product input coverter
}
