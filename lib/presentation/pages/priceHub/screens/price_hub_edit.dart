import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mitane_frontend/application/price/bloc/price_bloc.dart';
import 'package:mitane_frontend/application/price/events/price_event.dart';
import 'package:mitane_frontend/application/price/states/price_state.dart';

class PriceHubEdit extends StatefulWidget {
  static const String routeName = '/editPrice';

  @override
  _PriceHubEditState createState() => _PriceHubEditState();
}

class _PriceHubEditState extends State<PriceHubEdit> {
  String selectedItem = "";
  TextEditingController priceController = TextEditingController();
  List<String> item = [];

  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PriceBloc()..add(ProductPriceFetch()),
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () => {Navigator.pop(context)},
                            icon: Icon(
                              FontAwesomeIcons.arrowLeft,
                              size: 20,
                              color: Color(0xff222222),
                            )),
                        SizedBox(
                          width: 50,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                            width: 150,
                            height: 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/METANE.png"),
                                    fit: BoxFit.contain))),
                        SizedBox(height: 15),
                        Text('Edit Price For Item',
                            style: TextStyle(
                                fontSize: 28.0,
                                color: Color(0xff04471a),
                                fontWeight: FontWeight.w800)),
                      ],
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Select Product Category',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff919191))),
                                  SizedBox(height: 8),
                                  Material(
                                    elevation: 2,
                                    borderRadius: BorderRadius.circular(5),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 40.0),
                                              child: BlocBuilder<PriceBloc,
                                                  PriceState>(
                                                builder: (context, state) {
                                                  String defaultItem = '';
                                                  if (state
                                                      is ProductPriceFetched) {
                                                    final result =
                                                        state.products;
                                                    defaultItem = result[0];
                                                    item = result;
                                                  }
                                                  return DropdownButton(
                                                    value: selectedItem == ''
                                                        ? defaultItem
                                                        : selectedItem,
                                                    menuMaxHeight: 5 * 60,
                                                    dropdownColor: Colors.white,
                                                    underline: Container(
                                                        color:
                                                            Colors.transparent),
                                                    items: item.map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(
                                                          value,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 20),
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (String? value) {
                                                      setState(() => value !=
                                                              null
                                                          ? selectedItem = value
                                                          : "");
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Today\'s Price per Kg',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff919191))),
                                SizedBox(height: 8),
                                Material(
                                  elevation: 2,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  child: TextFormField(
                                    controller: priceController,
                                    textAlign: TextAlign.right,
                                    decoration: InputDecoration(
                                      labelText: "Today's Price per Kg",
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                            SizedBox(
                              height: 40.0,
                            ),
                            BlocBuilder<PriceBloc, PriceState>(
                                builder: (context, state) {
                              print(state);
                              if (state is OperationSuccessful) {
                                print("Successful");
                              }
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Edit Price",
                                      style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff2e2e2e))),
                                  InkWell(
                                      onTap: () {
                                        context.read<PriceBloc>().add(
                                            UpdatePrice(selectedItem,
                                                priceController.text));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 20),
                                        decoration: BoxDecoration(
                                          color: Color(0xff0a6430),
                                          borderRadius:
                                              BorderRadius.circular(28),
                                        ),
                                        child: Icon(
                                          FontAwesomeIcons.arrowRight,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      )),
                                ],
                              );
                            })
                          ],
                        ))
                  ],
                ),
              ),
            )));
  }
}
