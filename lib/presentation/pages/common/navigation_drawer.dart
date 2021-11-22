import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:mitane_frontend/domain/auth/entity/auth_model.dart';
import 'package:mitane_frontend/util/const.dart';

final ZoomDrawerController zoomDrawerController = new ZoomDrawerController();

class NaviagationDrawer extends StatelessWidget {
  NaviagationDrawer({Key? key}) : super(key: key);
  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.blue,
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Constants.primary,
        ),
        child: Drawer(
          child: new ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () => {zoomDrawerController.close!()},
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                        )),
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/mitanelogo.png"))),
                      width: 100,
                      height: 50,
                    ),
                    SizedBox(width: 50)
                  ],
                ),
              ),
              SizedBox(height: 50),
              ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    'Hello,\n${currentUser!.name}',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 23,
                      color: const Color(0xffffffff),
                      letterSpacing: -0.0011999999731779098,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              SizedBox(height: 30),
              _buildList(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  icon: Icons.home,
                  title: "Home"),
              _buildList(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  icon: Icons.store,
                  title: "Store"),
              SizedBox(
                height: 5,
              ),
              Divider(
                color: Color(0xffffffff),
                endIndent: 150,
              ),
              SizedBox(
                height: 5,
              ),
              _buildList(
                  onTap: () {
                    Navigator.pop(context);
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Terms & Conditions'),
                        content: const Text(
                            'A farming digitization flutter app. It serves as pricehub and markethub for users (farmers, traders, farming, accessories, traders/renters) A farming digitization flutter app. It serves as pricehub and markethub for users (farmers, traders, farming, accessories, traders/renters) A farming digitization flutter app. It serves as pricehub and markethub for users (farmers, traders, farming, accessories, traders/renters) A farming digitization flutter app. It serves as pricehub and markethub for users (farmers, traders, farming, accessories, traders/renters)'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Agree'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: Icons.note,
                  title: "Terms and Conditions"),
              _buildList(
                  onTap: () {
                    Navigator.pop(context);
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Mitane 1.0'),
                        content: const Text(
                            'A farming digitization flutter app. It serves as pricehub and markethub for users (farmers, traders, farming, accessories, traders/renters)'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: Icons.help,
                  title: 'About Mintane'),
              _buildList(
                  onTap: () async {
                    Navigator.pop(context);

                    await storage.deleteAll();
                    Navigator.of(context).popUntil(ModalRoute.withName('/welcome'));
                    Navigator.of(context).pushNamed('/welcome');
                  },
                  icon: Icons.logout,
                  title: 'Sign out'),
            ],
          ),
        ),
      ),
    );
  }

  ListTile _buildList(
      {required Function onTap,
      required String title,
      required IconData icon}) {
    return ListTile(
      dense: true,
      horizontalTitleGap: 0,
      leading: Icon(icon, color: Color(0xffffffff)),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Ubuntu',
          fontSize: 10,
          color: Color(0xffffffff),
          letterSpacing: -0.0007999999821186065,
          fontWeight: FontWeight.w300,
          height: 1.8,
        ),
        textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
        textAlign: TextAlign.left,
      ),
      onTap: () => onTap(),
    );
  }
}
