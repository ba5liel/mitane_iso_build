import 'package:flutter/material.dart';

import 'package:mitane_frontend/presentation/pages/Data_encoder/data_encoder_home.dart';

import 'package:mitane_frontend/presentation/pages/priceHub/screens/price_hub_data_encoder_screen.dart';
import 'package:mitane_frontend/presentation/pages/store/store_screen.dart';
import 'package:mitane_frontend/util/const.dart';

class EncoderHome extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<EncoderHome> {
  List<Widget> pages = [DEHome(), PriceHubDisplay(), StoresDisplay()];
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
            Navigator.of(context).pushNamed('/stores', arguments: "encoder");
          }
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
              icon: Icon(
                Icons.home,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.bar_chart,
              ),
              label: "Price"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.store,
              ),
              label: "Stores"),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
