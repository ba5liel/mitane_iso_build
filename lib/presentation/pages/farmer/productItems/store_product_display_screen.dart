import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitane_frontend/application/store/bloc/store_bloc.dart';
import 'package:mitane_frontend/application/store/events/store_events.dart';
import 'package:mitane_frontend/application/store/states/store_state.dart';
import 'package:mitane_frontend/domain/product/entity/product_model.dart';
import 'package:mitane_frontend/domain/store/entity/store_model.dart';
import 'package:mitane_frontend/presentation/pages/common/mainlayoutlist.dart';
import 'package:mitane_frontend/presentation/pages/custom_widgets/widgets/emptyresult.dart';
import 'package:mitane_frontend/presentation/pages/custom_widgets/widgets/storeiteam.dart';
import 'package:mitane_frontend/presentation/pages/farmer/productItems/store_add_product_screen.dart';
import 'package:mitane_frontend/presentation/pages/farmer/productItems/store_product_edit_screen.dart';
import 'package:mitane_frontend/route_generator.dart';

class StoreProductDisplay extends StatefulWidget {
  static const String routeName = '/store/products';

  get curPrice => null;

  static ProductItem editArgument =
      ProductItem("", Product(category: "", name: "", id: ""), 0, 0.0);

  @override
  _StoreProductDisplayState createState() => _StoreProductDisplayState();
}

class _StoreProductDisplayState extends State<StoreProductDisplay> {
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
        title: "Store Products",
        image: "assets/productC1.png",
        create: () => Navigator.of(context).pushNamed(
              StoreProductAdd.routeName,
            ),
        children: <Widget>[
          BlocListener<StoreBloc, StoreState>(
            listener: (context, state) {
              if (state is StoreItemAddFailed) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        Text("Error: occured while trying to add product")));
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
          Expanded(
              child: BlocBuilder<StoreBloc, StoreState>(builder: (_, state) {
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
              final productItems = state.stores.productItems;
              print("Value of store: ${productItems.length}");
              if (productItems.length == 0) {
                return EmptyResult(
                  title: "Opps! No Products Yet",
                  description:
                      "You don't have a product iteam in your store right now. you can create a product below!",
                  btntxt: 'Create Product',
                  onTap: () => Navigator.of(context).pushNamed(
                    StoreProductAdd.routeName,
                  ),
                );
              }
              return ListView.builder(
                  itemCount: productItems.length,
                  itemBuilder: (_, int index) {
                    final productItem = productItems[index];
                    return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Dismissible(
                          child: StoreItemCard(
                              productName: productItem.product.name,
                              quantity: productItem.quantity.toString(),
                              category: productItem.product.category,
                              price:
                                  productItem.pricerPerKg.toStringAsFixed(2)),
                          background: slideRightBackground(),
                          secondaryBackground: slideLeftBackground(),
                          key: ValueKey<Product>(productItem.product),
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.endToStart) {
                              final bool res = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Text(
                                          "Are you sure you want to delete ${productItem.product.name}?"),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text(
                                            "Cancel",
                                            style:
                                                TextStyle(color: Colors.black),
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
                                              BlocProvider.of<StoreBloc>(
                                                      context)
                                                  .add(DeleteStoreItem(
                                                      'product',
                                                      productItem.id!));
                                            });
                                          },
                                        ),
                                      ],
                                    );
                                  });
                              return res;
                            } else if (direction ==
                                DismissDirection.startToEnd) {
                              StoreProductDisplay.editArgument =
                                  productItems.elementAt(index);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => StoreProductEdit(
                                      argument: ProductItemArgument(
                                          storeId: state.stores.id,
                                          productItem:
                                              productItems.elementAt(index)))));
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
          }))
        ]);
  }
}
