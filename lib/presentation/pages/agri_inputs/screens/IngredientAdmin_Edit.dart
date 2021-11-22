import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mitane_frontend/application/ingredient/bloc/ingredient_blocs.dart';
import 'package:mitane_frontend/domain/ingredient/entity/ingredient_model.dart';
import 'package:mitane_frontend/presentation/pages/admin/screens/Admin_Home.dart';
import 'package:mitane_frontend/presentation/pages/agri_inputs/inputs.dart';
import 'package:mitane_frontend/route_generator.dart';

class AdminIngredientEdit extends StatefulWidget {
  static const String routeName = '/admin/ingredients/edit';

  final IngredientArgument argument;
  AdminIngredientEdit({required this.argument});

  @override
  _AdminIngredientEditState createState() => _AdminIngredientEditState();
}

class _AdminIngredientEditState extends State<AdminIngredientEdit> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _ingredient = {};
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
                  Text('Add new Ingredient',
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
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          children: [
                            Container(
                                margin: EdgeInsets.all(40),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Ingredient Name',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xff919191))),
                                          SizedBox(height: 8),
                                          Material(
                                            elevation: 2,
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: TextFormField(
                                                initialValue: widget
                                                    .argument.ingredient.name,
                                                textAlign: TextAlign.right,
                                                decoration: InputDecoration(
                                                  labelText: "Ingredient Name",
                                                  border: OutlineInputBorder(),
                                                ),
                                                validator: (value) {
                                                  if (value != null &&
                                                      value.isEmpty) {
                                                    return 'Please enter ingredient name';
                                                  }
                                                  return null;
                                                },
                                                onSaved: (value) {
                                                  setState(() {
                                                    _ingredient["name"] = value;
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Select Product Category',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xff919191))),
                                          SizedBox(height: 8),
                                          Material(
                                            elevation: 2,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 5),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text("Ingredient Category"),
                                                  BlocBuilder<IngredientBloc,
                                                          IngredientState>(
                                                      builder: (_, state) {
                                                    if (state
                                                        is IngredientAdminOperationFailure) {
                                                      return Text(
                                                          'Error: Displaying categories list');
                                                    }

                                                    if (state
                                                        is IngredientAdminOperationSuccess) {
                                                      final categories =
                                                          state.categories;
                                                      String defaultValue =
                                                          categories[0].name;

                                                      for (var i = 0;
                                                          i < categories.length;
                                                          i++) {
                                                        categoryLists.add(
                                                            categories
                                                                .elementAt(i)
                                                                .name
                                                                .toString());
                                                      }
                                                      return DropdownButton(
                                                        value: selectedValue ??
                                                            defaultValue,
                                                        icon: Icon(Icons
                                                            .keyboard_arrow_down),
                                                        items: categoryLists
                                                            .map(
                                                                (String items) {
                                                          return DropdownMenuItem(
                                                              value: items
                                                                  .toString(),
                                                              child: Text(items
                                                                  .toString()));
                                                        }).toList(),
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            selectedValue =
                                                                newValue!;
                                                            _ingredient[
                                                                    "category"] =
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Edit Ingredient",
                                            style: TextStyle(
                                                fontSize: 26,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff2e2e2e))),
                                        InkWell(
                                            onTap: () {
                                              print(widget
                                                  .argument.ingredient.name);
                                              final form =
                                                  _formKey.currentState;
                                              if (form != null &&
                                                  form.validate()) {
                                                form.save();
                                                final IngredientEvent event =
                                                    IngredientAdminUpdate(
                                                  widget
                                                      .argument.ingredient.name,
                                                  Ingredient(
                                                    id: _ingredient["id"],
                                                    name: _ingredient['name'],
                                                    category: _ingredient[
                                                            "category"] ??
                                                        "feritlizer",
                                                  ),
                                                );
                                                BlocProvider.of<IngredientBloc>(
                                                        context)
                                                    .add(event);
                                                Navigator.of(context)
                                                    .pushNamedAndRemoveUntil(
                                                        AdminIngredients
                                                            .routeName,
                                                        (route) => false);
                                              }
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
                                    )
                                  ],
                                ))
                          ],
                        )
                      ]))
            ]))));
  }
}
