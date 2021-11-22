import 'package:equatable/equatable.dart';
import 'package:mitane_frontend/domain/ingredient/entity/ingredient_model.dart';

abstract class IngredientEvent extends Equatable {
  const IngredientEvent();
}

class IngredientAdminLoad extends IngredientEvent {
  const IngredientAdminLoad();

  @override
  List<Object> get props => [];
}

class IngredientAdminCreate extends IngredientEvent {
  final Ingredient ingredient;

  const IngredientAdminCreate(this.ingredient);

  @override
  List<Object> get props => [ingredient];

  @override
  String toString() => 'Ingredient Created {User: $ingredient}';
}

class IngredientAdminUpdate extends IngredientEvent {
  final Ingredient ingredient;
  final String name;

  const IngredientAdminUpdate(this.name, this.ingredient);

  @override
  List<Object> get props => [name, ingredient];

  @override
  String toString() => 'Ingredient Updated {User: $name}';
}

class IngredientAdminDelete extends IngredientEvent {
  final String name;

  const IngredientAdminDelete(this.name);

  @override
  List<Object> get props => [name];

  @override
  toString() => 'Ingredient Deleted {User Id: $name}';
}
