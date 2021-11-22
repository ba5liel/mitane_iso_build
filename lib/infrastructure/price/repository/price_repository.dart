import 'package:dio/dio.dart';
import 'package:mitane_frontend/domain/price/entity/price_model.dart';
import 'package:mitane_frontend/domain/product/entity/product_model.dart';
import 'package:mitane_frontend/infrastructure/price/data_provider/price_provider.dart';

class PriceRepository {
  PriceProvider priceProvider = PriceProvider(dio: Dio());
  PriceRepository();

  Future<List<dynamic>> getPrice(DateTime date) async {
    String year = date.year.toString();
    String month = date.month.toString();
    String day = date.day.toString();

    if (date.day < 10) {
      day = '0' + date.day.toString();
    }
    if (date.month < 10) {
      month = '0' + date.month.toString();
    }
    try {
      final result = await priceProvider.getPrice('$year-$month-$day');
      return result;
    } catch (e) {
      throw Exception();
    }
  }

  Future<bool> createProduct(ProductPrice productPrice) async {
    try {
      final result = await priceProvider.createProduct(productPrice);
      if (result) return true;
      throw Exception('error');
    } catch (e) {
      throw Exception('error');
    }
  }

  Future<bool> addDailyPrice(PriceAdd priceAdd) async {
    try {
      final result = await priceProvider.addDailyPrice(priceAdd);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> updateDailyPrice(
      String product, String price, DateTime date) async {
    final year = date.year;
    final month = date.month;
    final day = date.day;
    try {
      final result = await priceProvider.updateDailyPrice(
          product, price, "$year-$month-$day");
      if (result)
        return true;
      else
        throw Exception('error');
    } catch (e) {
      throw Exception('error');
    }
  }

  Future<bool> deleteSpecificPrice(
      String product, int price, DateTime date) async {
    final year = date.year;
    final month = date.month;
    final day = date.day;
    try {
      final result = await priceProvider.deleteSpecificPrice(PriceDelete(
          product: product, price: price, date: "$year-$month-$day"));
      if (result) return true;
      return false;
    } catch (e) {
      throw Exception('error');
    }
  }
  Future<List<String>> fetchProduct() async {
    try{
      return  await priceProvider.fetchProduct();
      
    }catch(e){
      throw Exception('error');
    }
  }
}
