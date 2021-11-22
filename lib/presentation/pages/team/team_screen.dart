import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mitane_frontend/application/teams/bloc/team_bloc.dart';
import 'package:mitane_frontend/application/teams/events/teams_events.dart';
import 'package:mitane_frontend/application/teams/states/teams_state.dart';
import 'package:mitane_frontend/domain/teams/entity/teams_model.dart';
import 'package:mitane_frontend/infrastructure/teams/repository/teams_repository.dart';
import 'package:mitane_frontend/presentation/pages/common/mainlayoutlist.dart';
import 'package:mitane_frontend/presentation/pages/common/navigation_drawer.dart';
import 'package:mitane_frontend/presentation/pages/custom_widgets/widgets/emptyresult.dart';
import 'package:mitane_frontend/presentation/pages/team/team_add_screen.dart';
import 'package:mitane_frontend/presentation/pages/team/team_expanded.dart';
import 'package:mitane_frontend/util/const.dart';

List<Color> colors = [Constants.primary];

class TeamScreen extends StatefulWidget {
  const TeamScreen();
  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TeamBloc>().add(FetchTeam());
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: zoomDrawerController,
      mainScreenScale: .3,
      style: DrawerStyle.Style1,
      showShadow: true,
      menuScreen: NaviagationDrawer(),
      mainScreen: Scaffold(
        backgroundColor: Color(0xDD8CC63E),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                        image: AssetImage("assets/teamC.png"))),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              zoomDrawerController.toggle!();
                            },
                            icon: Icon(
                              FontAwesomeIcons.hamburger,
                              size: 25,
                              color: Colors.white,
                            )),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: 70,
                    ),
                    SizedBox(height: 35),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                      color: Constants.primary,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: ListView(
                    children: [
                      TeamStat(),
                      TeamSection(
                          title: "Teams created", child: TeamICreated()),
                      TeamSection(title: "Teams Joined", child: TeamJoined()),
                      TeamSection(title: "Near By team", child: TeamsNearBy()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TeamStat extends StatefulWidget {
  const TeamStat({
    Key? key,
  }) : super(key: key);

  @override
  State<TeamStat> createState() => _TeamStatState();
}

class _TeamStatState extends State<TeamStat> {
  late TeamBloc _teamBlocTeamStat;

  @override
  void initState() {
    super.initState();
    _teamBlocTeamStat =
        new TeamBloc(teamsRepository: context.read<TeamRepository>());
    _teamBlocTeamStat.add(FetchTeamStat());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamBloc, TeamState>(
        bloc: _teamBlocTeamStat,
        builder: (context, state) {
          print("_teamBlocTeamStat $state");
          return Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Text("Joined Teams".toUpperCase(),
                        style: TextStyle(color: Colors.white70)),
                    SizedBox(height: 25),
                    Text(
                        (state is TeamStatFetch)
                            ? state.joined.toString()
                            : "-",
                        style: TextStyle(
                            color: Color(0xff505051),
                            fontWeight: FontWeight.bold)),
                  ]),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      border: Border(
                          left:
                              BorderSide(width: .7, color: Color(0xff4a4a4a)))),
                  child: Column(children: [
                    Text("Team created".toUpperCase(),
                        style: TextStyle(color: Colors.white70)),
                    SizedBox(height: 25),
                    Text(
                        (state is TeamStatFetch)
                            ? state.created.toString()
                            : "-",
                        style: TextStyle(
                            color: Color(0xff505051),
                            fontWeight: FontWeight.bold)),
                  ]),
                ),
              ),
            ],
          );
        });
  }
}

class TeamSection extends StatelessWidget {
  const TeamSection({Key? key, required this.child, required this.title})
      : super(key: key);
  final Widget child;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 15),
        Text(title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        SizedBox(height: 25),
        child
      ],
    );
  }
}

class TeamICreated extends StatelessWidget {
  const TeamICreated({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamBloc, TeamState>(builder: (context, state) {
      print(state);
      if (state is TeamFetched) {
        final List<Team> teams = state.teamss;
        return Column(children: [
          for (var i = 0; i < teams.length; i++) TeamCard(team: teams[i])
        ]);
      }
      if (state is TeamOperationInProgress) {
        return InprogressWidget(msg: state.msg);
      }

      if (state is TeamFetchEmpty) {
        return EmptyResult(
            title: "Opps! No team yet",
            description:
                "You don't have a team of your own right now. you can create a team below!",
            btntxt: 'Create Team',
            onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TeamCreate()),
                ));
      }
      if (state is TeamFetchFailed) {
        return Center(child: Text('Error: ${state.msg}'));
      }
      return Center(child: Text('No State !'));
    });
  }
}

class InprogressWidget extends StatelessWidget {
  const InprogressWidget({Key? key, required this.msg}) : super(key: key);
  final String msg;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(),
          ),
          SizedBox(height: 5),
          Text(msg, style: TextStyle(color: Colors.white))
        ],
      ),
    );
  }
}

class TeamCard extends StatelessWidget {
  const TeamCard({
    Key? key,
    required this.team,
  }) : super(key: key);

  final Team team;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
          ..push(MaterialPageRoute(builder: (context) {
            return TeamExpandScreen(team: team);
          }));
      },
      child: Container(
        decoration: BoxDecoration(
            color: colors[Random().nextInt(colors.length)],
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(team.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold)),
                      Text("Team",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w300)),
                    ],
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage("${team.profileImage}")),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border(right: BorderSide(color: Colors.white12))),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                    child: Icon(
                      Icons.people,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      for (int j = 0; j < min(team.users.length, 3); j++)
                        Container(
                          width: 50,
                          height: 50,
                          margin: EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: SvgPicture.network(
                            '${team.users[j].avatar}',
                            semanticsLabel: 'A shark?!',
                            placeholderBuilder: (BuildContext context) =>
                                Container(
                                    padding: const EdgeInsets.all(30.0),
                                    child: const CircularProgressIndicator()),
                          ),
                        ),
                      if (team.users.length > 3)
                        Container(
                          width: 50,
                          height: 50,
                          margin: EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                            color: Constants.primary,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              '${team.users.length - 4}+',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25),
                            ),
                          ),
                        )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TeamsNearBy extends StatefulWidget {
  const TeamsNearBy({
    Key? key,
  }) : super(key: key);

  @override
  State<TeamsNearBy> createState() => _TeamsNearByState();
}

class _TeamsNearByState extends State<TeamsNearBy> {
  late TeamBloc _teamBlocNearByTeam;

  @override
  void initState() {
    super.initState();
    _teamBlocNearByTeam =
        new TeamBloc(teamsRepository: context.read<TeamRepository>());
    _teamBlocNearByTeam.add(FetchNearByAll());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamBloc, TeamState>(
        bloc: _teamBlocNearByTeam,
        builder: (context, state) {
          print(state);
          if (state is TeamFetched) {
            final List<Team> teams = state.teamss;
            return Column(children: [
              for (var i = 0; i < teams.length; i++) TeamCard(team: teams[i])
            ]);
          }
          if (state is TeamOperationInProgress) {
            return InprogressWidget(msg: state.msg);
          }

          if (state is TeamFetchEmpty) {
            return EmptyResult(
                title: "Opps! No team yet",
                description:
                    "You don't have a team of your own right now. you can create a team below!",
                btntxt: 'Create Team',
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TeamCreate()),
                    ));
            ;
          }
          if (state is TeamFetchFailed) {
            return Center(child: Text('Error: ${state.msg}'));
          }
          return Center(child: Text('No State !'));
        });
  }
}

class TeamJoined extends StatefulWidget {
  const TeamJoined({
    Key? key,
  }) : super(key: key);

  @override
  State<TeamJoined> createState() => _TeamJoinedState();
}

class _TeamJoinedState extends State<TeamJoined> {
  late TeamBloc _teamBlocOwnTeam;

  @override
  void initState() {
    super.initState();
    _teamBlocOwnTeam =
        new TeamBloc(teamsRepository: context.read<TeamRepository>());
    _teamBlocOwnTeam.add(FetchJoinedTeam());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamBloc, TeamState>(
        bloc: _teamBlocOwnTeam,
        builder: (context, state) {
          print(state);
          if (state is TeamFetched) {
            final List<Team> teams = state.teamss;
            return Column(children: [
              for (var i = 0; i < teams.length; i++) TeamCard(team: teams[i])
            ]);
          }
          if (state is TeamOperationInProgress) {
            return InprogressWidget(msg: state.msg);
          }

          if (state is TeamFetchEmpty) {
            return EmptyResult(
                title: "Opps! No team yet",
                description:
                    "You don't have a team of your own right now. you can create a team below!",
                btntxt: 'Create Team',
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TeamCreate()),
                    ));
          }
          if (state is TeamFetchFailed) {
            return Center(child: Text('Error: ${state.msg}'));
          }
          return Center(child: Text('No State !'));
        });
  }
}
