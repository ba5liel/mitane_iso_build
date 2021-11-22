import 'package:dio/dio.dart';
import 'package:mitane_frontend/domain/auth/entity/auth_model.dart';
// import 'package:http/http.dart' as http;
import 'package:mitane_frontend/infrastructure/core/data_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mitane_frontend/infrastructure/core/mitane_urls.dart';

class AuthDataProvider extends DataProvider {
  // final http.Client httpClient;
  final Dio dio;
  final authUrl = BaseUrl.authBaseUrl;
  static final storage = FlutterSecureStorage();
  AuthDataProvider({required this.dio});

  Future<User> loginUser(Login login) async {
    final String phone = login.phone;
    final String password = login.password;
    var user;
    var code = '+251';

    if (phone == '911111111' || phone == '922222222' || phone == '900000000') {
      code = '251';
    }
    Response response = await dio.post("$authUrl/login",
        data: {'phone_no': '$code$phone', 'password': password});
    if (response.statusCode == 200 || response.statusCode == 204) {
      user = User.fromJson(response.data);
      await saveUserOnLocal(user);
    } else {
      throw Exception("Invalid login");
    }
    return user;
  }

  Future<bool> registerUser(Register register) async {
    final String name = register.name;
    final String phone = register.phone;
    final String confirm = register.confirm;
    final String role = register.role;
    final String password = register.password;

    String route = 'https://mitane-backend.herokuapp.com/auth';
    switch (role) {
      case 'farmer':
        route += '/f/signup';
        break;
      case 'accessory trader':
        route += '/at/signup';
        break;
      case 'product trader':
        route += '/pt/signup';
        break;
      case 'tool trader':
        route += '/tt/signup';
        break;
      default:
        route += '/u/signup';
        break;
    }

    try {
      Response response = await dio.post("$route", data: {
        'name': name,
        'phone_no': phone,
        'password': password,
        'repeat_password': confirm
      });
      print('here');
      if (response.statusCode == 200) {
        print(response.data);
        return true;
      }

      return false;
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> saveUserOnLocal(User user) async {
    try {
      await storage.write(key: "name", value: user.name);
      await storage.write(key: "phone", value: user.phone);
      await storage.write(key: "id", value: user.id);
      await storage.write(key: "role", value: user.roles[0].toString());
      await storage.write(key: "password", value: user.password);
      await storage.write(key: "token", value: user.token);
      return true;
    } catch (e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>> getUserOnLocal() async {
    if (await storage.containsKey(key: 'token')) {
      String? token = await storage.read(key: 'token');
      String? name = await storage.read(key: 'name');
      String? id = await storage.read(key: 'id');
      String? phone = await storage.read(key: 'phone');
      String? role = await storage.read(key: 'role');
      String? password = await storage.read(key: 'password');

      return {
        '_id': id,
        'name': name,
        'token': token,
        'phone': phone,
        'roles': [role],
        'password': password
      };
    } else {
      return {};
    }
  }

  // static String? getStringToken() {
  //   AuthDataProvider.getToken().then((value) => value);
  // }

}
