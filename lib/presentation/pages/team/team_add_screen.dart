import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitane_frontend/application/teams/bloc/team_bloc.dart';
import 'package:mitane_frontend/application/teams/events/teams_events.dart';
import 'package:mitane_frontend/application/teams/states/teams_state.dart';
import 'package:mitane_frontend/infrastructure/teams/repository/teams_repository.dart';
import 'package:mitane_frontend/presentation/pages/custom_widgets/profilepicker.dart';

class TeamCreate extends StatefulWidget {
  static const String routeName = '/addstore';

  @override
  _TeamCreateState createState() => _TeamCreateState();
}

class _TeamCreateState extends State<TeamCreate> {
  final nameController = TextEditingController();
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  late TeamBloc _teamBloc;

  @override
  void initState() {
    super.initState();
    _teamBloc = new TeamBloc(teamsRepository: context.read<TeamRepository>());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Create a Team",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back)),
        ),
        resizeToAvoidBottomInset: false,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 15,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
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
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ChangeProfilePicture(),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(top: 15),
                              child: Form(
                                key: form,
                                child: TextFormField(
                                  controller: nameController,
                                  validator: (String? val) {
                                    if (val == null || val.isEmpty)
                                      return "Group is Required";
                                  },
                                  textAlign: TextAlign.left,
                                  decoration: InputDecoration(
                                    labelText: "Group Name",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
              SizedBox(
                height: 30.0,
              ),
              BlocBuilder<TeamBloc, TeamState>(
                  bloc: _teamBloc,
                  builder: (context, state) {
                    if (state is TeamOperationInProgress) {
                      return Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(),
                          ),
                          SizedBox(height: 5),
                          Text(state.msg)
                        ],
                      ));
                    }
                    if (state is TeamLocationError) {
                      return Center(child: Text("Please Enbale laocation"));
                    }
                    if (state is TeamAdded) {
                      return Container(
                        child: Text('Team created'),
                      );
                    }
                    if (state is TeamOperationSuccess) {
                      return Container(
                        child: Text(state.msg),
                      );
                    }
                    if (state is TeamAddFailed) {
                      return Container(
                        child: Text('failed adding'),
                      );
                    }

                    return GestureDetector(
                      onTap: () {
                        if (form.currentState!.validate()) {
                          context
                              .read<TeamBloc>()
                              .add(AddTeam(nameController.text));
                        }
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Color(0xDD8CC63E)),
                          child: Text(
                            'Create Team',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )),
                    );
                  })
            ]));
  }
}
