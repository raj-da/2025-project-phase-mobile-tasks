import 'package:dartz/dartz.dart';

import '../../features/product/domain/entities/product.dart';
import '../error/failures.dart';

class ProductInputConverter {
  Either<Failure, Product> convertFormToProduct({
    required String name,
    required String description,
    required String priceStr,
    required String imageUrl,
    required String id,
  }) {
    if (name.trim().isEmpty) {
      return const Left(InvalidNameFailure());
    }

    if (description.trim().isEmpty) {
      return const Left(InvalidDescriptionFailure());
    }

    if (imageUrl.trim().isEmpty) {
      return const Left(InvalidImageFailure());
    }

    if (id.trim().isEmpty) {
      return const Left(InvalidIdFailure());
    }

    double? price;
    try {
      price = double.parse(priceStr);
      if (price <= 0) {
        return const Left(InvalidPriceFailure());
      }
    } catch (_) {
      return const Left(InvalidPriceFailure());
    }

    return Right(
      Product(
        id: id,
        name: name.trim(),
        description: description.trim(),
        price: price.toStringAsFixed(2),
        imageUrl: imageUrl.trim(),
      ),
    );
  }
}
