import 'package:mitane_frontend/domain/store/entity/store_model.dart';

abstract class StoreEvent {
  const StoreEvent();
}

class FetchStore extends StoreEvent {}

class CreateStoreFirst extends StoreEvent {}

class FetchMachinery extends StoreEvent {}

class FetchIngredient extends StoreEvent {}

class FetchProduct extends StoreEvent {}

class FetchStoreAll extends StoreEvent {}

class FetchStoreById extends StoreEvent {
  final String id;
  const FetchStoreById({ required this.id });
}

class AddStore extends StoreEvent {
  final StoreItem item;
  AddStore({required this.item});
}

class ProductItemCreate extends StoreEvent {
  final ProductItem item;

  const ProductItemCreate(this.item);

  @override
  String toString() => 'Product item Created {User: ${item}}';
}

class MachineryItemCreate extends StoreEvent {
  final MachineryItem item;

  const MachineryItemCreate(this.item);

  @override
  String toString() => 'Machinery item Created {User: ${item}}';
}

class IngredientItemCreate extends StoreEvent {
  final IngridentItem item;

  const IngredientItemCreate(this.item);

  @override
  String toString() => 'Ingredient item Created {User: ${item}}';
}

class UpdateStore extends StoreEvent {}

class UpdateStoreItem extends StoreEvent {
  final String type;
  final String store;
  final String storeItem;
  final String productId;
  final int quantity;
  final double price;

  UpdateStoreItem(
      {required this.productId,
      required this.type,
      required this.quantity,
      required this.price,
      required this.store,
      required this.storeItem});
}

class DeleteStore extends StoreEvent {}

class DeleteStoreItem extends StoreEvent {
  final String type;
  final String item;
  DeleteStoreItem(this.type, this.item);
}

class DeleteStoreFailed extends StoreEvent {}

class DeleteStoreItemFailed extends StoreEvent {}
