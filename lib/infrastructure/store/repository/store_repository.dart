import 'package:location/location.dart';
import 'package:mitane_frontend/domain/ingredient/entity/ingredient_model.dart';
import 'package:mitane_frontend/domain/store/entity/store_model.dart';
import 'package:mitane_frontend/domain/product/entity/product_model.dart';
import 'package:mitane_frontend/domain/machinery/entity/machinery_model.dart';
import 'package:mitane_frontend/infrastructure/store/data_provider/store_provider.dart';

class StoreRepository {
  final StoreProvider storeProvider;
  StoreRepository({required this.storeProvider});

  Future<bool> createStore(double latitude, double longitude) async {
    try {
      return await storeProvider.createStore(latitude, longitude);
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<List<Ingredient>> getAllIngredientItems() async {
    return await storeProvider.getAllIngredientItems();
  }

  Future<List<Machinery>> getAllMachineryItems() async {
    return await storeProvider.getAllMachineryItems();
  }

  Future<List<Product>> getAllProductItems() async {
    return await storeProvider.getAllProductItems();
  }

  Future<bool> createProductItem(ProductItem item) async {
    return await storeProvider.createProductItem(item);
  }

  Future<bool> createMachineryItem(MachineryItem item) async {
    return await storeProvider.createMachineryItem(item);
  }

  Future<bool> createIngredientItem(IngridentItem item) async {
    return await storeProvider.createIngridentItem(item);
  }

  Future<Store> getSelfStore() async {
    try {
      final result = await storeProvider.getSelfStore();
      return Store.fromJson(result);
    } catch (e) {
      rethrow;
    }
  }

  Future<Store> getStoreById(String id) async {
    try {
      final result = await storeProvider.getStoreById(id);
      return Store.fromJson(result);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteProductItem(String type, String id) async {
    try {
      final result = await storeProvider.deleteAnItem(type, id);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateStoreItem(String type, String store, String productId,
      String storeitem, double price, int quantity) async {
    try {
      return await storeProvider.updateStoreItem(
          type, store, productId, storeitem, price, quantity);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Store>> getAllStore() async {
    try {
      final result = await storeProvider.getAllStores();
      return result.map((e) => Store.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> addItem(StoreItem item) async {
    try {
      return true;
    } catch (e) {
      throw Exception();
    }
  }

  Future<dynamic> location() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    return _locationData;
  }
}
