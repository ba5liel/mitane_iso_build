import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mitane_frontend/domain/price/entity/price_model.dart';
import 'package:mitane_frontend/domain/product/entity/product_model.dart';
import 'package:mitane_frontend/infrastructure/core/mitane_urls.dart';

class PriceProvider {
  final Dio dio;
  final storage = FlutterSecureStorage();

  final priceUrl = BaseUrl.priceBaseUrl;
  final productUrl = BaseUrl.productBaseUrl;

  PriceProvider({required this.dio});

  Future<List<dynamic>> getPrice(String date) async {
    try {
      final token = await storage.read(key: 'token');
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] = 'Bearer $token';
      Response response = await dio.get("$priceUrl/$date");
      if (response.statusCode == 200) {
        if (response.data['count'] == 0) {
          return [EmptyPrice("No result")];
        }
        final prices = response.data['data']
            .map((price) => PriceDaily(
                price: price['price_of_the_day'], product: price['product']))
            .toList();

        return prices;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }

  Future<bool> addDailyPrice(PriceAdd priceAdd) async {
    final product = priceAdd.product;
    final price = priceAdd.price;
    try {
      final token = await storage.read(key: 'token');
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] = 'Bearer $token';

      final response =
          await dio.put("$priceUrl/$product", data: {'price': price});
      print(response.statusCode);
      if (response.statusCode == 201 || response.statusCode == 200) return true;
      throw Exception('error status');
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<bool> deleteSpecificPrice(PriceDelete priceDelete) async {
    try {
      final token = await storage.read(key: 'token');
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] = 'Bearer $token';
      final response = await dio.put("$priceUrl",
          data: {'product': priceDelete.product, 'date': priceDelete.date});
      print(response.statusCode);
      if (response.statusCode == 200) return true;
      throw Exception('error');
    } catch (e) {
      print(e);
      throw Exception("error");
    }
  }

  Future<bool> updateDailyPrice(
      String product, String price, String date) async {
    try {
      final res = await deleteSpecificPrice(
          PriceDelete(product: product, price: int.parse(price), date: date));
      if (res) {
        final result = await addDailyPrice(
            PriceAdd(product: product, price: double.parse(price)));
        return result;
      } else {
        throw Exception('error');
      }
    } catch (e) {
      throw Exception('error');
    }
  }

  Future<bool> createProduct(ProductPrice productPrice) async {
    try {
      final token = await storage.read(key: 'token');
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] = 'Bearer $token';
      final response = await dio.post("$priceUrl", data: {
        'product': productPrice.product,
        'category': productPrice.category
      });
      if (response.statusCode == 200) return true;
      throw Exception('error status');
    } catch (e) {
      throw Exception('error status');
    }
  }

  Future<List<String>> fetchProduct() async {
    try {
      final token = await storage.read(key: 'token');
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] = 'Bearer $token';

      final response = await dio.get("$productUrl/");
      return (response.data['data'] as List)
          .map((u) => u['name'].toString())
          .toList();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
