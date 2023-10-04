import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:total_pos_waiter/models/product.dart';
import 'package:total_pos_waiter/models/settings.dart';

class ProductsService {
  Future<List<Product>> getProducts(String jwt) async {
    try {
      final response = await http.get(
          Uri.http(Settings.serverHost, '/products'),
          headers: {'Authorization': 'Bearer $jwt'});
      final jsonList = jsonDecode(response.body) as List<dynamic>;
      return jsonList.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      log('Error: Class ProductsService => Method getProducts');
      log(e.toString());
      return [];
    }
  }

  Future<Product> getProductByID(String jwt, int productId) async {
    try {
      final response = await http.get(
          Uri.http(Settings.serverHost, '/products/$productId'),
          headers: {'Authorization': 'Bearer $jwt'});
      final jsonProduct = jsonDecode(response.body);
      return Product.fromJson(jsonProduct);
    } catch (e) {
      log('Error: Class ProductsService => Method getProductByID');
      log(e.toString());
      throw 'Error getProductByID';
    }
  }

  Future<List<Product>> getProductsByCategoryId(
      String jwt, int categoryId) async {
    try {
      final response = await http.get(
          Uri.http(Settings.serverHost, '/products/categories/$categoryId'),
          headers: {'Authorization': 'Bearer $jwt'});
      final jsonList = jsonDecode(response.body) as List<dynamic>;
      return jsonList.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      log('Error: Class ProductsService => Method getProductsByCategoryId');
      log(e.toString());
      return [];
    }
  }
}
