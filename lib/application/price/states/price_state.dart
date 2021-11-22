import 'package:mitane_frontend/domain/product/entity/product_model.dart';

abstract class PriceState {}

class PriceFetching extends PriceState {}
class ProductPriceFetched extends PriceState{
 List<String> products;

  ProductPriceFetched(this.products);
}
class PriceFetched extends PriceState {
  final List<dynamic> priceDaily;
  PriceFetched({required this.priceDaily});
}

class PriceAdding extends PriceState {}


class PriceUpdating extends PriceState {}

class PriceDeleting extends PriceState {}

class OperationSuccessful extends PriceState{}

class OperationFailed extends PriceState {}
