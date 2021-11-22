import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mitane_frontend/application/store/bloc/store_blocs.dart';
import 'package:mitane_frontend/domain/ingredient/entity/ingredient_model.dart';
import 'package:mitane_frontend/domain/store/entity/store_model.dart';

class TraderStoreIngredientAdd extends StatefulWidget {
  static const String routeName = 'trader/store/ingredients/add';
  @override
  _TraderStoreIngredientAddState createState() =>
      _TraderStoreIngredientAddState();
}

class _TraderStoreIngredientAddState extends State<TraderStoreIngredientAdd> {
  final _formKey = GlobalKey<FormState>();

  final quantityTextController = new TextEditingController();
  final priceTextController = new TextEditingController();

  String name = "";

  Ingredient? selectedValue;

  @override
  Widget build(BuildContext context) {
    List<String> productsLists = [];
    var productChecker = {};
    return Scaffold(
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
                Text('Add new Machinery',
                    style: TextStyle(
                        fontSize: 28.0,
                        color: Color(0xff04471a),
                        fontWeight: FontWeight.w800)),
              ],
            ),
            SizedBox(height: 5),
            Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocListener<StoreBloc, StoreState>(
                        listener: (context, state) {
                          if (state is StoreItemAddFailed) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Error: occured while trying to add product")));
                          }
                          if (state is StoreItemAdded) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                "/trader", (route) => false);
                          }
                        },
                        child: Container(),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Quantity',
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
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Quantity",
                                  border: OutlineInputBorder(),
                                ),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                validator: (value) {
                                  if (value != null && value.isEmpty) {
                                    return 'Please enter product quantity';
                                  }
                                  return null;
                                },
                                controller: quantityTextController,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Price per unit',
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
                                textAlign: TextAlign.right,
                                decoration: InputDecoration(
                                  labelText: "Price per unit",
                                  border: OutlineInputBorder(),
                                ),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                validator: (value) {
                                  if (value != null && value.isEmpty) {
                                    return 'Please enter the price per unit';
                                  }
                                  return null;
                                },
                                controller: priceTextController,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
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
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(""),
                                      BlocBuilder<StoreBloc, StoreState>(
                                          builder: (_, state) {
                                        if (state is StoreFetchFailed) {
                                          return Text(
                                              'Error: Displaying products list');
                                        }

                                        if (state is StoreFetched) {
                                          final products = state.ingredients;
                                          // print( products);
                                          Ingredient defaultValue = products[0];
                                          for (var i = 0;
                                              i < products.length;
                                              i++) {
                                            productsLists.add(products
                                                .elementAt(i)
                                                .name
                                                .toString());
                                            productChecker[products
                                                .elementAt(i)
                                                .name
                                                .toString()] = products[i];
                                          }
                                          // print(productsLists);
                                          return DropdownButton<Ingredient>(
                                            value:
                                                selectedValue ?? defaultValue,
                                            icon:
                                                Icon(Icons.keyboard_arrow_down),
                                            underline: Container(),
                                            items: products
                                                .map((Ingredient items) {
                                              return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(items.name));
                                            }).toList(),
                                            onChanged: (Ingredient? newValue) {
                                              setState(() {
                                                selectedValue = newValue!;
                                              });
                                            },
                                          );
                                        }
                                        return Text('Loading');
                                      })
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Add Machinery",
                              style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff2e2e2e))),
                          InkWell(
                              onTap: () {
                                final form = _formKey.currentState;
                                if (form != null && form.validate()) {
                                  form.save();
                                  // print(_productItem.product);
                                  // print(_productItem.quantity);
                                  // print(_productItem.pricerPerKg);
                                  // String product = '61371baf4a75b5adb510be4b';
                                  // int quantity = 600;
                                  // double price = 80.0;
                                  if (selectedValue == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Please select a product")));
                                    return;
                                  }
                                  print("selectedValue $selectedValue");
                                  IngridentItem item = IngridentItem(
                                      null,
                                      selectedValue!,
                                      int.parse(quantityTextController.text),
                                      double.parse(priceTextController.text));
                                  print(
                                      "priceTextController ${item.pricerPerKg}");

                                  final StoreEvent event =
                                      IngredientItemCreate(item);
                                  BlocProvider.of<StoreBloc>(context)
                                      .add(event);
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 20),
                                decoration: BoxDecoration(
                                  color: Color(0xff0a6430),
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                child: Icon(
                                  FontAwesomeIcons.arrowRight,
                                  size: 15,
                                  color: Colors.white,
                                ),
                              )),
                        ],
                      )
                    ],
                  ),
                )),
          ],
        ))));
  }
}
