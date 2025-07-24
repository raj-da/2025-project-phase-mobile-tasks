import 'dart:io';

class Product {
  final String name;
  final String price;
  final String category;
  final String description;
  final File image;
  int id;
  bool delete = false; // to determine if we want to remove the product

  Product({
    required this.name,
    required this.price,
    required this.category,
    required this.description,
    required this.image,
    this.id = -1,
  });
}
