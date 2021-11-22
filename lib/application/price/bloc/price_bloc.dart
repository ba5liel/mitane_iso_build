import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitane_frontend/application/price/events/price_event.dart';
import 'package:mitane_frontend/application/price/states/price_state.dart';
import 'package:mitane_frontend/domain/price/entity/price_model.dart';
import 'package:mitane_frontend/infrastructure/price/repository/price_repository.dart';

class PriceBloc extends Bloc<PriceEvent, PriceState> {
  PriceRepository priceRepository = PriceRepository();

  PriceBloc() : super(PriceFetching());

  @override
  Stream<PriceState> mapEventToState(PriceEvent event) async* {
    DateTime date = DateTime.now();

    if (event is PriceFetch) {
      try {
        final price = await priceRepository.getPrice(date);
        if (price is List<dynamic>) {
          if (price[0] is PriceDaily)
            yield PriceFetched(priceDaily: price);
          else
            yield OperationFailed();
        } else {
          yield OperationFailed();
        }
      } catch (e) {
        yield OperationFailed();
      }
    } else if (event is AddPrice) {
      try {
        final result = await priceRepository.addDailyPrice(
            PriceAdd(product: event.item, price: double.parse(event.price)));
        if (result) {
          yield OperationSuccessful();
        } else {
          yield OperationFailed();
        }
      } catch (e) {
        yield OperationFailed();
      }
    } else if (event is UpdatePrice) {
      try {
        final result = await priceRepository.updateDailyPrice(
            event.product, event.price, date);
        if (result)
          yield OperationSuccessful();
        else
          yield OperationFailed();
      } catch (e) {
        yield OperationSuccessful();
      }
    } else if (event is DeletePrice) {
      try {
        final result = await priceRepository.deleteSpecificPrice(
            event.product, event.price, date);
        if (result) yield OperationSuccessful();
      } catch (e) {
        yield OperationFailed();
      }
    } else if (event is ProductPriceFetch) {
      try {
        final result = await priceRepository.fetchProduct();
        if (result is List<String>) {
          yield ProductPriceFetched(result);
        } else {
          yield OperationFailed();
        }
      } catch (e) {
        yield OperationFailed();
      }
    }
  }
}
