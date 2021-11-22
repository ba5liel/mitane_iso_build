abstract class Authentication {}

class Register extends Authentication {
  final String name;
  String phone;
  final String password;
  final String confirm;
  String role;
  Register(
      {required this.name,
      required this.phone,
      required this.password,
      required this.confirm,
      required this.role});

  List<Object> get props => [name, phone, password, confirm, role];

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
        name: json['name'],
        phone: json['phone_no'],
        password: json['password'],
        confirm: json['confirm'],
        role: json['roles']);
  }

  @override
  String toString() => 'User {name: $name, phone: $phone} confirm: $confirm';
}

class Login extends Authentication {
  final String phone;
  final String password;
  Login({required this.phone, required this.password});
}

User? currentUser;

class User extends Authentication {
  final String id;
  final String name;
  final String token;
  final String phone;
  final List<dynamic> roles;
  final String avatar;
  final String password;

  User(
      {required this.id,
      required this.name,
      required this.token,
      required this.phone,
      required this.roles,
      required this.password})
      : this.avatar = "https://avatars.dicebear.com/api/gridy/${name}.svg";

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['_id'],
        name: json['name'],
        phone: json['phone_no'],
        password: json['password'],
        roles: json['roles'],
        token: json['token']);
  }
}
