import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:mitane_frontend/application/teams/events/teams_events.dart';
import 'package:mitane_frontend/application/teams/states/teams_state.dart';
import 'package:mitane_frontend/domain/teams/entity/teams_model.dart';
import 'package:mitane_frontend/infrastructure/teams/repository/teams_repository.dart';

class TeamBloc extends Bloc<TeamEvent, TeamState> {
  final TeamRepository teamsRepository;
  TeamBloc({required this.teamsRepository}) : super(TeamInit());

  final _picker = ImagePicker();
  File? selectedfile;

  @override
  Stream<TeamState> mapEventToState(TeamEvent event) async* {
    try {
      if (event is PickImage) {
        if (event.source == SOURCE.CAMERA) {
          await pickCamera();
          if (selectedfile != null)
            yield ImagePicked(selectedfile!);
          else
            ImagePickedFailed('Image not Picked');
        }
        if (event.source == SOURCE.LIBRARY) {
          await pickLibrary();
          if (selectedfile != null)
            yield ImagePicked(selectedfile!);
          else
            ImagePickedFailed('Image not Picked');
        }
      }
      if (event is CropImage) {
        await cropImage();
        if (selectedfile != null) yield ImagePicked(selectedfile!);
      }
      if (event is ClearImage) {
        clear();
        yield ImagePickedClear();
      }
      if (event is AddTeam) {
        yield TeamOperationInProgress("Creating team");
        final LocationData? loc = await location();
        if (loc == null) {
          yield TeamLocationError();
        } else {
          final bool success = await teamsRepository.createTeam(
              event.name, loc.latitude, loc.longitude, selectedfile);
          if (success)
            yield TeamOperationSuccess("Team created");
          else
            yield TeamOperationFailed("Team creation failed");
        }
      }
      if (event is FetchTeam) {
        yield TeamOperationInProgress("Fetching my team");
        final List<Team> teams = await teamsRepository.getSelfTeam();
        if (teams.isNotEmpty) {
          yield TeamFetched(teamss: teams);
        } else
          yield TeamFetchEmpty();
      }
      if (event is FetchJoinedTeam) {
        yield TeamOperationInProgress("Fetching Joined team");
        final List<Team> teams = await teamsRepository.getJoinedTeam();
        if (teams.isNotEmpty) {
          yield TeamFetched(teamss: teams);
        } else
          yield TeamFetchEmpty();
      }
      if (event is FetchTeamAll) {
        try {
          yield TeamOperationInProgress("Fetching all Teams");
          final List<Team> teamss = await teamsRepository.getAllTeam();
          if (teamss.isNotEmpty) {
            yield TeamFetched(teamss: teamss);
          } else
            yield TeamFetchEmpty();
        } catch (e) {
          rethrow;
          yield TeamFetchFailed('${e}');
        }
      }
      if (event is FetchTeamStat) {
        try {
          yield TeamOperationInProgress("Fetching Teams stat");
          final Map<String, dynamic> stat = await teamsRepository.getTeamStat();
          yield TeamStatFetch(stat["created"], stat["joined"]);
        } catch (e) {
          yield TeamFetchFailed('${e}');
        }
      }
      if (event is FetchNearByAll) {
        try {
          yield TeamOperationInProgress("Fetching near by Teams");
          final LocationData? loc = await location();
          if (loc == null) {
            yield TeamLocationError();
          } else {
            final teamss = await teamsRepository.getNearByTeams(
                loc.latitude, loc.longitude);
            print("bloc FetchNearByAll ${teamss.isNotEmpty}");
            if (teamss.isNotEmpty) {
              print("bloc isNotEmpty ${teamss.isNotEmpty}");

              yield TeamFetched(teamss: teamss);
            } else
              yield TeamFetchEmpty();
          }
        } catch (e) {
          rethrow;
          yield TeamFetchFailed('${e}');
        }
      }

      if (event is AddMemeberTeam) {
        try {
          yield TeamOperationInProgress("Adding memebers");
          final Team newTeam =
              await teamsRepository.addMemeber(event.newMember, event.teamId);
          print("added item");
          yield TeamAdded(newTeam);
        } catch (e) {
          yield TeamOperationFailed("$e");
        }
      }

      if (event is UpdateTeamName) {
        try {
          yield TeamOperationInProgress("Updating Team name");
          final bool success =
              await teamsRepository.updateName(event.teamId, event.name);
          print("added item");
          if (success)
            yield TeamOperationSuccess("Team name updated");
          else
            yield TeamOperationSuccess("Updating Team name failed :(");
        } catch (e) {
          yield TeamAddFailed("$e");
        }
      }

      if (event is UpdateTeamImage) {
        try {
          yield TeamOperationInProgress("Updating Team image");
          final bool success =
              await teamsRepository.updateImage(event.teamId, event.image);
          print("added item");
          if (success)
            yield TeamOperationSuccess("Team image updated");
          else
            yield TeamOperationSuccess("Updating Team image failed :(");
        } catch (e) {
          yield TeamAddFailed("$e");
        }
      }

      if (event is LeaveTeam) {
        try {
          yield TeamOperationInProgress("Leaving Team");
          final bool success = await teamsRepository.leaveTeam(event.teamId);
          print("Team left LeaveTeam");
          if (success)
            yield TeamLeaved();
          else
            yield TeamOperationFailed(
                "Error occured when trying to leave team");
        } on DioError catch (e) {
          print(e.response);
          rethrow;
          yield TeamOperationFailed("$e");
        }
      }
      if (event is DeleteTeam) {
        try {
          yield TeamOperationInProgress("Deleting Team");
          final bool success = await teamsRepository.delete(event.teamId);
          print("added item");
          if (success)
            yield TeamDeleted();
          else
            yield TeamOperationFailed(
                "Error occured when trying to delete team");
        } catch (e) {
          yield TeamAddFailed("$e");
        }
      }
    } catch (e) {
      rethrow;
      yield TeamFetchFailed('$e');
    }
  }

  Future<LocationData?> location() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();

    return _locationData;
  }

  Future pickCamera() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) selectedfile = File(pickedFile.path);
  }

  Future pickLibrary() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) selectedfile = File(pickedFile.path);
  }

  Future<void> cropImage() async {
    if (selectedfile != null)
      selectedfile = await ImageCropper.cropImage(
        sourcePath: selectedfile!.path,
        maxWidth: 512,
        maxHeight: 512,
      );
  }

  void clear() {
    selectedfile = null;
  }
}
