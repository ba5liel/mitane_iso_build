import 'package:mitane_frontend/domain/category/entity/category_model.dart';
import 'package:mitane_frontend/infrastructure/product/data_provider/product_provider.dart';
import 'package:mitane_frontend/domain/product/entity/product_model.dart';

class ProductRepository {
  final ProductDataProvider dataProvider;
  ProductRepository({required this.dataProvider});

  Future<bool> create(Product product) async {
    return this.dataProvider.create(product);
  }

  Future<Product> update(String name, Product product) async {
    return this.dataProvider.update(name, product);
  }

  Future<List<Product>> fetchAll() async {
    return this.dataProvider.fetchAll();
  }

  Future<List<Category>> getProductsCategory() async {
    return this.dataProvider.getProductsCategory();
  }

  Future<void> delete(String name) async {
    this.dataProvider.delete(name);
  }
}
