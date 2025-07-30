import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';
import '../models/product_model.dart';
import 'product_local_data_source.dart';

const CACHED_PRODUCTS = 'CACHED_PRODUCTS';

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheProductList(List<ProductModel> products) {
    final List<String> productJsonList = products
        .map((product) => json.encode(product.toJson()))
        .toList();
    return sharedPreferences.setStringList(CACHED_PRODUCTS, productJsonList);
  }

  @override
  Future<ProductModel> getCachedProductById(String id) {
    final jsonStringList = sharedPreferences.getStringList(CACHED_PRODUCTS);
    if (jsonStringList != null && jsonStringList.isNotEmpty) {
      final product = jsonStringList
          .map((jsonString) => ProductModel.fromJson(json.decode(jsonString)))
          .toList()
          .firstWhere(
            (product) => product.id == id,
            orElse: () => throw CacheException(),
          );
      return Future.value(product);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<ProductModel>> getCachedProducts() {
    final jsonStringList = sharedPreferences.getStringList(CACHED_PRODUCTS);
    if (jsonStringList != null && jsonStringList.isNotEmpty) {
      final products = jsonStringList
          .map((jsonString) => ProductModel.fromJson(json.decode(jsonString)))
          .toList();
      return Future.value(products);
    } else {
      throw CacheException();
    }
  }
}
