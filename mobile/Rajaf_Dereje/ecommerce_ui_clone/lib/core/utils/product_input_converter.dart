import 'package:dartz/dartz.dart';

import '../../features/product/data/models/product_model.dart';
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

    int? price;
    try {
      price = int.parse(priceStr);
      if (price <= 0) {
        return const Left(InvalidPriceFailure());
      }
    } catch (_) {
      return const Left(InvalidPriceFailure());
    }

    return Right(
      ProductModel(
        id: id,
        name: name.trim(),
        description: description.trim(),
        price: price,
        imageUrl: imageUrl.trim(),
      ),
    );
  }
}
