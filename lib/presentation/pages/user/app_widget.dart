import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitane_frontend/application/price/bloc/price_blocs.dart';
import 'package:mitane_frontend/presentation/pages/store/store_screen.dart';

import 'package:mitane_frontend/presentation/pages/user/home_page.dart';
import 'package:mitane_frontend/presentation/pages/priceHub/screens/price_hub_screen.dart';
import 'package:mitane_frontend/util/const.dart';

class UserHome extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<UserHome> {
  List<Widget> pages = [UHome(), PriceHub(), StoresDisplay()];
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
            Navigator.of(context).pushNamed('/stores', arguments: "user");
          } else if (index == 1) {
            setState(() {
              selectedPage = index;
              BlocProvider.of<PriceBloc>(context)..add(PriceFetch());
            });
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
                Icons.store,
              ),
              label: "Stores"),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
