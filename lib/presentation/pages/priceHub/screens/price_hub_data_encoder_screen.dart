import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mitane_frontend/application/price/bloc/price_bloc.dart';
import 'package:mitane_frontend/application/price/events/price_event.dart';
import 'package:mitane_frontend/application/price/states/price_state.dart';
import 'package:mitane_frontend/presentation/pages/common/mainlayoutlist.dart';
import 'package:mitane_frontend/presentation/pages/custom_widgets/widgets/emptyresultwobtn.dart';
import 'package:mitane_frontend/presentation/pages/priceHub/screens/price_hub_add_screen.dart';
import 'package:mitane_frontend/presentation/pages/priceHub/screens/price_hub_edit.dart';

class PriceHubDisplay extends StatefulWidget {
  static const String routeName = '/priceHubDE';

  PriceHubDisplay();

  get curPrice => null;

  @override
  _PriceHubState createState() => _PriceHubState();
}

class _PriceHubState extends State<PriceHubDisplay> {
  @override
  void initState() {
    super.initState();
  }

  Widget slideRightBackground() {
    return Container(
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 40,
            ),
            Icon(
              Icons.align_horizontal_right_rounded,
              color: Colors.green,
              size: 30,
            ),
            Icon(
              Icons.edit,
              color: Colors.green,
              size: 30,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.red,
              size: 30,
            ),
            Icon(
              Icons.align_horizontal_left_rounded,
              color: Colors.red,
              size: 30,
            ),
            SizedBox(
              width: 40,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PriceBloc()..add(PriceFetch()),
      child: MainLayOutListing(
        image: "assets/priceC.png",
        title: "Price Hub",
        children: [
          BlocBuilder<PriceBloc, PriceState>(builder: (context, state) {
            print(state);
            if (state is PriceFetching) {
              return Center(
                  child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ));
            } else if (state is PriceFetched) {
              var priceData = state.priceDaily;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: priceData.length,
                        itemBuilder: (BuildContext context, int index) {
                          var curPrice = priceData[index];
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            child: BlocBuilder<PriceBloc, PriceState>(
                              builder: (context, state) {
                                if (state is OperationSuccessful) {
                                  print("deleted");
                                }
                                return Dismissible(
                                  child: PriceItemCard(
                                    productName: curPrice.product['name'],
                                    unit: "",
                                    todayPrice: curPrice.price[0]['price'],
                                  ),
                                  background: slideRightBackground(),
                                  secondaryBackground: slideLeftBackground(),
                                  key: ValueKey<dynamic>(priceData[index]),
                                  confirmDismiss: (direction) async {
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      final bool res = await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: Text(
                                                  "Are you sure you want to delete ${curPrice.product['name']}?"),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context, false);
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text(
                                                    "Delete",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  onPressed: () {
                                                    context
                                                        .read<PriceBloc>()
                                                        .add(DeletePrice(
                                                            curPrice.product[
                                                                'name'],
                                                            curPrice.price[0]
                                                                ['price']));
                                                    setState(() {
                                                      priceData.removeAt(index);
                                                    });
                                                    Navigator.pop(
                                                        context, true);
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                      return res;
                                    } else if (direction ==
                                        DismissDirection.startToEnd) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PriceHubEdit()),
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                          );
                        }),
                  ),
                ],
              );
            }
            return EmptyResultWBtn(
              title: "Opps! No Prices encoded Yet",
              description: "There are no Prices encoded right now.",
            );
          }),
        ],
        create: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PriceHubAdd()),
          );
        },
      ),
    );
  }
}

class PriceItemCard extends StatelessWidget {
  final String productName;
  final int todayPrice;
  final String unit;
  const PriceItemCard(
      {Key? key,
      required this.productName,
      required this.todayPrice,
      required this.unit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
            border: Border(
                left: BorderSide(
                    color: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)],
                    width: 5))),
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
                  "Unit: $unit kg",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: "RobotMono"),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.projectDiagram,
                      size: 16,
                      color: Colors.green,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "$todayPrice Birr",
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
