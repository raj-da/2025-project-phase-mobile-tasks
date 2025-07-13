import 'product.dart';

class ProductManager {
  Map<String, Product> _products = {};

  // Adds a product to our product list
  bool addProduct({
    required String name,
    required String description,
    required double price,
  }) {
    _products[name] = Product(name, description, price);
    return _products.containsKey(name);
  }

  // Removes a product from our product list
  void removeProduct(String name) {
    if (_products.containsKey(name)) {
      _products.remove(name);
      print("Product $name removed succesfly");
    } else {
      print("No such product exists!");
    }
  }

  // List all available Products
  void viewProducts() {
    if (_products.length > 0) {
      for (Product product in _products.values) {
        print("Product Name: ${product.getName()}");
        print("Product Description: ${product.getDescription()}");
        print("Product Price: ${product.getPrice()}");
      }
    } else {
      print("No products Available");
    }
  }

  // print specific product
  void viewProduct(String name) {
    if (_products.containsKey(name)) {
      Product product = _products[name]!;
      print("Product Name: ${product.getName()}");
      print("Product Description: ${product.getDescription()}");
      print("Product Price: ${product.getPrice()}");
    } else {
      print("No such product exists!");
    }
  }

  // Edit a specific product
  void editProduct({
    required String prevName,
    required String name,
    required description,
    required double price,
  }) {
    if (_products.containsKey(prevName)) {
      Product product = _products[prevName]!;
      product.setName(name);
      product.setDescription(description);
      product.setPrice(price);
      _products[name] = product;
      _products.remove(prevName);

      print("Updated profile: ");
      print("Product Name: ${product.getName()}");
      print("Product Description: ${product.getDescription()}");
      print("Product Price: ${product.getPrice()}");
    } else {
      print("No product with name $prevName exists");
    }
  }
}
