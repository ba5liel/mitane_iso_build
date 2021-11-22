import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mitane_frontend/presentation/pages/common/navigation_drawer.dart';
import 'package:mitane_frontend/util/const.dart';

class MainLayOutListing extends StatelessWidget {
  const MainLayOutListing(
      {Key? key,
      required this.children,
      required this.title,
      this.back,
      required this.create,
      required this.image})
      : super(key: key);
  final List<Widget> children;
  final String image;
  final String title;
  final Function create;
  final Function? back;
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
        controller: zoomDrawerController,
        mainScreenScale: .3,
        style: DrawerStyle.Style1,
        showShadow: true,
        menuScreen: NaviagationDrawer(),
        mainScreen: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: Stack(children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 300,
                child: Container(
                    decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: Constants.primary,
                ))),
            Positioned.fill(
                child: SafeArea(
                    child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          alignment: Alignment.bottomCenter,
                          fit: BoxFit.contain,
                          image: AssetImage(
                            image,
                          ))),
                  width: double.infinity,
                  height: 240,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () => (back != null)
                                      ? back!()
                                      : Navigator.pop(context),
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ))
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 50),
                        child: Text(title,
                            style: TextStyle(
                              height: 1.3,
                              color: Colors.white,
                              fontSize: 32,
                            )),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF8CC63E),
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 2, right: 2),
                  margin:
                      EdgeInsets.only(top: 10, bottom: 0, left: 10, right: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Decide your share of the market!",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "RobotMono",
                            color: Colors.white),
                      ),
                      Text(
                        DateFormat.yMMMd().format(DateTime.now()),
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "RobotMono",
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Column(
                  children: [
                    ...children,
                  ],
                ))
              ],
            )))
          ]),
          floatingActionButton: FloatingActionButton(
            onPressed: () => create(),
            child: const Icon(
              Icons.add,
              color: Colors.green,
            ),
            backgroundColor: Colors.white,
          ),
        ));
  }
}
