import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mitane_frontend/application/store/bloc/store_blocs.dart';
import 'package:mitane_frontend/domain/store/entity/store_model.dart';
import 'package:mitane_frontend/presentation/pages/store/StoreScreenSelfIngredientItems.dart';
import 'package:mitane_frontend/presentation/pages/store/StoreScreenSelfMachineryItems.dart';
import 'package:mitane_frontend/presentation/pages/store/StoreScreenSelfProductItems.dart';
import 'package:mitane_frontend/util/const.dart';

class StoreDisplaySelf extends StatefulWidget {
  static const String routeName = '/stores/store';

  @override
  _StoreDisplaySelfState createState() => _StoreDisplaySelfState();
}

class _StoreDisplaySelfState extends State<StoreDisplaySelf> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as List;
    final arg = arguments[0] as Store;
    return Scaffold(
        backgroundColor: Color(0xDD8CC63E),
        body: SafeArea(
            child: Column(children: [
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
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          FontAwesomeIcons.arrowLeft,
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
                        final StoreEvent event = FetchStoreById(
                          id: arg.id,
                        );
                        BlocProvider.of<StoreBloc>(context).add(event);
                        Navigator.of(context).pushNamed(
                          StoreProductDisplaySelf.routeName,
                          arguments: arguments,
                        );
                      },
                      child: Card(
                          color: Color(0xDD8CC63E),
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  SizedBox(
                    height: 120.0,
                    child: GestureDetector(
                      onTap: () {
                        final StoreEvent event = FetchStoreById(
                          id: arg.id,
                        );
                        BlocProvider.of<StoreBloc>(context).add(event);
                        Navigator.of(context).pushNamed(
                          StoreIngredientDisplaySelf.routeName,
                          arguments: arguments,
                        );
                      },
                      child: Card(
                          color: Color(0xDD8CC63E),
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  SizedBox(
                    height: 120.0,
                    child: GestureDetector(
                      onTap: () {
                        final StoreEvent event = FetchStoreById(
                          id: arg.id,
                        );
                        BlocProvider.of<StoreBloc>(context).add(event);
                        Navigator.of(context).pushNamed(
                          StoreMachineryDisplaySelf.routeName,
                          arguments: arguments,
                        );
                      },
                      child: Card(
                          color: Color(0xDD8CC63E),
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
        ])));
  }
}
