import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mitane_frontend/presentation/pages/common/navigation_drawer.dart';
import 'package:mitane_frontend/util/const.dart';

class MainLayOut extends StatelessWidget {
  const MainLayOut({
    Key? key,
    required this.children,
  }) : super(key: key);
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
        controller: zoomDrawerController,
        mainScreenScale: .3,
        style: DrawerStyle.Style1,
        showShadow: true,
        menuScreen: NaviagationDrawer(),
        mainScreen: Scaffold(
            body: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: Constants.primary,
                    image: DecorationImage(
                        alignment: Alignment.bottomCenter,
                        image: AssetImage("assets/homepage.jpg"))),
                child: SafeArea(
                    child: SingleChildScrollView(
                        // margin: EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            SizedBox(width: 50)
                          ]),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/mitanelogo.png"))),
                      width: double.infinity,
                      height: 80,
                    ),
                    SizedBox(height: 60),
                    ...children,
                  ],
                ))))));
  }
}
