import 'package:dio/dio.dart';
import '../../../../core/error/exception.dart';
import '../models/product_model.dart';
import 'product_remote_data_source.dart';

const String BASE_URL =
    'https://g5-flutter-learning-path-be.onrender.com/api/v1';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;
  final loadErrorMessege = 'Failed to load products';

  ProductRemoteDataSourceImpl({required this.dio});

  /// Fetch all products
  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await dio.get('$BASE_URL/products');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => ProductModel.fromJson(json)).toList();
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
      final formData = FormData.fromMap({
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'image': await MultipartFile.fromFile(
          product.imageUrl,
          filename: product.imageUrl.split('/').last,
        ),
      });

      final response = await dio.post('$BASE_URL/products', data: formData);

      if (response.statusCode != 201) {
        throw ServerException();
      }
    } on DioException {
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
