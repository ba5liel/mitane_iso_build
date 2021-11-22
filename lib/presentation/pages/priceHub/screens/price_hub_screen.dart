import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mitane_frontend/application/price/bloc/price_bloc.dart';
import 'package:mitane_frontend/application/price/states/price_state.dart';
import 'package:mitane_frontend/presentation/pages/common/mainlayoutlistwithourfb.dart';
import 'package:mitane_frontend/presentation/pages/custom_widgets/widgets/emptyresultwobtn.dart';

class PriceHub extends StatefulWidget {
  @override
  _PriceHubState createState() => _PriceHubState();
}

class _PriceHubState extends State<PriceHub> {
  String? selectedCategory = "";

  String? get() => selectedCategory;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayOutListingWoFB(
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
            }
            if (state is PriceFetched) {
              return ListView.builder(
                  itemCount: state.priceDaily.length,
                  itemBuilder: (BuildContext context, int index) {
                    final price = state.priceDaily[index];

                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      child: PriceCard(
                          product: price.product['name'],
                          unit: "Kg",
                          todayPrice:
                              price.price[0]['price'].toStringAsFixed(2)),
                    );
                  });
            }
            return EmptyResultWBtn(
              title: "Opps! No Prices encoded Yet",
              description: "There are no Prices encoded right now.",
            );
          }),
        ]);
  }
}

class PriceCard extends StatelessWidget {
  final String product;
  final String todayPrice;
  final String unit;
  const PriceCard({
    Key? key,
    required this.product,
    required this.unit,
    required this.todayPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 50),
        decoration: BoxDecoration(
            border: Border(left: BorderSide(color: Colors.blue, width: 5))),
        height: 80,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$product",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: "RobotMono"),
                ),
                Text(
                  "Unit - $unit",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
                        "$todayPrice birr",
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
