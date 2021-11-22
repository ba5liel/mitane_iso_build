import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mitane_frontend/domain/ingredient/entity/ingredient_model.dart';
import 'package:mitane_frontend/domain/product/entity/product_model.dart';
import 'package:mitane_frontend/domain/machinery/entity/machinery_model.dart';
import 'package:mitane_frontend/domain/store/entity/store_model.dart';
import 'package:mitane_frontend/infrastructure/core/mitane_urls.dart';

class StoreProvider {
  final Dio dio;
  final storeUrl = BaseUrl.storeBaseUrl;
  final productUrl = BaseUrl.productBaseUrl;
  final machineryUrl = BaseUrl.machineryBaseUrl;
  final ingredientUrl = BaseUrl.ingredientBaseUrl;
  final storage = FlutterSecureStorage();
  StoreProvider({required this.dio});

  Future<dynamic> getSelfStore() async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await storage.read(key: 'token')}';

      final response = await dio.get("$storeUrl/self");
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getStoreById(String id) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await storage.read(key: 'token')}';
          
      final response = await dio.get("$storeUrl/$id");
      
      return (response.data);
      
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Product>> getAllProductItems() async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await storage.read(key: 'token')}';

      final response = await dio.get("$productUrl/");
      return (response.data['data'] as List)
          .map((u) => Product.fromJson(u))
          .toList();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<Machinery>> getAllMachineryItems() async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await storage.read(key: 'token')}';

      final response = await dio.get('$machineryUrl');
      return (response.data as List).map((u) => Machinery.fromJson(u)).toList();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<Ingredient>> getAllIngredientItems() async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await storage.read(key: 'token')}';

      final response = await dio.get('$ingredientUrl');
      return (response.data['data'] as List)
          .map((u) => Ingredient.fromJson(u))
          .toList();
    } on DioError catch (e) {
      print(e.response);
      throw e;
    }
  }

  Future<bool> createProductItem(ProductItem item) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await storage.read(key: 'token')}';

      final response = await dio.post('$storeUrl/add_product', data: {
        "product": item.product.id,
        "quantity": item.quantity,
        "price": item.pricerPerKg,
      });

      if (response.statusCode == 200) {
        print("Sucessfully created product item: ${(response.data)}");
        return true;
      }

      print("Unsuccessful creation of product item");
      return false;
    } on DioError catch (e) {
      print(e.response);
      throw e;
    }
  }

  Future<bool> createMachineryItem(MachineryItem item) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await storage.read(key: 'token')}';

      final response = await dio.post('$storeUrl/add_machinery', data: {
        "machinery": item.machinery.id,
        "quantity": item.quantity,
        "price": item.pricerPerPiece,
      });

      if (response.statusCode == 200) {
        print("Sucessfully created machinery item: ${(response.data)}");
        return true;
      }

      print("Unsuccessful creation of machinery item");
      return false;
    } on DioError catch (e) {
      print(e.response);
      throw e;
    }
  }

  Future<bool> createIngridentItem(IngridentItem item) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await storage.read(key: 'token')}';

      final response = await dio.post('$storeUrl/add_ingredient', data: {
        "ingredient": item.ingredients.id,
        "quantity": item.quantity,
        "price": item.pricerPerKg,
      });

      if (response.statusCode == 200) {
        print("Sucessfully created ingredient item: ${(response.data)}");
        return true;
      }

      print("Unsuccessful creation of ingredient item");
      return false;
    } on DioError catch (e) {
      print(e.response);
      throw e;
    }
  }

  Future<bool> createStore(double latitude, double longitude) async {
    // final latitude = store['latitude'];
    // final longitude = store['longitude'];
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await storage.read(key: 'token')}';

      final Response<Map> response = await dio.post("$storeUrl",
          data: {'latitude': latitude, 'longitude': longitude});
      print(response.data);
      if (response.statusCode == 200) return true;
      return false;
    } catch (e) {
      throw Exception();
    }
  }

  Future<List<dynamic>> getAllStores() async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await storage.read(key: 'token')}';
          
      final response = await dio.get("$storeUrl");
      if (response.statusCode == 200) {
        final data = response.data;
        return data;
      } else {
        return [];
      }
    } catch (e) {
      
      throw Exception("Can't fetch");
    }
  }

// Products, ingredients, machineries for the home page
  Future<List<dynamic>> getAllItems() async {
    try {
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<List<dynamic>> getAnItem() async {
    try {
      return [];
    } catch (e) {
      return [];
    }
  }

  // Product, ingredient, machinery
  Future<bool> addAnItem(StoreItem item) async {
    final product = item.product;
    final price = item.price;
    final quantity = item.quantity;
    //final token = await storage.read(key: 'token');
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await storage.read(key: 'token')}';
      print('here');
      final response = await dio.post("$storeUrl/add_product",
          data: {'product': product, 'price': price, 'quantity': quantity});
      print(response.data);
      if (response.statusCode == 200) return true;
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateStoreItem(String type, String store, String productId,
      String storeitem, double price, int quantity) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await storage.read(key: 'token')}';
      print('here $storeUrl/$productId $store');
      final response = await dio.put("$storeUrl/$type/$store", data: {
        type: productId,
        "quantity": quantity,
        "storeitem": storeitem,
        "price": price
      });
      print("updateStoreItem ${response.data} $storeUrl/$type");
      return true;
    } on DioError catch (e) {
      print(e.response);
      rethrow;
    }
  }

  // Product, ingredient, machinery
  Future<bool> deleteAnItem(String type, String storeItem) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await storage.read(key: 'token')}';
      print('here $storeUrl/$type $storeItem');
      final response =
          await dio.delete("$storeUrl/$type", data: {type: storeItem});
      print("DelteAnItem ${response.data} $storeUrl/$type");
      return true;
    } on DioError catch (e) {
      print(e.response);
      rethrow;
    }
  }

  // Product, ingredient, machinery
  Future<bool> updateAnItem() async {
    try {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> clearStore() async {
    try {
      return false;
    } catch (e) {
      return false;
    }
  }
}
