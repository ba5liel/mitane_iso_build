import 'package:equatable/equatable.dart';
import 'package:mitane_frontend/domain/category/entity/category_model.dart';

abstract class IngredientState extends Equatable {
  const IngredientState();

  @override
  List<Object> get props => [];
}

class IngredientAdminLoading extends IngredientState {}

class IngredientAdminOperationSuccess extends IngredientState {
  final Iterable<dynamic> ingredients;
  final List<Category> categories;

  IngredientAdminOperationSuccess(
      [this.ingredients = const [], this.categories = const []]);

  @override
  List<Object> get props => [ingredients, categories];
}

class IngredientAdminOperationFailure extends IngredientState {}

class IngredientAdminOperationCreated extends IngredientState {}

class IngredientAdminDeleted extends IngredientState {}
