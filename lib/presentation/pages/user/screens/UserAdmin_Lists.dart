import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mitane_frontend/application/user/bloc/user_blocs.dart';
import 'package:mitane_frontend/domain/auth/entity/auth_model.dart';
import 'package:mitane_frontend/presentation/pages/admin/screens/Admin_Home.dart';
import 'package:mitane_frontend/presentation/pages/common/mainlayoutlistwithourfb.dart';

class AdminUsers extends StatefulWidget {
  static const routeName = '/admin/users';

  static User editArg =
      User(id: "", name: "", phone: '', password: "", roles: [], token: "");
  get curPrice => null;
  @override
  _AdminUsersState createState() => _AdminUsersState();
}

class _AdminUsersState extends State<AdminUsers> {
  @override
  Widget build(BuildContext context) {
    return MainLayOutListingWoFB(
        image: "assets/teamC.png",
        title: "Users",
        children: [
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: BlocBuilder<UserBloc, UserState>(
              builder: (_, state) {
                if (state is UserAdminOperationFailure) {
                  return Text('Error: Could not list users');
                }

                if (state is UserAdminOperationSuccess) {
                  final users = state.users;

                  return ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (_, int index) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: UserCard(
                            userName: users.elementAt(index).name,
                            phoneNo: users.elementAt(index).phone,
                            role: users.elementAt(index).roles,
                            avatar: users.elementAt(index).avatar,
                          ),
                        );
                      });
                }
                return Center(
                    child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    color: Colors.black26,
                  ),
                ));
              },
            ),
          )
        ]);
  }
}

class UserCard extends StatelessWidget {
  final String userName;
  final String phoneNo;
  final List<dynamic> role;
  final String avatar;
  const UserCard(
      {Key? key,
      required this.userName,
      required this.phoneNo,
      required this.role,
      required this.avatar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            SvgPicture.network(
              '${avatar}',
              semanticsLabel: 'Zombies..',
              placeholderBuilder: (BuildContext context) => Container(
                  padding: const EdgeInsets.all(10.0),
                  child: const CircularProgressIndicator()),
              height: 50,
              width: 50,
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$userName",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: "RobotMono"),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Text(
                        "Role:",
                        style: TextStyle(fontSize: 16, fontFamily: "RobotMono"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "${role[0]['name']}",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Phone No:",
                          style:
                              TextStyle(fontSize: 16, fontFamily: "RobotMono"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "+$phoneNo",
                            style: TextStyle(fontSize: 16.0),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ])),
    );
  }
}
