import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mitane_frontend/application/machinery/bloc/machinery_blocs.dart';
import 'package:mitane_frontend/domain/machinery/entity/machinery_model.dart';
import 'package:mitane_frontend/presentation/pages/admin/screens/Admin_Home.dart';
import 'package:mitane_frontend/presentation/pages/common/mainlayoutlist.dart';
import 'package:mitane_frontend/presentation/pages/machinery/screens/MachineryAdmin_Edit.dart';
import 'package:mitane_frontend/presentation/pages/common/SlideEditAndDelete.dart';
import 'package:mitane_frontend/route_generator.dart';

import 'MachineryAdmin_Add.dart';

class AdminMachineries extends StatefulWidget {
  static const routeName = '/admin/machineries';

  static Machinery editArg = Machinery(id: "", name: "");

  get curPrice => null;
  @override
  _AdminMachineriesState createState() => _AdminMachineriesState();
}

class _AdminMachineriesState extends State<AdminMachineries> {
  @override
  Widget build(BuildContext context) {
    return MainLayOutListing(
      image: "assets/tractor.png",
      title: "Machinery Admin",
      back: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AdminHome()));
      },
      children: [
        SizedBox(
          height: 15,
        ),
        Expanded(
          child: BlocBuilder<MachineryBloc, MachineryState>(
            builder: (_, state) {
              if (state is MachineryAdminOperationFailure) {
                return Text('Could not Fetch');
              }

              if (state is MachineryAdminOperationSuccess) {
                final machineries = state.machineries;

                return ListView.builder(
                    itemCount: machineries.length,
                    itemBuilder: (_, int index) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        margin:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        child: Dismissible(
                          child: MachineryCard(
                            machineryName: machineries.elementAt(index).name,
                          ),
                          background: slideRightBackground(),
                          secondaryBackground: slideLeftBackground(),
                          key:
                              ValueKey<Machinery>(machineries.elementAt(index)),
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.endToStart) {
                              final bool res = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Text(
                                          "Are you sure you want to delete ${machineries.elementAt(index).name}?"),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text(
                                            "Cancel",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context, false);
                                          },
                                        ),
                                        TextButton(
                                          child: Text(
                                            "Delete",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              BlocProvider.of<MachineryBloc>(
                                                      context)
                                                  .add(MachineryAdminDelete(
                                                      machineries
                                                          .elementAt(index)
                                                          .id
                                                          .toString()));
                                              Navigator.of(context)
                                                  .pushNamedAndRemoveUntil(
                                                      AdminMachineries
                                                          .routeName,
                                                      (route) => false);
                                            });
                                          },
                                        ),
                                      ],
                                    );
                                  });
                              return res;
                            } else if (direction ==
                                DismissDirection.startToEnd) {
                              AdminMachineries.editArg =
                                  machineries.elementAt(index);
                              Navigator.of(context).pushNamed(
                                AdminMachineryEdit.routeName,
                                arguments: MachineryArgument(
                                    machinery: machineries.elementAt(index)),
                              );
                            }
                          },
                        ),
                      );
                    });
              }

              return Center(
                  child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ));
            },
          ),
        )
      ],
      create: () => Navigator.of(context).pushNamed(
        AdminMachineryAdd.routeName,
      ),
    );
  }
}

class MachineryCard extends StatelessWidget {
  final String machineryName;
  const MachineryCard({Key? key, required this.machineryName})
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
            FaIcon(
              FontAwesomeIcons.cogs,
              color: Color(0xDD8CC63E),
              size: 50,
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
                      "$machineryName",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: "RobotMono"),
                    )
                  ],
                ),
              ],
            ),
          ])),
    );
  }
}
