import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mitane_frontend/domain/category/entity/category_model.dart';
import 'package:mitane_frontend/domain/ingredient/entity/ingredient_model.dart';
import 'package:mitane_frontend/infrastructure/core/mitane_urls.dart';

class IngredientDataProvider {
  static final secureStorage = FlutterSecureStorage();

  final Dio dio;
  final ingredientUrl = BaseUrl.ingredientBaseUrl;
  final categoryUrl = BaseUrl.categoryBaseUrl;

  IngredientDataProvider({required this.dio});

  Future<bool> create(Ingredient ingredient) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await secureStorage.read(key: 'token')}';
      final response = await dio.post('$ingredientUrl/create',
          data: jsonEncode(
              {"name": ingredient.name, "category": ingredient.category}));

      if (response.statusCode == 200) {
        print("Sucessfully created an ingredient: ${(response.data['data'])}");
        return true;
      }

      print("Unsuccessful ingredient creation");
      return false;
    } on DioError catch (e) {
      print(e.response!.data);
      rethrow;
    }
  }

  Future<List<Ingredient>> fetchAll() async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await secureStorage.read(key: 'token')}';

      final response = await dio.get("$ingredientUrl/");
      print("Successfully fetched ingredients: ${response.data}");
      return (response.data['data'] as List)
          .map((u) => Ingredient.fromJson(u))
          .toList();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<Category>> getIngredientsCategory() async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await secureStorage.read(key: 'token')}';
      final response = await dio.get("$categoryUrl/type/ingredient");
      return (response.data['data'] as List)
          .map((u) => Category.fromJson(u))
          .toList();
    } on DioError catch (e) {
      print(e.response!.data);
      rethrow;
    }
  }

  Future<Ingredient> update(String name, Ingredient ingredient) async {
    try {
      print("Updation process.......");
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await secureStorage.read(key: 'token')}';

      final response = await dio.put("$ingredientUrl/$name",
          data: jsonEncode({
            "id": ingredient.id,
            "name": ingredient.name,
            "category": ingredient.category,
          }));
      print(response.data);

      if (response.statusCode == 200) {
        print("Successful updation of ingredients");
        return Ingredient.fromJson(response.data['data']);
      }
      print("Unsuccessful updation of ingredients");
      return Ingredient(id: "", name: "", category: "");
    } on DioError catch (e) {
      print(e.response!.data);
      rethrow;
    }
  }

  Future<void> delete(String name) async {
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['authorization'] =
        'Bearer ${await secureStorage.read(key: 'token')}';
    final response = await dio.delete("$ingredientUrl/$name");
    print(response.data['data']);

    print("Successful deletion of an ingredient");
  }
}
