import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:total_pos_waiter/models/user.dart';
import 'package:total_pos_waiter/models/settings.dart';

class UsersService {
  Future<List<User>> getUsers(String jwt) async {
    try {
      final response = await http.get(Uri.http(Settings.serverHost, '/users'),
          headers: {'Authorization': 'Bearer $jwt'});
      final jsonList = jsonDecode(response.body) as List<dynamic>;
      return jsonList.map((json) => User.fromJson(json)).toList();
    } catch (e) {
      log('Error: Class UsersService => Method getUsers');
      log(e.toString());
      return [];
    }
  }
}
