import 'package:mitane_frontend/domain/role/entity/role_model.dart';
import 'package:mitane_frontend/infrastructure/user/data_provider/user_provider.dart';
import 'package:mitane_frontend/domain/auth/entity/auth_model.dart';

class UserRepository {
  final UserDataProvider dataProvider;
  UserRepository({required this.dataProvider});

  Future<User> create(User user) async {
    return this.dataProvider.create(user);
  }

  Future<User> update(String id, User user) async {
    return this.dataProvider.update(id, user);
  }

  Future<List<User>> fetchAll() async {
    return this.dataProvider.fetchAll();
  }

  Future<List<Role>> fetchAllRoles() async {
    return this.dataProvider.fetchAllRoles();
  }

  Future<List<User>> fetchAllUsersByRole(String role) async {
    return this.dataProvider.fetchAllUsersByRole(role);
  }

  Future<void> delete(String id) async {
    this.dataProvider.delete(id);
  }
}
