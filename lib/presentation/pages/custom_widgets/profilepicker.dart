import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitane_frontend/application/teams/bloc/team_bloc.dart';
import 'package:mitane_frontend/application/teams/events/teams_events.dart';
import 'package:mitane_frontend/application/teams/states/teams_state.dart';

class ChangeProfilePicture extends StatelessWidget {
  ChangeProfilePicture({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamBloc, TeamState>(builder: (context, state) {
      return Column(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(100)),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 16,
                      color: Color(0x00).withOpacity(.05),
                      offset: Offset(0,
                          10)), //0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23)
                  BoxShadow(
                      blurRadius: 18,
                      color: Color(0x00).withOpacity(.075),
                      offset: Offset(0,
                          12)) //0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23)
                ],
              ),
              child: Builder(builder: (context) {
                if (state is ImagePickedFailed) return Text(state.msg);
                if (state is ImagePicked)
                  return CircleAvatar(
                    radius: 40,
                    backgroundImage: FileImage(state.file),
                  );
                return CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage("assets/images/camera.jpg"),
                );
              })),
          Column(children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.photo_camera),
                    onPressed: () {
                      context.read<TeamBloc>().add(PickImage(SOURCE.CAMERA));
                    }),
                IconButton(
                    icon: Icon(Icons.photo_library),
                    onPressed: () {
                      context.read<TeamBloc>().add(PickImage(SOURCE.LIBRARY));
                    }),
              ],
            ),
            if (context.read<TeamBloc>().selectedfile != null)
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.crop),
                    onPressed: () => context.read<TeamBloc>().add(CropImage()),
                  ),
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () => context.read<TeamBloc>().add(ClearImage()),
                  )
                ],
              )
          ]),
        ],
      );
    });
  }
}
