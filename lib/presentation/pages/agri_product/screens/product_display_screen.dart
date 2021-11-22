import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitane_frontend/application/product/bloc/product_bloc.dart';
import 'package:mitane_frontend/application/product/states/product_state.dart';
import 'package:mitane_frontend/domain/product/entity/product_model.dart';
import 'package:mitane_frontend/presentation/pages/agri_product/product.dart';
import 'package:mitane_frontend/presentation/pages/common/mainlayoutlistwithourfb.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    //final arguments = ModalRoute.of(context)!.settings.arguments as String;
    return MainLayOutListingWoFB(
      image: "assets/productC1.png",
      title: "Products",
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
                        child: ProductCard(
                          productName: products.elementAt(index).name,
                          category: products.elementAt(index).category,
                        ),
                        key: ValueKey<Product>(products.elementAt(index)),
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
        ),
      ],
    );
  }
}
