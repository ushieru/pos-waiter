import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:total_pos_waiter/models/category.dart';
import 'package:total_pos_waiter/models/settings.dart';

class CategoriesService {
  Future<List<Category>> getCategories(String jwt) async {
    try {
      final response = await http.get(
          Uri.http(Settings.serverHost, '/categories'),
          headers: {'Authorization': 'Bearer $jwt'});
      final jsonList = jsonDecode(response.body) as List<dynamic>;
      return jsonList.map((json) => Category.fromJson(json)).toList();
    } catch (e) {
      log('Error: Class CategoriesService => Method getCategories');
      log(e.toString());
      return [];
    }
  }
}
