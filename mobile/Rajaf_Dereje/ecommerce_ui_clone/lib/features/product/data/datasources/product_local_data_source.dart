import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  /// Fetches cached data incase network connection was lost
  ///
  Future<List<ProductModel>> getCachedProducts();

  /// Fetches the cached [ProductModel] by its ID
  ///
  Future<ProductModel> getCachedProductById(String id);

  /// Caches a list of products
  ///
  Future<void> cacheProductList(List<ProductModel> products);
}
