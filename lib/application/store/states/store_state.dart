import 'package:equatable/equatable.dart';
import 'package:mitane_frontend/domain/ingredient/entity/ingredient_model.dart';
import 'package:mitane_frontend/domain/machinery/entity/machinery_model.dart';
import 'package:mitane_frontend/domain/product/entity/product_model.dart';
import 'package:mitane_frontend/domain/store/entity/store_model.dart';

abstract class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object> get props => [];
}

class StoreInit extends StoreState {}

class StoreFetched extends StoreState {
  final Store stores;
  final List<Product> products;
  final List<Ingredient> ingredients;
  final List<Machinery> machineries;
  StoreFetched(
      {required this.stores,
      this.ingredients = const [],
      this.machineries = const [],
      this.products = const []});

  @override
  List<Object> get props => [products, ingredients, machineries, stores];
}

class StoreAllFetched extends StoreState {
  final List<Store> stores;
  StoreAllFetched({required this.stores});
}

class StoreFetchedById extends StoreState {
  final Store store;
  StoreFetchedById({required this.store});
}

class StoreCreated extends StoreState {}

class NoStoreFound extends StoreState {}

class StoreEmpty extends StoreState {}

class StoreItemEmpty extends StoreState {}

class StoreFetchFailed extends StoreState {}

class StoreItemAdded extends StoreState {}

class StoreItemAdding extends StoreState {}

class StoreItemAddFailed extends StoreState {}

class StoreUpdate extends StoreState {}

class StoreUpdating extends StoreState {}

class StoreUpdateFailed extends StoreState {}

class StoreItemUpdated extends StoreState {}

class StoreItemUpdating extends StoreState {}

class StoreItemUpdatedFailed extends StoreState {}

class StoreItemDelete extends StoreState {}

class StoreItemDeleting extends StoreState {}

class StoreItemDeleteFailed extends StoreState {}
