import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:mitane_frontend/application/store/events/store_events.dart';
import 'package:mitane_frontend/application/store/states/store_state.dart';
import 'package:mitane_frontend/infrastructure/store/repository/store_repository.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final StoreRepository storeRepository;
  StoreBloc({required this.storeRepository}) : super(StoreInit());

  @override
  Stream<StoreState> mapEventToState(StoreEvent event) async* {
    if (event is FetchStore) {
      try {
        print("FetchStore called");

        final stores = await storeRepository.getSelfStore();  
        final products = await storeRepository.getAllProductItems();
        final machineries = await storeRepository.getAllMachineryItems();
        final ingredients = await storeRepository.getAllIngredientItems();
        print("Fetch store ${stores.productItems}");

        yield StoreFetched(
            stores: stores,
            products: products,
            machineries: machineries,
            ingredients: ingredients);
      } on DioError catch (e)  {
        print(e.response);
        if (e.response!.data?['message'] == "User doesn't have a store") {
            yield NoStoreFound();
        }
        rethrow;
        yield StoreFetchFailed();
      }
    }

    Future<LocationData?> location() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();

    return _locationData;
  }


    if (event is CreateStoreFirst) {
      try {
        final LocationData? loc = await location();
        await storeRepository.createStore(loc!.latitude ?? 0.0, loc.longitude ?? 0.0);
        yield StoreCreated();
        
      } catch (e) {
        rethrow;
      }
    }

    if (event is FetchStoreAll) {
      try {
        print("FetchStoreAll called");
        final stores = await storeRepository.getAllStore();
        if (stores != []) {
          yield StoreAllFetched(stores: stores);
        } else
          yield StoreAllFetched(stores: stores);
      } catch (e) {
        rethrow;
        yield StoreFetchFailed();
      }
    }

    if (event is FetchStoreById) {
      try {
        print("FetchStoreAll called");
        final store = await storeRepository.getStoreById(event.id);
        if (store != []) {
          yield StoreFetchedById(store: store);
        } else
          yield StoreFetchedById(store: store);
      } catch (e) {
        rethrow;
        yield StoreFetchFailed();
      }
    }

    if (event is ProductItemCreate) {
      try {
        print("Create product item....");
        await storeRepository.createProductItem(event.item);

        /* final stores = await storeRepository.getSelfStore();
        final products = await storeRepository.getAllProductItems();
        final machineries = await storeRepository.getAllMachineryItems();
        // final ingredients = await storeRepository.getAllIngredientItems(); */
        yield StoreItemAdded();
        print("Successfully created product item and listed");
        /* yield StoreFetched(
            stores: stores, products: products, machineries: machineries); */
      } catch (_) {
        yield StoreItemAddFailed();
      }
    }

    if (event is MachineryItemCreate) {
      try {
        print("Create machinery item....");
        await storeRepository.createMachineryItem(event.item);

        /* final stores = await storeRepository.getSelfStore();
        final products = await storeRepository.getAllProductItems();
        final machineries = await storeRepository.getAllMachineryItems();
        // final ingredients = await storeRepository.getAllIngredientItems(); */
        yield StoreItemAdded();
        print("Successfully created product item and listed");
        /* yield StoreFetched(
            stores: stores, products: products, machineries: machineries); */
      } catch (_) {
        yield StoreItemAddFailed();
      }
    }

    if (event is IngredientItemCreate) {
      try {
        print("Create ingredient item....");
        await storeRepository.createIngredientItem(event.item);

        /* final stores = await storeRepository.getSelfStore();
        final products = await storeRepository.getAllProductItems();
        final machineries = await storeRepository.getAllMachineryItems();
        // final ingredients = await storeRepository.getAllIngredientItems(); */
        yield StoreItemAdded();
        print("Successfully created product item and listed");
        /* yield StoreFetched(
            stores: stores, products: products, machineries: machineries); */
      } catch (_) {
        yield StoreItemAddFailed();
      }
    }

    // if (event is AddStore) {
    //   try {
    //     final storeCheck = await storeRepository.getSelfStore();
    //     if (storeCheck != []) {
    //       print('store exist');
    //       final result = await storeRepository.addItem(event.item);
    //       if (result) {
    //         print("added item");
    //         yield StoreItemAdded();
    //       } else {
    //         yield StoreItemAddFailed();
    //       }
    //     } else {
    //       final creatStore = await storeRepository.createStore();
    //       if (creatStore) {
    //         print('store created');
    //         yield StoreItemAddFailed();
    //       }
    //     }
    //   } catch (e) {
    //     yield StoreItemAddFailed();
    //   }
    // }

    if (event is UpdateStore) {}

    if (event is UpdateStoreItem) {
      try {
        yield StoreItemUpdating();
        print("StoreItemUpdating");
        final storeCheck = await storeRepository.updateStoreItem(
            event.type,
            event.store,
            event.productId,
            event.storeItem,
            event.price,
            event.quantity);
        print("storeCheck $storeCheck");
        if (storeCheck) {
          yield StoreItemUpdated();
        } else {
          yield StoreItemUpdatedFailed();
        }
      } catch (e) {
        print(e);
        yield StoreItemDeleteFailed();
      }
    }
    if (event is DeleteStore) {}
    if (event is DeleteStoreItem) {
      try {
        yield StoreItemDeleting();
        print("StoreDeleting");
        final storeCheck =
            await storeRepository.deleteProductItem(event.type, event.item);
        print("storeCheck $storeCheck");
        if (storeCheck) {
          yield StoreItemDelete();
        } else {
          yield StoreItemDeleteFailed();
        }
      } catch (e) {
        print(e);
        yield StoreItemDeleteFailed();
      }
    }
  }
}
