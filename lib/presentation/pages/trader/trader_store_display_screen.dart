import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mitane_frontend/application/store/bloc/store_blocs.dart';
import 'package:mitane_frontend/presentation/pages/common/mainlayoutlistwithourfb.dart';
import 'package:mitane_frontend/presentation/pages/trader/machineryItems/store_machinary_display_screen.dart';
import 'package:mitane_frontend/presentation/pages/trader/productItems/store_product_display_screen.dart';

class TraderStoreDisplay extends StatelessWidget {
  static const String routeName = '/trader/store/products';

  @override
  Widget build(BuildContext context) {
    return MainLayOutListingWoFB(
      image: "assets/tractor.png",
      title: "Store Screen",
      children: [
        SizedBox(
          height: 160.0,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return TraderStoreProductDisplay();
              }));
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
          height: 160.0,
          child: GestureDetector(
            onTap: () {
              BlocProvider.of<StoreBloc>(context)..add(FetchStoreAll());
              Navigator.of(context).pushNamed('/inputs', arguments: "farmer");
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
          height: 160.0,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return TraderStoreMachineryDisplay();
              }));
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
    );
  }
}
