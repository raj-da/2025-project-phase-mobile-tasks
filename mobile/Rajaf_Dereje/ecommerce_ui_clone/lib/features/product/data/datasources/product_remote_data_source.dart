import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  /// Fetches all products from the remote source.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<ProductModel>> getAllProducts();

  /// Fetches a single product by its [id] from the remote source.
  ///
  /// Throws a [ServerException] for all error codes
  Future<ProductModel> getProductById(String id);

  /// creates a new product in the remote source.
  Future<void> createProduct(ProductModel product);

  /// Updates an esisting product in the remote source,
  Future<void> updateProduct(ProductModel product);

  /// Deletes a product by its [id] from the remote source.
  Future<void> deleteProduct(String id);
}
