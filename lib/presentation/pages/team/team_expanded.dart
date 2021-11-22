import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mitane_frontend/application/teams/bloc/team_bloc.dart';
import 'package:mitane_frontend/application/teams/events/teams_events.dart';
import 'package:mitane_frontend/application/teams/states/teams_state.dart';
import 'package:mitane_frontend/domain/auth/entity/auth_model.dart';
import 'package:mitane_frontend/domain/teams/entity/teams_model.dart';
import 'package:mitane_frontend/infrastructure/teams/repository/teams_repository.dart';
import 'package:mitane_frontend/presentation/pages/common/mitane_button.dart';
import 'package:mitane_frontend/util/helper.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamExpandScreen extends StatefulWidget {
  const TeamExpandScreen({Key? key, required this.team}) : super(key: key);
  final Team team;

  @override
  State<TeamExpandScreen> createState() => _TeamExpandScreenState();
}

class _TeamExpandScreenState extends State<TeamExpandScreen> {
  void call(String number) => launch("tel:$number");

  void sendSms(String number) => launch("sms:$number");
  late TeamBloc _teamBloc;
  late Team _team;
  @override
  void initState() {
    super.initState();
    _team = widget.team;
    _teamBloc = new TeamBloc(teamsRepository: context.read<TeamRepository>());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe7e9ee),
      body: BlocBuilder<TeamBloc, TeamState>(
        bloc: _teamBloc,
        builder: (context, state) {
          return SafeArea(
              child: CustomScrollView(slivers: [
            SliverPersistentHeader(
              delegate: MyDelegate(team: _team, bloc: _teamBloc),
              floating: true,
              pinned: true,
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              BlocListener<TeamBloc, TeamState>(
                bloc: _teamBloc,
                listener: (context, state) {
                  print("TeamExpand $state");
                  if (state is TeamDeleted) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Team Deleted")));
                  }
                  if (state is TeamOperationFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error: ${state.msg}")));
                  }
                  if (state is TeamLeaved) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("You leaved the Team")));
                  }
                  if (state is TeamAdded) {
                    setState(() {
                      _team = state.newTeam;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("You joined the Team")));
                  }
                },
                child: Container(),
              ),
              SizedBox(
                height: 15,
              ),
              for (var i = 0; i < _team.users.length; i++)
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            margin: EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                              color: Colors.white60,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: SvgPicture.network(
                              '${_team.users[i].avatar}',
                              semanticsLabel: 'A shark?!',
                              placeholderBuilder: (BuildContext context) =>
                                  Container(
                                      padding: const EdgeInsets.all(30.0),
                                      child: const CircularProgressIndicator()),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _team.users[i].name,
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 16),
                              ),
                              Text(
                                _team.users[i].id == _team.admin.id
                                    ? "Admin"
                                    : "Member",
                                style: TextStyle(fontWeight: FontWeight.w400),
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              sendSms(_team.users[i].phone);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 8,
                                        color:
                                            Color(0xffeeab05).withOpacity(.3),
                                        offset: Offset(0,
                                            5)), //0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23)
                                    BoxShadow(
                                        blurRadius: 18,
                                        color:
                                            Color(0xffeeab05).withOpacity(.5),
                                        offset: Offset(0,
                                            6)) //0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23)
                                  ],
                                  color: Color(0xffeeab05),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Icon(
                                Icons.textsms,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              call(_team.users[i].phone);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 8,
                                        color:
                                            Color(0xff04a56d).withOpacity(.3),
                                        offset: Offset(0,
                                            5)), //0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23)
                                    BoxShadow(
                                        blurRadius: 18,
                                        color:
                                            Color(0xff04a56d).withOpacity(.5),
                                        offset: Offset(0,
                                            6)) //0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23)
                                  ],
                                  color: Color(0xff04a56d),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Icon(
                                Icons.phone,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
            ]))
          ]));
        },
      ),
    );
  }
}

class MyDelegate extends SliverPersistentHeaderDelegate {
  MyDelegate({required this.team, required this.bloc});
  final Team team;
  final TeamBloc bloc;
  @override
  Widget build(context, double shrinkOffset, bool overlapsContent) {
    var shrinkPercentage =
        min(1, shrinkOffset / (maxExtent - minExtent)).toDouble();
    print("Admin ${team.admin.name} ${team.admin.id}");
    print("Current ${currentUser!.name} ${currentUser!.id}");
    print(team.admin.id == currentUser!.id);

    return Stack(
      clipBehavior: Clip.hardEdge,
      fit: StackFit.expand,
      children: [
        Column(
          children: [
            Flexible(
              flex: 1,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 100),
                opacity: 1 - shrinkPercentage,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.green,
                  height: 900,
                ),
              ),
            ),
          ],
        ),
        Stack(
          clipBehavior: Clip.hardEdge,
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(begin: Alignment.topLeft, colors: [
                  Color(0xff8CC63E),
                  Color(0xff709E2F),
                ])),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: kToolbarHeight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.chevron_left,
                                size: 24.0,
                                color: Colors.white,
                              ),
                            ),
                            AnimatedOpacity(
                              duration: Duration(milliseconds: 500),
                              opacity: shrinkPercentage,
                              child: Text(team.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0)),
                            ),
                            SizedBox(width: 5)
                          ],
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 500),
                      opacity: max(1 - shrinkPercentage * 6, 0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        NetworkImage("${team.profileImage}")),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(team.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32)),
                            Text("${team.users.length} People",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white)),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (currentUser!.roles[0] == "admin" ||
                            team.admin.id == currentUser!.id)
                          MitaneButton(
                              onPressed: () => bloc.add(DeleteTeam(team.id)),
                              title: "Deleted Team",
                              start: Color(0xffff2300),
                              end: Color(0xffda012c)),
                        if (currentUser!.roles[0] != "admin" &&
                            team.admin.id != currentUser!.id &&
                            Helper.isMember(currentUser!.id, team))
                          MitaneButton(
                              onPressed: () => bloc.add(LeaveTeam(team.id)),
                              title: "Leave Team",
                              start: Color(0xffff2300),
                              end: Color(0xffda012c)),
                        if (currentUser!.roles[0] != "admin" &&
                            !Helper.isMember(currentUser!.id, team))
                          MitaneButton(
                              onPressed: () => bloc.add(AddMemeberTeam(
                                  newMember: [currentUser!.id],
                                  teamId: team.id)),
                              title: "Join Team",
                              start: Color(0xff4166f5),
                              end: Color(0xff4766ff)),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  double get maxExtent => 400;

  @override
  double get minExtent => 110;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
