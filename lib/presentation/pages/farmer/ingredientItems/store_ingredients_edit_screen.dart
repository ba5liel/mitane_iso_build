import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mitane_frontend/application/store/bloc/store_bloc.dart';
import 'package:mitane_frontend/application/store/events/store_events.dart';
import 'package:mitane_frontend/application/store/states/store_state.dart';
import 'package:mitane_frontend/domain/ingredient/entity/ingredient_model.dart';
import 'package:mitane_frontend/domain/store/entity/store_model.dart';

class StoreIngredientEdit extends StatefulWidget {
  final IngridentItem ingredientItem;
  final String storeId;
  StoreIngredientEdit({required this.ingredientItem, required this.storeId});

  @override
  _StoreIngredientEditState createState() => _StoreIngredientEditState();
}

class _StoreIngredientEditState extends State<StoreIngredientEdit> {
  final _formKey = GlobalKey<FormState>();

  late Ingredient selectedValue;

  @override
  void initState() {
    selectedValue = widget.ingredientItem.ingredients;
    super.initState();
  }

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
                Text('Edit Ingredient',
                    style: TextStyle(
                        fontSize: 28.0,
                        color: Color(0xff04471a),
                        fontWeight: FontWeight.w800)),
              ],
            ),
            SizedBox(height: 5),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocListener<StoreBloc, StoreState>(
                    listener: (context, state) {
                      if (state is StoreItemUpdatedFailed) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "Error: occured while trying to add product")));
                      }
                      if (state is StoreItemUpdated) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "/farmer", (route) => false);
                      }
                    },
                    child: Container(),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                      margin: EdgeInsets.all(40),
                      child: Column(
                        children: [
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
                                              final products =
                                                  state.ingredients;
                                              print(products);

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
                                                value: products.singleWhere(
                                                    (element) =>
                                                        element.id ==
                                                        selectedValue.id),
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down),
                                                items: products
                                                    .map((Ingredient items) {
                                                  return DropdownMenuItem(
                                                      value: items,
                                                      child: Text(items.name));
                                                }).toList(),
                                                onChanged:
                                                    (Ingredient? newValue) {
                                                  setState(() {
                                                    selectedValue = newValue!;
                                                  });
                                                },
                                              );
                                            }
                                            return Text('Loading');
                                          })
                                        ],
                                      ),
                                    ),
                                  )
                                ]),
                          ),
                          SizedBox(
                            height: 40.0,
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
                                        initialValue: widget
                                            .ingredientItem.quantity
                                            .toString(),
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
                                        onSaved: (value) {
                                          setState(() {
                                            widget.ingredientItem.quantity =
                                                int.parse(value!);
                                          });
                                        }),
                                  )
                                ]),
                          ),
                          SizedBox(
                            height: 40.0,
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
                                        initialValue: widget
                                            .ingredientItem.pricerPerKg
                                            .toString(),
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
                                        onSaved: (value) {
                                          setState(() {
                                            widget.ingredientItem.pricerPerKg =
                                                double.parse(value!);
                                          });
                                        }),
                                  )
                                ]),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Edit Ingredient",
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

                                      final StoreEvent event = UpdateStoreItem(
                                          productId: widget.ingredientItem.id!,
                                          storeItem: selectedValue.id!,
                                          type: "ingredient",
                                          quantity:
                                              widget.ingredientItem.quantity,
                                          price:
                                              widget.ingredientItem.pricerPerKg,
                                          store: widget.storeId);
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
                      ))
                ],
              ),
            ),
          ],
        ))));
  }
}
