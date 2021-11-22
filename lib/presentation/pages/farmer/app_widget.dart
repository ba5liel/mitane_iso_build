import 'package:flutter/material.dart';

import 'package:mitane_frontend/presentation/pages/farmer/home_page.dart';
import 'package:mitane_frontend/presentation/pages/team/team_screen.dart';
import 'package:mitane_frontend/presentation/pages/priceHub/screens/price_hub_screen.dart';
import 'package:mitane_frontend/presentation/pages/farmer/store_display_screen.dart';
import 'package:mitane_frontend/util/const.dart';

class FarmerHome extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<FarmerHome> {
  List<Widget> pages = [
    FHome(),
    PriceHub(),
    StoreDisplay(),
  ];
  int selectedPage = 0;
  @override
  void initState() {
    super.initState();
    selectedPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedPage],
      backgroundColor: Constants.primary,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: BottomNavigationBar(
          elevation: 0,
          onTap: (int index) async {
            if (index == 2) {
              await showMenu(
                context: context,
                position: RelativeRect.fromLTRB(1000.0, 1000.0, 0.0, 0.0),
                items: [
                  PopupMenuItem(
                    onTap: () {
                      setState(() {
                        pages[2] = StoreDisplay();
                        selectedPage = 2;
                      });
                    },
                    child: Container(
                      child: Text("My store"),
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      print("called");

                      setState(() {
                        pages[2] = TeamScreen();
                        selectedPage = 2;
                      });
                    },
                    child: Container(
                      child: Text("My team"),
                    ),
                  ),
                ],
                elevation: 8.0,
              );
            } else {
              setState(() {
                selectedPage = index;
              });
            }
          },
          currentIndex: selectedPage,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey[400],
          backgroundColor: Constants.primary,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.bar_chart,
                ),
                label: "Price Hub"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: "Service"),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
