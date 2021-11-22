import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mitane_frontend/presentation/pages/common/navigation_drawer.dart';
import 'package:mitane_frontend/presentation/pages/farmer/ingredientItems/store_ingredients_display_screen.dart';
import 'package:mitane_frontend/presentation/pages/farmer/machineryItems/store_machinary_display_screen.dart';
import 'package:mitane_frontend/presentation/pages/farmer/productItems/store_product_display_screen.dart';

import 'package:mitane_frontend/util/const.dart';

class StoreDisplay extends StatelessWidget {
  static const String routeName = '/store/products';

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
                        image: AssetImage("assets/vector backc.png"))),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Store Items",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        height: 120.0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return StoreProductDisplay();
                            }));
                          },
                          child: Card(
                              color: Color(0xDD8CC63E),
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    FaIcon(
                                      FontAwesomeIcons.spa,
                                      color: Colors.white,
                                      size: 80,
                                    ),
                                    Text(
                                      "Store Products",
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
                      SizedBox(height: 8),
                      SizedBox(
                        height: 120.0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return StoreIngredientDisplay();
                            }));
                          },
                          child: Card(
                              color: Color(0xDD8CC63E),
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    FaIcon(
                                      FontAwesomeIcons.handsHelping,
                                      color: Colors.white,
                                      size: 80,
                                    ),
                                    Text(
                                      "Store Ingredients",
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
                      SizedBox(height: 8),
                      SizedBox(
                        height: 120.0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return StoreMachinaryDisplay();
                            }));
                          },
                          child: Card(
                              color: Color(0xDD8CC63E),
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    FaIcon(
                                      FontAwesomeIcons.cogs,
                                      color: Colors.white,
                                      size: 80,
                                    ),
                                    Text(
                                      "Store Machineries",
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
