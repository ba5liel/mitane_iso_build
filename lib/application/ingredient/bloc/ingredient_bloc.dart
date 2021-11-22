import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitane_frontend/application/ingredient/events/ingredient_event.dart';
import 'package:mitane_frontend/application/ingredient/states/ingredient_state.dart';
import 'package:mitane_frontend/infrastructure/ingredient/repository/ingredient_repository.dart';

class IngredientBloc extends Bloc<IngredientEvent, IngredientState> {
  final IngredientRepository ingredientRepository;

  IngredientBloc({required this.ingredientRepository})
      : super(IngredientAdminLoading());

  @override
  Stream<IngredientState> mapEventToState(IngredientEvent event) async* {
    if (event is IngredientAdminLoad) {
      yield IngredientAdminLoading();
      try {
        final ingredientAdmins = await ingredientRepository.fetchAll();
        final categoryAdmins =
            await ingredientRepository.getIngredientsCategory();
        print("Successfully listed");
        yield IngredientAdminOperationSuccess(ingredientAdmins, categoryAdmins);
      } catch (_) {
        yield IngredientAdminOperationFailure();
      }
    }

    if (event is IngredientAdminCreate) {
      try {
        print("create ingrient ");
        await ingredientRepository.create(event.ingredient);
        final ingredientAdmins = await ingredientRepository.fetchAll();
        final categoryAdmins =
            await ingredientRepository.getIngredientsCategory();
        yield IngredientAdminOperationSuccess(ingredientAdmins, categoryAdmins);
      } catch (_) {
        yield IngredientAdminOperationFailure();
      }
    }

    if (event is IngredientAdminUpdate) {
      try {
        await ingredientRepository.update(event.name, event.ingredient);
        final ingredientAdmins = await ingredientRepository.fetchAll();
        final categoryAdmins =
            await ingredientRepository.getIngredientsCategory();
        print("Successfully updated and listed");
        yield IngredientAdminOperationSuccess(ingredientAdmins, categoryAdmins);
      } catch (_) {
        rethrow;
        yield IngredientAdminOperationFailure();
      }
    }

    if (event is IngredientAdminDelete) {
      try {
        await ingredientRepository.delete(event.name);
        print("Successfully deleted and listed");
        yield IngredientAdminDeleted();
      } catch (_) {
        yield IngredientAdminOperationFailure();
      }
    }
  }
}
