import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mitane_frontend/infrastructure/core/mitane_urls.dart';

class TeamProvider {
  final Dio dio;
  final teamsUrl = BaseUrl.teamBaseUrl;
  static final secureStorage = FlutterSecureStorage();

  TeamProvider({required this.dio});
  Future<List<Map<String, dynamic>>> getSelfTeam() async {
    //final token = await storage.read(key: 'token');
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await secureStorage.read(key: 'token')}';
      print("$teamsUrl/self");
      Response<List> response = await dio.get("$teamsUrl/self");
      final data = response.data!;
      print(data);
      return data.map((e) => e as Map<String, dynamic>).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getJoinedTeam() async {
    //final token = await storage.read(key: 'token');
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await secureStorage.read(key: 'token')}';
      print("$teamsUrl/joined");
      Response response = await dio.get("$teamsUrl/joined");
      final data = response.data!;
      print("getJoinedTeam $data");
      return data
          .map<Map<String, dynamic>>((e) => e as Map<String, dynamic>)
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getTeamStat() async {
    //final token = await storage.read(key: 'token');
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await secureStorage.read(key: 'token')}';
      print("$teamsUrl/stat");
      Response response = await dio.get("$teamsUrl/stat");
      final data = response.data!;
      print("stat $data");
      return data as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> createTeam(
      String name, double latitude, double longitude, File? image) async {
    //final token = await storage.read(key: 'token');
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await secureStorage.read(key: 'token')}';
      Map<String, dynamic> jsonFormData = {
        "name": name,
        'latitude': latitude,
        'longitude': longitude
      };
      print("$teamsUrl/createTeam");

      if (image != null) {
        String fileName = image.path.split('/').last;
        jsonFormData["image"] =
            await MultipartFile.fromFile(image.path, filename: fileName);
      }

      FormData formData = FormData.fromMap(jsonFormData);

      final response = await dio.post("$teamsUrl/new", data: formData);
      print(response);
      if (response.statusCode == 200) return true;

      return false;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getAllTeams() async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await secureStorage.read(key: 'token')}';
      final response = await dio.get("$teamsUrl");
      final data = response.data["docs"];
      print("getAllTeams");
      print(data);
      return data
          .map<Map<String, dynamic>>((e) => e as Map<String, dynamic>)
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getNearByTeams(latitude, longitude) async {
    //final token = await storage.read(key: 'token');
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await secureStorage.read(key: 'token')}';
      final response = await dio.get("$teamsUrl/near",
          queryParameters: {"latitude": latitude, "longitude": longitude});
      final data = response.data;
      print(data);
      return data
          .map<Map<String, dynamic>>((e) => e as Map<String, dynamic>)
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getTeamById(int id) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await secureStorage.read(key: 'token')}';
      final response = await dio.get("$teamsUrl/$id");
      final data = response.data;
      print(data);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  // Product, ingredient, machinery
  Future<Map<String, dynamic>> addMemeber(
      List<String> newMemebers, String teamId) async {
    //final token = await storage.read(key: 'token');
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await secureStorage.read(key: 'token')}';

      final response = await dio.post("$teamsUrl/add",
          data: {'team_id': teamId, 'new_users_id': newMemebers});
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      print(e.response);
      rethrow;
    }
  }

  Future<bool> delete(String teamId) async {
    //final token = await storage.read(key: 'token');
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await secureStorage.read(key: 'token')}';
      print("responsed delete");

      final response = await dio.delete("$teamsUrl/${teamId}");
      print("res ${response.data}");
      if (response.statusCode == 200) return true;
      return false;
    } on DioError catch (e) {
      print(e.response);
      rethrow;
    }
  }

  Future<bool> updateName(int teamId, String name) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await secureStorage.read(key: 'token')}';
      final response = await dio
          .patch("$teamsUrl/name", data: {'team_id': teamId, "name": name});
      if (response.statusCode == 200) return true;
      return false;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateImage(int teamId, File image) async {
    //final token = await storage.read(key: 'token');
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await secureStorage.read(key: 'token')}';

      String fileName = image.path.split('/').last;

      FormData formData = FormData.fromMap({
        'team_id': teamId,
        "image": await MultipartFile.fromFile(image.path, filename: fileName),
      });

      final response = await dio.patch("$teamsUrl/name", data: formData);
      if (response.statusCode == 200) return true;
      return false;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> leaveTeam(String teamId) async {
    //final token = await storage.read(key: 'token');
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await secureStorage.read(key: 'token')}';

      final response =
          await dio.patch("$teamsUrl/leave", data: {"team_id": teamId});
      if (response.statusCode == 200) return true;
      return false;
    } catch (e) {
      rethrow;
    }
  }
}
