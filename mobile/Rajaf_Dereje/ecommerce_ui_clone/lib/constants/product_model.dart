import 'dart:io';

class Product {
  final String name;
  final String price;
  final String category;
  final String description;
  final File image;
  int index;

  Product({
    required this.name,
    required this.price,
    required this.category,
    required this.description,
    required this.image,
    this.index = -1
  });
}
