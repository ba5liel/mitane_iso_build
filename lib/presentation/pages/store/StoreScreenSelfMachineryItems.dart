import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitane_frontend/application/store/bloc/store_blocs.dart';
import 'package:mitane_frontend/domain/store/entity/store_model.dart';
import 'package:mitane_frontend/presentation/pages/common/mainlayoutlistwithourfb.dart';
import 'package:mitane_frontend/presentation/pages/custom_widgets/widgets/emptyresult.dart';
import 'package:mitane_frontend/presentation/pages/custom_widgets/widgets/emptyresultwobtn.dart';
import 'package:mitane_frontend/presentation/pages/store/store_screen_self.dart';

class StoreMachineryDisplaySelf extends StatefulWidget {
  static const String routeName = '/stores/store/machineryItems';

  @override
  _StoreMachineryDisplaySelfState createState() =>
      _StoreMachineryDisplaySelfState();
}

class _StoreMachineryDisplaySelfState extends State<StoreMachineryDisplaySelf> {
  @override
  Widget build(BuildContext context) {
    //final arguments = ModalRoute.of(context)!.settings.arguments as List;
    return MainLayOutListingWoFB(
      image: "assets/tractor.png",
      title: "Store Machineries",
      children: [
        SizedBox(
          height: 10,
        ),
        Expanded(child: BlocBuilder<StoreBloc, StoreState>(builder: (_, state) {
          if (state is StoreFetchFailed) {
            return Center(child: Text('No Result to display'));
          }
          if (state is StoreFetchedById) {
            final machineryItems = state.store.machineryItems;
            print("Value of store: ${machineryItems.length}");
            if (machineryItems.length == 0) {
              return EmptyResultWBtn(
                title: "Opps! No Machineries Yet",
                description:
                    "There are no Machinery items in this store right now.",
              );
            }
            return ListView.builder(
                itemCount: machineryItems.length,
                itemBuilder: (_, int index) {
                  final machineryItem = machineryItems[index];
                  return Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: StoreItemCard(
                        machineryName: machineryItem.machinery.name,
                        quantity: machineryItem.quantity.toString(),
                        category: "Machinery",
                        price: machineryItem.pricerPerPiece.toStringAsFixed(2)),
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
  final String machineryName;
  final String price;
  final String quantity;
  final String? category;
  StoreItemCard(
      {Key? key,
      required this.machineryName,
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
                  "$machineryName",
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
