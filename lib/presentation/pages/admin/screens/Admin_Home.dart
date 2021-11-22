import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mitane_frontend/application/machinery/bloc/machinery_blocs.dart';
import 'package:mitane_frontend/presentation/pages/agri_inputs/screens/IngredientAdmin_Lists.dart';
import 'package:mitane_frontend/presentation/pages/agri_product/screens/ProductAdmin_Lists.dart';
import 'package:mitane_frontend/presentation/pages/common/mainlayout.dart';
import 'package:mitane_frontend/presentation/pages/machinery/screens/MachineryAdmin_Lists.dart';
import 'package:mitane_frontend/presentation/pages/team/admin/team_screen.dart';
import 'package:mitane_frontend/presentation/pages/user/screens/UserAdmin_Lists.dart';
import 'package:mitane_frontend/presentation/pages/priceHub/screens/price_hub_screen.dart';
import 'package:mitane_frontend/util/const.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  static String routeName = '/admin';

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int selectedPage = 0;
  @override
  void initState() {
    super.initState();
    selectedPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primary,
      body: MainLayOut(
        children: [
          Center(
              child: Wrap(spacing: 20, runSpacing: 20.0, children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 150.0,
                  height: 160.0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminProducts(),
                          ));
                    },
                    child: Card(
                        color: Color(0xDD8CC63E),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              FaIcon(
                                FontAwesomeIcons.spa,
                                color: Colors.white,
                                size: 80,
                              ),
                              Text(
                                "Agricultural Products",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  width: 150.0,
                  height: 160.0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminIngredients(),
                          ));
                    },
                    child: Card(
                        color: Color(0xDD8CC63E),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              FaIcon(
                                FontAwesomeIcons.handsHelping,
                                color: Colors.white,
                                size: 80,
                              ),
                              Text(
                                "Agricultural Inputs",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 150.0,
                  height: 160.0,
                  child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<MachineryBloc>(context)
                        ..add(MachineryAdminLoad());
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminMachineries(),
                          ));
                    },
                    child: Card(
                        color: Color(0xDD8CC63E),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              FaIcon(
                                FontAwesomeIcons.cogs,
                                color: Colors.white,
                                size: 80,
                              ),
                              Text(
                                "Machineries",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  width: 150.0,
                  height: 160.0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminUsers(),
                          ));
                    },
                    child: Card(
                        color: Color(0xDD8CC63E),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              FaIcon(
                                FontAwesomeIcons.userFriends,
                                color: Colors.white,
                                size: 80,
                              ),
                              Text(
                                "Users",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 150.0,
                  height: 160.0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed('/stores', arguments: "admin");
                    },
                    child: Card(
                        color: Color(0xDD8CC63E),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              FaIcon(
                                FontAwesomeIcons.store,
                                color: Colors.white,
                                size: 80,
                              ),
                              Text(
                                "Stores",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  width: 150.0,
                  height: 160.0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminTeamScreen(),
                          ));
                    },
                    child: Card(
                        color: Color(0xDD8CC63E),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              FaIcon(
                                FontAwesomeIcons.users,
                                color: Colors.white,
                                size: 80,
                              ),
                              Text(
                                "Teams",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            )
          ])),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) async {
          setState(() {
            selectedPage = index;
          });
        },
        currentIndex: selectedPage,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[400],
        backgroundColor: Constants.primary,
        items: [
          BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminHome(),
                      ));
                },
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.bar_chart),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PriceHub(),
                      ));
                },
              ),
              label: "Price Hub"),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
