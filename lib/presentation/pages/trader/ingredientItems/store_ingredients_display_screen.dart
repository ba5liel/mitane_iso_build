import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitane_frontend/application/store/bloc/store_blocs.dart';
import 'package:mitane_frontend/domain/ingredient/entity/ingredient_model.dart';
import 'package:mitane_frontend/presentation/pages/common/mainlayoutlist.dart';
import 'package:mitane_frontend/presentation/pages/custom_widgets/widgets/emptyresult.dart';
import 'package:mitane_frontend/presentation/pages/trader/ingredientItems/store_add_ingredients_screen.dart';
import 'package:mitane_frontend/presentation/pages/trader/ingredientItems/store_ingredients_edit_screen.dart';

class TraderStoreIngredientDisplay extends StatefulWidget {
  static const String routeName = 'trader/store/ingredients';

  @override
  _TraderStoreIngredientDisplayState createState() =>
      _TraderStoreIngredientDisplayState();
}

class _TraderStoreIngredientDisplayState
    extends State<TraderStoreIngredientDisplay> {
  @override
  void initState() {
    super.initState();
    context.read<StoreBloc>().add(FetchStore());
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
    return MainLayOutListing(
      image: "assets/fertlizerC.png",
      title: "Ingredients",
      children: [
        BlocListener<StoreBloc, StoreState>(
          listener: (context, state) {
            if (state is StoreItemAddFailed) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Error: occured while trying to add product")));
            }
            if (state is StoreItemDelete) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/trader", (route) => false);
            }
            if (state is StoreCreated) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/trader", (route) => false);
            }
          },
          child: Container(),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
              color: Color(0xFF8CC63E),
              borderRadius: BorderRadius.circular(20)),
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 2, right: 2),
          margin: EdgeInsets.only(top: 10, bottom: 0, left: 10, right: 10),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Decide your share of the market!",
                style: TextStyle(
                    fontSize: 20, fontFamily: "RobotMono", color: Colors.white),
              ),
              Text(
                "Date will be displayed here",
                style: TextStyle(
                    fontSize: 10, fontFamily: "RobotMono", color: Colors.white),
              ),
            ],
          ),
        ),
        Expanded(child: BlocBuilder<StoreBloc, StoreState>(builder: (_, state) {
          if (state is StoreFetchFailed) {
            return Center(child: Text('No Result to display'));
          }
          if (state is NoStoreFound) {
            return EmptyResult(
              title: "Opps! No Store Yet",
              description:
                  "You don't have a Store right now. you can create a Store below!",
              btntxt: 'Create Store',
              onTap: () => context.read<StoreBloc>().add(CreateStoreFirst()),
            );
          }
          if (state is StoreFetched) {
            final productItems = state.stores.ingredientItems;
            print("Value of store: ${productItems.length}");
            if (productItems.length == 0) {
              return EmptyResult(
                title: "Opps! No Ingredients Yet",
                description:
                    "You don't have a Ingredients item in your store right now. you can create a Ingredients below!",
                btntxt: 'Create Ingredient',
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TraderStoreIngredientAdd())),
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
                    child: Dismissible(
                        child: StoreItemCard(
                            productName: productItem.ingredients.name,
                            quantity: productItem.quantity.toString(),
                            category: "Ingredient",
                            price: productItem.pricerPerKg.toStringAsFixed(2)),
                        background: slideRightBackground(),
                        secondaryBackground: slideLeftBackground(),
                        key: ValueKey<Ingredient>(productItem.ingredients),
                        confirmDismiss: (direction) async {
                          if (direction == DismissDirection.endToStart) {
                            final bool res = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Text(
                                        "Are you sure you want to delete ${productItem.ingredients.name}?"),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context, false);
                                        },
                                      ),
                                      TextButton(
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          setState(() {
                                            BlocProvider.of<StoreBloc>(context)
                                                .add(DeleteStoreItem(
                                                    'ingredient',
                                                    productItem.id!));
                                          });
                                        },
                                      ),
                                    ],
                                  );
                                });
                            return res;
                          } else if (direction == DismissDirection.startToEnd) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TraderStoreIngredientEdit(
                                    storeId: state.stores.id,
                                    ingredientItem:
                                        productItems.elementAt(index))));
                          }
                        }),
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
      create: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => TraderStoreIngredientAdd())),
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
