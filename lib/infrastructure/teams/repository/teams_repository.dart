import 'dart:io';

import 'package:mitane_frontend/domain/teams/entity/teams_model.dart';
import 'package:mitane_frontend/infrastructure/teams/data_provider/teams_provider.dart';

class TeamRepository {
  final TeamProvider teamsProvider;
  TeamRepository({required this.teamsProvider});

  Future<bool> createTeam(String name, longitude, latitude, File? image) async {
    try {
      final bool result =
          await teamsProvider.createTeam(name, longitude, latitude, image);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Team>> getSelfTeam() async {
    try {
      final List<Map<String, dynamic>> result =
          await teamsProvider.getSelfTeam();
      return result.map((e) => Team.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getTeamStat() async {
    try {
      final Map<String, dynamic> result = await teamsProvider.getTeamStat();
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Team>> getJoinedTeam() async {
    try {
      final List<Map<String, dynamic>> result =
          await teamsProvider.getJoinedTeam();
      return result.map((e) => Team.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Team>> getAllTeam() async {
    try {
      final List<Map<String, dynamic>> result =
          await teamsProvider.getAllTeams();
      return result.map((e) => Team.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Team>> getNearByTeams(latitude, longitude) async {
    try {
      final List<Map<String, dynamic>> result =
          await teamsProvider.getNearByTeams(latitude, longitude);
      return result.map((e) => Team.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Team> addMemeber(List<String> newMemebers, String teamId) async {
    try {
      final result = await teamsProvider.addMemeber(newMemebers, teamId);
      return Team.fromMap(result);
    } catch (e, s) {
      print(e);
      print(s);
      rethrow;
    }
  }

  Future<bool> delete(String teamId) async {
    try {
      final result = await teamsProvider.delete(teamId);
      return result;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateName(int teamId, String name) async {
    try {
      final result = await teamsProvider.updateName(teamId, name);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateImage(int teamId, File image) async {
    try {
      final result = await teamsProvider.updateImage(teamId, image);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> leaveTeam(String teamId) async {
    try {
      final result = await teamsProvider.leaveTeam(teamId);
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
