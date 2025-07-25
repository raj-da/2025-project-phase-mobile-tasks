import '../entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getAllProduct();
  Future<Product?> getProductById(String id);
  Future<void> updateProduct(Product product);
  Future<void> deleteProduct(String id);
  Future<void> createproduct(Product product);
}
