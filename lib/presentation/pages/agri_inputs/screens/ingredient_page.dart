import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitane_frontend/application/ingredient/bloc/ingredient_blocs.dart';
import 'package:mitane_frontend/domain/ingredient/entity/ingredient_model.dart';
import 'package:mitane_frontend/presentation/pages/agri_inputs/inputs.dart';
import 'package:mitane_frontend/presentation/pages/common/mainlayoutlistwithourfb.dart';

class IngredientScreen extends StatefulWidget {
  const IngredientScreen({Key? key}) : super(key: key);

  @override
  _IngredientScreenState createState() => _IngredientScreenState();
}

class _IngredientScreenState extends State<IngredientScreen> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //final arguments = ModalRoute.of(context)!.settings.arguments as String;
    return MainLayOutListingWoFB(
        image: "assets/fertlizerC.png",
        title: "Ingredients",
        children: [
          SizedBox(
            height: 15,
          ),
          Text("heeee"),
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
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: IngredientCard(
                            ingredientName: ingredients.elementAt(index).name,
                            category: ingredients.elementAt(index).category,
                          ),
                          key: ValueKey<Ingredient>(
                              ingredients.elementAt(index)),
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
        ]);
  }
}
