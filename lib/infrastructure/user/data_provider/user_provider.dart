import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mitane_frontend/domain/role/entity/role_model.dart';
import 'package:mitane_frontend/domain/auth/entity/auth_model.dart';
import 'package:mitane_frontend/infrastructure/core/mitane_urls.dart';

class UserDataProvider {
  static final secureStorage = FlutterSecureStorage();

  final Dio dio;
  final userUrl = BaseUrl.userBaseUrl;
  UserDataProvider({required this.dio});

  Future<User> create(User user) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await secureStorage.read(key: 'token')}';

      final response = await dio.post("$userUrl/create",
          data: jsonEncode({
            "name": user.name,
            "phoneNo": user.phone,
            "roles": user.roles,
            "password": user.password
          }));

      if (response.statusCode == 201) {
        print("Successfully created a user");
        return User.fromJson(jsonDecode(response.data));
      }
      print("Unsuccessful creation of a user");
      return User(
          id: "", name: "", phone: '', password: "", roles: [], token: "");
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<User>> fetchAll() async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await secureStorage.read(key: 'token')}';

      final response = await dio.get('$userUrl');
      print("Successfully listed users: ${response.data}");
      return (response.data as List).map((u) => User.fromJson(u)).toList();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<Role>> fetchAllRoles() async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await secureStorage.read(key: 'token')}';

      final response = await dio.get('$userUrl/roles');
      print("Successfully listed roles: ${response.data}");
      return (response.data as List).map((u) => Role.fromJson(u)).toList();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<User>> fetchAllUsersByRole(String role) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await secureStorage.read(key: 'token')}';

      final response = await dio.get('$userUrl/role/$role');
      print("Successfully listed ${role} users: ${response.data}");
      return (response.data as List).map((u) => User.fromJson(u)).toList();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<User> update(String id, User user) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          'Bearer ${await secureStorage.read(key: 'token')}';

      final response = await dio.put('$userUrl/update/$id',
          data: jsonEncode({
            "id": id,
            "name": user.name,
            "phone": user.phone,
            "roles": user.roles,
            "password": user.password,
          }));

      if (response.statusCode == 200) {
        print("Successful updation of a user");
        return User.fromJson(jsonDecode(response.data));
      }
      print("Unsuccessful updation of a user");
      return User(
          id: "", name: "", phone: '', password: "", roles: [], token: "");
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> delete(String id) async {
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['authorization'] =
        'Bearer ${await secureStorage.read(key: 'token')}';

    final response = await dio.delete('$userUrl/delete/$id');
    print(response);
    print("Successful deletion of a user");
  }
}
