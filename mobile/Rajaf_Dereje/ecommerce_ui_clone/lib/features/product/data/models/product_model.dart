import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.name,
    required super.price,
    required super.category,
    required super.description,
    required super.imagePath,
    required super.id,
  });

  // From JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'],
      price: json['price'],
      category: json['category'],
      description: json['description'],
      imagePath: json['imagePath'],
      id: json['id'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'category': category,
      'description': description,
      'imagePath': imagePath,
      'id': id,
    };
  }
}
