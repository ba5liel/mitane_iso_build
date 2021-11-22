import 'dart:io';

import 'package:mitane_frontend/domain/teams/entity/teams_model.dart';

abstract class TeamState {}

class TeamInit extends TeamState {}

class TeamFetching extends TeamState {}

class TeamFetched extends TeamState {
  final List<Team> teamss;
  TeamFetched({required this.teamss});
}

class TeamFetchFailed extends TeamState {
  String msg;
  TeamFetchFailed(this.msg);
  @override
  String toString() {
    return msg;
  }
}

class TeamStatFetch extends TeamState {
  int created;
  int joined;
  TeamStatFetch(this.created, this.joined);
}

class TeamFetchEmpty extends TeamState {}

class TeamLocationError extends TeamState {}

class TeamAdded extends TeamState {
  Team newTeam;
  TeamAdded(this.newTeam);
}

class TeamAddFailed extends TeamState {
  String msg;
  TeamAddFailed(this.msg);
}

class TeamOperationInProgress extends TeamState {
  String msg;
  TeamOperationInProgress(this.msg);
}

class TeamOperationSuccess extends TeamState {
  String msg;
  TeamOperationSuccess(this.msg);
}

class TeamOperationFailed extends TeamState {
  String msg;
  TeamOperationFailed(this.msg);
}

class ImagePicked extends TeamState {
  File file;
  ImagePicked(this.file);
}

class ImagePickedFailed extends TeamState {
  String msg;
  ImagePickedFailed(this.msg);
}

class ImagePickedClear extends TeamState {}

class TeamDeleted extends TeamState {}

class TeamLeaved extends TeamState {}

class TeamAddedMember extends TeamState {}
