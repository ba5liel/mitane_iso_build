import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mitane_frontend/domain/machinery/entity/machinery_model.dart';
import 'package:mitane_frontend/infrastructure/core/mitane_urls.dart';

class MachineryDataProvider {
  static final storage = FlutterSecureStorage();

  final Dio dio;
  final machineryUrl = BaseUrl.machineryBaseUrl;
  MachineryDataProvider({required this.dio});

  Future<Machinery> create(Machinery machinery) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await storage.read(key: 'token')}';

      final response = await dio.post('$machineryUrl',
          data: jsonEncode({"name": machinery.name, "category": "machinery"}));

      if (response.statusCode == 201) {
        print("Successful creation of a machinery");
        return Machinery.fromJson(jsonDecode(response.data));
      }
      print("Unsuccessful creation of a machinery");
      return Machinery(id: "", name: "");
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<Machinery>> fetchAll() async {
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

  Future<Machinery> update(String id, Machinery machinery) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await storage.read(key: 'token')}';

      final response = await dio.put('$machineryUrl/$id',
          data: jsonEncode({
            "name": machinery.name,
          }));

      if (response.statusCode == 200) {
        print("Successful updation of a machinery");
        return Machinery.fromJson(jsonDecode(response.data));
      }
      print("Unsuccessful updation of a machinery");
      return Machinery(id: "", name: "");
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> delete(String id) async {
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['authorization'] =
        'Bearer ${await storage.read(key: 'token')}';

    final response = await dio.delete('$machineryUrl/$id');
    print(response);
    print("Successful deletion of a machinery");
  }
}
