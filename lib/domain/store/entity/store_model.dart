import 'package:mitane_frontend/domain/product/entity/product_model.dart';
import 'package:mitane_frontend/domain/ingredient/entity/ingredient_model.dart';
import 'package:mitane_frontend/domain/machinery/entity/machinery_model.dart';
// class Ingredient {
//   final Map<String, dynamic> user;
//   final List<Map<String, dynamic>> ingredient;
//   final Map<String, dynamic> pricePerPnit;

//   factory Ingredient.fromJson(Map<String, dynamic> json) {
//     return Ingredient(
//         user: json['user'],
//         ingredient: json['ingredients'],
//         pricePerPnit: json['price_per_unit']);
//   }

//   Ingredient(
//       {required this.user,
//       required this.ingredient,
//       required this.pricePerPnit});
// }

// class Machinery {
//   final Map<String, dynamic> user;
//   final List<Map<String, dynamic>> machinery;
//   final Map<String, dynamic> pricePerPnit;

//   factory Machinery.fromJson(Map<String, dynamic> json) {
//     return Machinery(
//         user: json['user'],
//         machinery: json['machinerys'],
//         pricePerPnit: json['price_per_unit']);
//   }

//   Machinery(
//       {required this.user,
//       required this.machinery,
//       required this.pricePerPnit});
// }

// class Product {
//   final Map<String, dynamic> category;
//   final String name;

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(category: json['user'], name: json['products']);
//   }

//   Product({required this.category, required this.name});
// }

class EmptyProduct {}

class ProductItem {
  String? id;
  Product product;
  int quantity;
  double pricerPerKg;
  ProductItem(this.id, this.product, this.quantity, this.pricerPerKg);
  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(json["_id"], Product.fromJson(json["product"]),
        json["quantity"], json["price_per_kg"] / 1);
  }
}

class MachineryItem {
  String? id;
  Machinery machinery;
  int quantity;
  double pricerPerPiece;
  MachineryItem(this.id, this.machinery, this.quantity, this.pricerPerPiece);
  factory MachineryItem.fromJson(Map<String, dynamic> json) {
    return MachineryItem(json["_id"], Machinery.fromJson(json["machinery"]),
        json["quantity"], json["price_per_piece"] / 1);
  }
}

class IngridentItem {
  String? id;
  Ingredient ingredients;
  int quantity;
  double pricerPerKg;
  IngridentItem(this.id, this.ingredients, this.quantity, this.pricerPerKg);
  factory IngridentItem.fromJson(Map<String, dynamic> json) {
    return IngridentItem(json["_id"], Ingredient.fromJson(json["ingredients"]),
        json["quantity"], json["price_per_kg"] / 1);
  }
}

class Store {
  final String user;
  final String id;
  final Map<String, dynamic> location;

  final List<ProductItem> productItems;
  final List<MachineryItem> machineryItems;
  final List<IngridentItem> ingredientItems;

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
        (json['machinery_items'] as List).map<MachineryItem>((e) {
          return MachineryItem.fromJson(e);
        }).toList(),
        (json['ingredient_items'] as List)
            .map<IngridentItem>((e) => IngridentItem.fromJson(e))
            .toList(),
        (json['product_items'] as List)
            .map<ProductItem>((e) => ProductItem.fromJson(e))
            .toList(),
        user: json['user']["name"],
        id: json['_id'],
        location: json['location']);
  }

  Store(this.machineryItems, this.ingredientItems, this.productItems,
      {required this.user, required this.id, required this.location});
}

class StoreItem {
  final String? product;
  final double price;
  final int quantity;

  StoreItem(
      {required this.price, required this.product, required this.quantity});
}
