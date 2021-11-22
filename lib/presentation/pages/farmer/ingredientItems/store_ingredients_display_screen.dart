import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:mitane_frontend/application/store/bloc/store_bloc.dart';
import 'package:mitane_frontend/application/store/events/store_events.dart';
import 'package:mitane_frontend/application/store/states/store_state.dart';
import 'package:mitane_frontend/domain/ingredient/entity/ingredient_model.dart';
import 'package:mitane_frontend/presentation/pages/common/mainlayoutlist.dart';
import 'package:mitane_frontend/presentation/pages/custom_widgets/widgets/emptyresult.dart';
import 'package:mitane_frontend/presentation/pages/custom_widgets/widgets/storeiteam.dart';
import 'package:mitane_frontend/presentation/pages/farmer/ingredientItems/store_add_ingredients_screen.dart';
import 'package:mitane_frontend/presentation/pages/farmer/ingredientItems/store_ingredients_edit_screen.dart';

class StoreIngredientDisplay extends StatefulWidget {
  static const String routeName = '/store/ingredients';

  @override
  _StoreIngredientDisplayState createState() => _StoreIngredientDisplayState();
}

class _StoreIngredientDisplayState extends State<StoreIngredientDisplay> {
  @override
  void initState() {
    super.initState();
    context.read<StoreBloc>().add(FetchStore());
  }

  final ZoomDrawerController zoomDrawerController = new ZoomDrawerController();
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
      title: "Store Ingredinets",
      children: [
        SizedBox(
          height: 10,
        ),
        BlocListener<StoreBloc, StoreState>(
          listener: (context, state) {
            if (state is StoreItemAddFailed) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Error: occured while trying to add product")));
            }
            if (state is StoreItemDelete) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/farmer", (route) => false);
            }
            if (state is StoreCreated) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/farmer", (route) => false);
            }
          },
          child: Container(),
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
                    "You don't have a Ingredients iteam in your store right now. you can create a Ingredients below!",
                btntxt: 'Create Ingredient',
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => StoreIngredientAdd())),
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
                                builder: (context) => StoreIngredientEdit(
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
      create: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => StoreIngredientAdd())),
    );
  }
}
