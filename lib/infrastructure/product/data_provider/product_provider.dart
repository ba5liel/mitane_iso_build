import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mitane_frontend/domain/category/entity/category_model.dart';
import 'package:mitane_frontend/domain/product/entity/product_model.dart';
import 'package:mitane_frontend/infrastructure/core/mitane_urls.dart';

class ProductDataProvider {
  static final secureStorage = FlutterSecureStorage();

  final Dio dio;
  final productUrl = BaseUrl.productBaseUrl;
  final priceUrl = BaseUrl.priceBaseUrl;
  final categoryUrl = BaseUrl.categoryBaseUrl;
  ProductDataProvider({required this.dio});

  Future<bool> create(Product product) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await secureStorage.read(key: 'token')}';

      final response = await dio.post('$productUrl/create',
          data:
              jsonEncode({"name": product.name, "category": product.category}));

      final responsePrice = await dio.post("$priceUrl",
          data: {'product': product.name, 'category': product.category});

      if (response.statusCode == 200) {
        print("Sucessfully created ${(response.data['data'])}");
        print("Sucessfully added ${(responsePrice.data['data'])}");
        return true;
      }

      print("Unsuccessful creation of a product");
      return false;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<Product>> fetchAll() async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await secureStorage.read(key: 'token')}';

      final response = await dio.get("$productUrl/");

      return (response.data['data'] as List)
          .map((u) => Product.fromJson(u))
          .toList();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<Category>> getProductsCategory() async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await secureStorage.read(key: 'token')}';

      final response = await dio.get("$categoryUrl/type/product");
      return (response.data['data'] as List)
          .map((u) => Category.fromJson(u))
          .toList();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<Product> update(String name, Product product) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await secureStorage.read(key: 'token')}';

      final response = await dio.put("$productUrl/$name",
          data: jsonEncode({
            "id": product.id,
            "name": product.name,
            "category": product.category,
          }));
      print(response.data);

      if (response.statusCode == 200) {
        print("Successful updation of a product");
        return Product.fromJson(response.data['data']);
      }
      print("Unsuccessful updation of a product");
      return Product(id: "", name: "", category: "");
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> delete(String name) async {
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['authorization'] =
        'Bearer ${await secureStorage.read(key: 'token')}';

    final response = await dio.delete("$productUrl/$name");
    print(response.data['data']);

    print("Successful deletion of a product");
  }
}
