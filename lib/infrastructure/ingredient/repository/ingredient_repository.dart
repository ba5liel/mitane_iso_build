import 'package:mitane_frontend/domain/category/entity/category_model.dart';
import 'package:mitane_frontend/infrastructure/ingredient/data_provider/ingredient_provider.dart';
import 'package:mitane_frontend/domain/ingredient/entity/ingredient_model.dart';

class IngredientRepository {
  final IngredientDataProvider dataProvider;
  IngredientRepository({required this.dataProvider});

  Future<bool> create(Ingredient ingredient) async {
    return this.dataProvider.create(ingredient);
  }

  Future<Ingredient> update(String name, Ingredient ingredient) async {
    return this.dataProvider.update(name, ingredient);
  }

  Future<List<Ingredient>> fetchAll() async {
    return this.dataProvider.fetchAll();
  }

  Future<List<Category>> getIngredientsCategory() async {
    return this.dataProvider.getIngredientsCategory();
  }

  Future<void> delete(String id) async {
    this.dataProvider.delete(id);
  }
}
