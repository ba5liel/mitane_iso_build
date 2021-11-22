import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitane_frontend/application/product/events/product_events.dart';
import 'package:mitane_frontend/application/product/states/product_state.dart';
import 'package:mitane_frontend/infrastructure/product/repository/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({required this.productRepository}) : super(ProductAdminLoading());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    print(event);
    if (event is ProductAdminLoad) {
      yield ProductAdminLoading();
      try {
        final productAdmins = await productRepository.fetchAll();
        final categoryAdmins = await productRepository.getProductsCategory();
        print("Successfully listed");
        yield ProductAdminOperationSuccess(productAdmins, categoryAdmins);
      } catch (_) {
        yield ProductAdminOperationFailure();
      }
    }

    if (event is ProductAdminCreate) {
      try {
        await productRepository.create(event.product);
        final productAdmins = await productRepository.fetchAll();
        final categoryAdmins = await productRepository.getProductsCategory();
        print("Successfully created and listed");
        yield ProductAdminOperationSuccess(productAdmins, categoryAdmins);
      } catch (_) {
        yield ProductAdminOperationFailure();
      }
    }

    if (event is ProductAdminUpdate) {
      try {
        await productRepository.update(event.name, event.product);
        final productAdmins = await productRepository.fetchAll();
        final categoryAdmins = await productRepository.getProductsCategory();
        print("Successfully updated and listed");
        yield ProductAdminOperationSuccess(productAdmins, categoryAdmins);
      } catch (_) {
        yield ProductAdminOperationFailure();
      }
    }

    if (event is ProductAdminDelete) {
      try {
        await productRepository.delete(event.name);
        print("Successfully deleted and listed");
        yield ProductAdminDeleted();
      } catch (_) {
        yield ProductAdminDeleteFailure();
      }
    }
  }
}
