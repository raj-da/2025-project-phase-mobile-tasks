import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../../../../core/error/exception.dart';
import '../models/product_model.dart';
import 'product_remote_data_source.dart';

const String BASE_URL =
    'https://g5-flutter-learning-path-be-tvum.onrender.com/api/v1';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;
  final loadErrorMessege = 'Failed to load products';

  ProductRemoteDataSourceImpl({required this.dio});

  /// Fetch all products
  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await dio.get('$BASE_URL/products');
      // print('get all product $response');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        final products = data
            .map((json) => ProductModel.fromJson(json))
            .toList();
        return products;
      } else {
        throw ServerException();
      }
    } on DioException {
      throw ServerException();
    }
  }

  /// Fetch Single product by ID
  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      final response = await dio.get('$BASE_URL/products/$id');

      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data['data']);
      } else {
        throw ServerException();
      }
    } on DioException {
      throw ServerException();
    }
  }

  /// Create product (with image)
  @override
  Future<void> createProduct(ProductModel product) async {
    try {
      final String? mimeType = lookupMimeType(product.imageUrl);
      final String finalMimeType = mimeType ?? 'application/octet-stream';

      final mediaType = MediaType.parse(finalMimeType);
      final formData = FormData.fromMap({
        'name': product.name,
        'description': product.description,
        'price': product.price.toString(),
        'image': await MultipartFile.fromFile(
          product.imageUrl,
          filename: product.imageUrl.split('/').last,
          contentType: mediaType,
        ),
      });

      print('before create product');
      print(formData.fields);
      print(formData.files);
      final response = await dio.post('$BASE_URL/products', data: formData);
      print('create product: $response');

      if (response.statusCode != 201) {
        throw ServerException();
      }
    } on DioException catch (e) {
      // It's good practice to catch DioException specifically to inspect the response
      print('DioException caught:');
      if (e.response != null) {
        print('Response data: ${e.response?.data}');
        print('Response headers: ${e.response?.headers}');
      } else {
        // Error without a response (e.g., connection error)
        print('Request error: ${e.message}');
      }
      throw ServerException();
    } catch (e) {
      // Catch any other unexpected errors
      print('An unexpected error occurred: $e');
      throw ServerException();
    }
  }

  /// Update product by ID (no image update)
  @override
  Future<void> updateProduct(ProductModel product) async {
    try {
      final newData = {
        'name': product.name,
        'description': product.description,
        'price': product.price,
      };

      final response = await dio.put(
        '$BASE_URL/products/${product.id}',
        data: newData,
      );

      if (response.statusCode != 200) {
        throw ServerException();
      }
    } on DioException {
      throw ServerException();
    }
  }

  /// Delete product by ID
  @override
  Future<void> deleteProduct(String id) async {
    try {
      final response = await dio.delete('$BASE_URL/products/$id');
      if (response.statusCode != 200) {
        throw ServerException();
      }
    } on DioException {
      throw ServerException();
    }
  }
}
