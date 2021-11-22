import 'package:dio/dio.dart';
import 'package:mitane_frontend/domain/auth/entity/auth_model.dart';
import 'package:mitane_frontend/domain/auth/validation/invalid_validation.dart';
import 'package:mitane_frontend/infrastructure/auth/data_provider/auth_provider.dart';

class AuthRepository {
  final AuthDataProvider authDataProvider;

  AuthRepository({required this.authDataProvider});

  Future<Map<String, dynamic>> checkUser() async {
    return authDataProvider.getUserOnLocal();
  }

  Future<User> signIn(Login login) async {
    try {
      return await authDataProvider.loginUser(login);
    } on DioError catch (e) {
      print(e.response);
      throw InvalidCredential(failedValue: e.response!.data["message"]);
    }
  }

  Future<bool> signUp(Register register) async {
    switch (register.role) {
      case '1':
        register.role = 'farmer';
        break;
      case '2':
        register.role = 'accesory trader';
        break;
      case '3':
        register.role = 'product trader';
        break;
      case '4':
        register.role = 'tool trader';
        break;
      default:
        register.role = 'user';
        break;
    }
    print(register.phone);

    final response = await authDataProvider.registerUser(register);
    return response;
  }
}
