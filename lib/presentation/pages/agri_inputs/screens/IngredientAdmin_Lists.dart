import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mitane_frontend/application/ingredient/bloc/ingredient_blocs.dart';
import 'package:mitane_frontend/domain/ingredient/entity/ingredient_model.dart';
import 'package:mitane_frontend/presentation/pages/admin/screens/Admin_Home.dart';
import 'package:mitane_frontend/presentation/pages/agri_inputs/inputs.dart';
import 'package:mitane_frontend/presentation/pages/common/SlideEditAndDelete.dart';
import 'package:mitane_frontend/presentation/pages/common/mainlayoutlist.dart';
import 'package:mitane_frontend/route_generator.dart';

class AdminIngredients extends StatefulWidget {
  static const routeName = '/admin/ingredients';

  static Ingredient editArg = Ingredient(id: "", name: "", category: "");

  @override
  _AdminIngredientsState createState() => _AdminIngredientsState();
}

class _AdminIngredientsState extends State<AdminIngredients> {
  @override
  Widget build(BuildContext context) {
    return MainLayOutListing(
      title: "Ingredients",
      image: "assets/fertlizerC.png",
      back: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AdminHome()));
      },
      children: [
        SizedBox(
          height: 15,
        ),
        Expanded(
          child: BlocBuilder<IngredientBloc, IngredientState>(
            builder: (_, state) {
              if (state is IngredientAdminOperationFailure) {
                return Text('Error: Displaying ingredients list');
              }

              if (state is IngredientAdminOperationSuccess) {
                final ingredients = state.ingredients;

                return ListView.builder(
                    itemCount: ingredients.length.toInt(),
                    itemBuilder: (_, int index) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Dismissible(
                          child: IngredientCard(
                            ingredientName: ingredients.elementAt(index).name,
                            category: ingredients.elementAt(index).category,
                          ),
                          background: slideRightBackground(),
                          secondaryBackground: slideLeftBackground(),
                          key: ValueKey<Ingredient>(
                              ingredients.elementAt(index)),
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.endToStart) {
                              final bool res = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Text(
                                          "Are you sure you want to delete ${ingredients.elementAt(index).name}?"),
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
                                              BlocProvider.of<IngredientBloc>(
                                                      context)
                                                  .add(IngredientAdminDelete(
                                                      ingredients
                                                          .elementAt(index)
                                                          .name
                                                          .toString()));
                                              Navigator.of(context)
                                                  .pushNamedAndRemoveUntil(
                                                      AdminIngredients
                                                          .routeName,
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
                              AdminIngredients.editArg =
                                  ingredients.elementAt(index);
                              Navigator.of(context).pushNamed(
                                AdminIngredientEdit.routeName,
                                arguments: IngredientArgument(
                                    ingredient: ingredients.elementAt(index)),
                              );
                            }
                          },
                        ),
                      );
                    });
              }
              print(state);
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
        AdminIngredientAdd.routeName,
      ),
    );
  }
}

class IngredientCard extends StatelessWidget {
  final String ingredientName;
  final String category;
  const IngredientCard(
      {Key? key, required this.ingredientName, required this.category})
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
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "$ingredientName",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: "RobotMono"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Category:",
                                style: TextStyle(
                                    fontSize: 16, fontFamily: "RobotMono"),
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
                    ),
                  )
                ],
              ),
            ),
          ]),
        ));
  }
}
