import 'package:flutter/material.dart';

import 'package:mitane_frontend/presentation/pages/trader/home_page.dart';
import 'package:mitane_frontend/presentation/pages/team/team_screen.dart';
import 'package:mitane_frontend/presentation/pages/priceHub/screens/price_hub_screen.dart';
import 'package:mitane_frontend/presentation/pages/trader/trader_store_display_screen.dart';

class TraderHome extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<TraderHome> {
  List<Widget> pages = [
    THome(),
    PriceHub(),
    TraderStoreDisplay(),
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
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) async {
          if (index == 2) {
            await showMenu(
              context: context,
              position: RelativeRect.fromLTRB(1000.0, 1000.0, 0.0, 0.0),
              items: [
                PopupMenuItem(
                  onTap: () {
                    setState(() {
                      pages[2] = TraderStoreDisplay();
                      selectedPage = 2;
                    });
                  },
                  child: Container(
                    child: Text("My store"),
                  ),
                ),
                PopupMenuItem(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => TeamScreen()));
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
        selectedItemColor: Colors.green,
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
    );
  }
}
