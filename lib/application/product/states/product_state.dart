import 'package:equatable/equatable.dart';
import 'package:mitane_frontend/domain/category/entity/category_model.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductAdminLoading extends ProductState {}

class ProductAdminOperationSuccess extends ProductState {
  final Iterable<dynamic> products;
  final List<Category> categories;

  ProductAdminOperationSuccess(
      [this.products = const [], this.categories = const []]);

  @override
  List<Object> get props => [products, categories];
}

class ProductAdminOperationFailure extends ProductState {}

class ProductAdminDeleted extends ProductState {}

class ProductAdminDeleteFailure extends ProductState {}
