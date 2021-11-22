import 'package:equatable/equatable.dart';
import 'package:mitane_frontend/domain/product/entity/product_model.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class ProductAdminLoad extends ProductEvent {
  const ProductAdminLoad();

  @override
  List<Object> get props => [];
}

class ProductAdminCreate extends ProductEvent {
  final Product product;

  const ProductAdminCreate(this.product);

  @override
  List<Object> get props => [product];

  @override
  String toString() => 'Product Created {User: $product}';
}

class ProductAdminUpdate extends ProductEvent {
  final Product product;
  final String name;

  const ProductAdminUpdate(this.name, this.product);

  @override
  List<Object> get props => [name, product];

  @override
  String toString() => 'Product Updated {User: ${name}}';
}

class ProductAdminDelete extends ProductEvent {
  final String name;

  const ProductAdminDelete(this.name);

  @override
  List<Object> get props => [name];

  @override
  toString() => 'Product Deleted {User Name: $name}';
}
