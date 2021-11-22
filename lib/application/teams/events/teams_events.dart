import 'dart:io';

abstract class TeamEvent {}

enum SOURCE { CAMERA, LIBRARY }

class CreateTeam extends TeamEvent {
  String name;
  File? image;
  CreateTeam({required this.name, this.image});
}

class PickImage extends TeamEvent {
  final SOURCE source;
  PickImage(this.source);
}

class CropImage extends TeamEvent {}

class ClearImage extends TeamEvent {}

class AddTeam extends TeamEvent {
  final String name;
  AddTeam(this.name);
}

class FetchTeam extends TeamEvent {}

class FetchTeamStat extends TeamEvent {}

class FetchJoinedTeam extends TeamEvent {}

class FetchTeamAll extends TeamEvent {}

class FetchNearByAll extends TeamEvent {}

class AddMemeberTeam extends TeamEvent {
  final List<String> newMember;
  final String teamId;
  AddMemeberTeam({required this.newMember, required this.teamId});
}

class LeaveTeam extends TeamEvent {
  final String teamId;
  LeaveTeam(this.teamId);
}

class UpdateTeamName extends TeamEvent {
  final int teamId;
  final String name;
  UpdateTeamName(this.teamId, this.name);
}

class UpdateTeamImage extends TeamEvent {
  final int teamId;
  final File image;

  UpdateTeamImage(this.teamId, this.image);
}

class DeleteTeam extends TeamEvent {
  final String teamId;
  DeleteTeam(this.teamId);
}
