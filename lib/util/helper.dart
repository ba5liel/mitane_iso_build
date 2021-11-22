import 'package:mitane_frontend/domain/teams/entity/teams_model.dart';

class Helper {
  static bool isMember(String id, Team team) =>
      team.users.indexWhere((element) => element.id == id) != -1;
}
