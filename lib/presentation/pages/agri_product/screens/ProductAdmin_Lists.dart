import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mitane_frontend/application/product/bloc/product_blocs.dart';
import 'package:mitane_frontend/domain/product/entity/product_model.dart';
import 'package:mitane_frontend/presentation/pages/admin/screens/Admin_Home.dart';
import 'package:mitane_frontend/presentation/pages/agri_product/product.dart';
import 'package:mitane_frontend/presentation/pages/common/SlideEditAndDelete.dart';
import 'package:mitane_frontend/presentation/pages/common/mainlayoutlist.dart';
import 'package:mitane_frontend/route_generator.dart';

class AdminProducts extends StatefulWidget {
  static const routeName = '/admin/products';

  static Product editArg = Product(id: "", name: "", category: "");

  @override
  _AdminProductsState createState() => _AdminProductsState();
}

class _AdminProductsState extends State<AdminProducts> {
  @override
  Widget build(BuildContext context) {
    return MainLayOutListing(
      title: "Products",
      image: "assets/productC1.png",
      back: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AdminHome()));
      },
      children: [
        SizedBox(
          height: 15,
        ),
        Expanded(
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (_, state) {
              if (state is ProductAdminOperationFailure) {
                return Text('Error: Displaying products list');
              }

              if (state is ProductAdminOperationSuccess) {
                final products = state.products;

                return ListView.builder(
                    itemCount: products.length.toInt(),
                    itemBuilder: (_, int index) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Dismissible(
                          child: ProductCard(
                            productName: products.elementAt(index).name,
                            category: products.elementAt(index).category,
                          ),
                          background: slideRightBackground(),
                          secondaryBackground: slideLeftBackground(),
                          key: ValueKey<Product>(products.elementAt(index)),
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.endToStart) {
                              final bool res = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Text(
                                          "Are you sure you want to delete ${products.elementAt(index).name}?"),
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
                                            setState(() {
                                              BlocProvider.of<ProductBloc>(
                                                      context)
                                                  .add(ProductAdminDelete(
                                                      products
                                                          .elementAt(index)
                                                          .name
                                                          .toString()));
                                              Navigator.of(context)
                                                  .pushNamedAndRemoveUntil(
                                                      AdminProducts.routeName,
                                                      (route) => false);
                                            });
                                          },
                                        ),
                                      ],
                                    );
                                  });
                              return res;
                            } else if (direction ==
                                DismissDirection.startToEnd) {
                              AdminProducts.editArg = products.elementAt(index);
                              Navigator.of(context).pushNamed(
                                AdminProductEdit.routeName,
                                arguments: ProductArgument(
                                    product: products.elementAt(index)),
                              );
                            }
                          },
                        ),
                      );
                    });
              }

              return Center(
                  child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  color: Colors.black26,
                ),
              ));
            },
          ),
        )
      ],
      create: () => Navigator.of(context).pushNamed(
        AdminProductAdd.routeName,
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String productName;
  final String category;
  const ProductCard(
      {Key? key, required this.productName, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            FaIcon(
              FontAwesomeIcons.spa,
              color: Color(0xDD8CC63E),
              size: 50,
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Text(
                        "Category:",
                        style: TextStyle(fontSize: 16, fontFamily: "RobotMono"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "$category",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ]),
                  ],
                )
              ],
            ),
          ]),
        ));
  }
}
