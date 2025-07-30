import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../core/error/exception.dart';
import '../models/product_model.dart';
import 'product_remote_data_source.dart';

const String BASE_URL =
    'https://g5-flutter-learning-path-be.onrender.com/api/v1';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await dio.get('$BASE_URL/products');
      if (response.statusCode == 200) {
        // The list of products is nested under the 'data' key
        final List<dynamic> productListJson = response.data['data'];
        final products = productListJson
            .map(
              (productJson) => ProductModel.fromJson(productJson),
            )
            .toList();
        return products;
      } else {
        throw ServerException();
      }
    } on DioException {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      final response = await dio.get('$BASE_URL/products/$id');
      if (response.statusCode == 200) {
        final productJson = response.data['data'];
        final product = ProductModel.fromJson(productJson);
        return product;
      } else {
        throw ServerException();
      }
    } on DioException {
      throw ServerException();
    }
  }

  @override
  Future<void> createProduct(ProductModel product) async {
    try {
      // The API expects 'multipart/form-data' because of the image file.
      final formData = FormData.fromMap({
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'image': await MultipartFile.fromFile(
          product.imagePath,
          filename: product.imagePath.split('/').last,
        ),
      });

      final response = await dio.post('$BASE_URL/products', data: formData);

      if (response.statusCode != 201) {
        throw ServerException();
      }

      return Future.value(null);
    } on DioException {
      throw ServerException();
    }
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    try {
      final response = await dio.put(
        '$BASE_URL/products/${product.id}',
        data: json.encode(product.toJson()),
      );

      if (response.statusCode != 200) {
        throw ServerException();
      }

      return Future.value(null);
    } on DioException {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    try {
      final response = await dio.delete('$BASE_URL/products/$id');
      if (response.statusCode != 200) {
        throw ServerException();
      }
      return Future.value(null);
    } on DioException {
      throw ServerException();
    }
  }
}
