// import 'dart:io';

import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String name;
  final String price;
  // final String category;
  final String description;
  final String imageUrl;
  final String id;

  const Product({
    required this.name,
    required this.price,
    // required this.category,
    required this.description,
    required this.imageUrl,
    required this.id,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    // category,
    description,
    imageUrl,
    price,
  ];
}
