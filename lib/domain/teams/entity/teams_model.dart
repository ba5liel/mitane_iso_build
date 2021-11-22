import 'package:mitane_frontend/domain/auth/entity/auth_model.dart';

class Team {
  final String id;
  final String name;
  final User admin;
  final String profileImage;
  final List<User> users;

  Team(
      {required this.id,
      required this.name,
      required this.admin,
      required this.profileImage,
      required this.users});

  factory Team.fromMap(Map<String, dynamic> json) {
    return new Team(
        id: json["_id"],
        name: json["name"],
        admin: User.fromJson(json["admin"]),
        users: (json["users"] as List).map((e) => User.fromJson(e)).toList(),
        profileImage: json["profile_image"]);
  }

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "admin": admin.id,
        "users": users.map((e) => e.id),
        "profile_image": profileImage
      };
  @override
  String toString() {
    return "id $id name: $name, users: $users";
  }
}
