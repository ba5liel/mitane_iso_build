import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mitane_frontend/application/product/bloc/product_blocs.dart';
import 'package:mitane_frontend/domain/product/entity/product_model.dart';
import 'package:mitane_frontend/presentation/pages/admin/screens/Admin_Home.dart';
import 'package:mitane_frontend/presentation/pages/agri_product/product.dart';

class AdminProductAdd extends StatefulWidget {
  static const String routeName = '/admin/products/add';

  @override
  _AdminProductAddState createState() => _AdminProductAddState();
}

class _AdminProductAddState extends State<AdminProductAdd> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _product = {};

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    List<String> categoryLists = [];
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
                      onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminHome()))
                          },
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
                  Text('Add Product',
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
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                  Text('Product Name',
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
                                          labelText: "Product Name",
                                          border: OutlineInputBorder(),
                                        ),
                                        validator: (value) {
                                          if (value != null && value.isEmpty) {
                                            return 'Please enter product name';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          setState(() {
                                            this._product["name"] = value;
                                          });
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 40.0,
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
                                          Text("Product Category"),
                                          BlocBuilder<ProductBloc,
                                                  ProductState>(
                                              builder: (_, state) {
                                            if (state
                                                is ProductAdminOperationFailure) {
                                              return Text(
                                                  'Error: Displaying categories list');
                                            }

                                            if (state
                                                is ProductAdminOperationSuccess) {
                                              final categories =
                                                  state.categories;

                                              String defaultValue =
                                                  categories[0].name;
                                              for (var i = 0;
                                                  i < categories.length;
                                                  i++) {
                                                categoryLists.add(categories
                                                    .elementAt(i)
                                                    .name
                                                    .toString());
                                              }
                                              return DropdownButton(
                                                value: selectedValue ??
                                                    defaultValue,
                                                underline: Container(),
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down),
                                                items: categoryLists
                                                    .map((String items) {
                                                  return DropdownMenuItem(
                                                      value: items.toString(),
                                                      child: Text(
                                                          items.toString()));
                                                }).toList(),
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    selectedValue = newValue!;
                                                    this._product["category"] =
                                                        newValue;
                                                  });
                                                },
                                              );
                                            }
                                            return Text('Loading');
                                          }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Add Product",
                                    style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff2e2e2e))),
                                InkWell(
                                    onTap: () {
                                      final form = _formKey.currentState;
                                      if (form != null && form.validate()) {
                                        form.save();
                                        final ProductEvent event =
                                            ProductAdminCreate(
                                          Product(
                                            id: null,
                                            name: this._product['name'],
                                            category:
                                                this._product["category"] ??
                                                    "fruits",
                                          ),
                                        );
                                        BlocProvider.of<ProductBloc>(context)
                                            .add(event);
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                AdminProducts.routeName,
                                                (route) => false);
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
                        )),
                  ],
                ),
              )
            ]))));
  }
}
