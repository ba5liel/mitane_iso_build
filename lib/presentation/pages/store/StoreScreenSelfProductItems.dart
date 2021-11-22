import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitane_frontend/application/store/bloc/store_blocs.dart';
import 'package:mitane_frontend/presentation/pages/common/mainlayoutlistwithourfb.dart';
import 'package:mitane_frontend/presentation/pages/custom_widgets/widgets/emptyresultwobtn.dart';

class StoreProductDisplaySelf extends StatefulWidget {
  static const String routeName = '/stores/store/productItems';

  @override
  _StoreProductDisplaySelfState createState() =>
      _StoreProductDisplaySelfState();
}

class _StoreProductDisplaySelfState extends State<StoreProductDisplaySelf> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as List;
    return MainLayOutListingWoFB(
      title: "Store Products",
      image: "assets/productC1.png",
      children: <Widget>[
        Expanded(child: BlocBuilder<StoreBloc, StoreState>(builder: (_, state) {
          if (state is StoreFetchFailed) {
            return Center(child: Text('No Result to display'));
          }
          if (state is StoreFetchedById) {
            final productItems = state.store.productItems;
            print("Value of store: ${productItems.length}");
            if (productItems.length == 0) {
              return EmptyResultWBtn(
                title: "Opps! No Products Yet",
                description:
                    "There are no Product items in this store right now.",
              );
            }
            return ListView.builder(
                itemCount: productItems.length,
                itemBuilder: (_, int index) {
                  final productItem = productItems[index];
                  return Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: StoreItemCard(
                        productName: productItem.product.name,
                        quantity: productItem.quantity.toString(),
                        category: "Product",
                        price: productItem.pricerPerKg.toStringAsFixed(2)),
                  );
                });
          }
          return Center(
            child: SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                color: Colors.black26,
              ),
            ),
          );
        })),
      ],
    );
  }
}

class StoreItemCard extends StatelessWidget {
  final String productName;
  final String price;
  final String quantity;
  final String? category;
  StoreItemCard(
      {Key? key,
      required this.productName,
      required this.price,
      required this.quantity,
      this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 8,
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$productName",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: "RobotMono"),
                ),
                Text(
                  "${category ?? ''}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontFamily: "RobotMono"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Quantity:",
                        style: TextStyle(fontSize: 16, fontFamily: "RobotMono"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "$quantity kg",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Price:",
                      style: TextStyle(fontSize: 16, fontFamily: "RobotMono"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "$price birr",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
