import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mitane_frontend/presentation/pages/common/mainlayout.dart';

class DEHome extends StatefulWidget {
  @override
  _Dashboard createState() {
    return _Dashboard();
  }
}

class _Dashboard extends State<DEHome> {
  @override
  Widget build(BuildContext context) {
    return MainLayOut(
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
                    Navigator.of(context)
                        .pushNamed('/product', arguments: "encoder");
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
                    Navigator.of(context)
                        .pushNamed('/inputs', arguments: "encoder");
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
                    Navigator.of(context)
                        .pushNamed('/machinery', arguments: "encoder");
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
            ],
          )
        ])),
      ],
    );
  }
}
