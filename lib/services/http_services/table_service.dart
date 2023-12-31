import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:total_pos_waiter/models/settings.dart';
import 'package:total_pos_waiter/models/table.dart';

class TablesService {
  Future<List<Table>> getTables(String jwt) async {
    final response = await http.get(Uri.http(Settings.serverHost, '/tables'),
        headers: {'Authorization': 'Bearer $jwt'});
    final jsonList = jsonDecode(response.body) as List<dynamic>;
    return jsonList.map((json) => Table.fromJson(json)).toList();
  }

  Future<Table> createTableTicket(String jwt, int tableId) async {
    final response = await http.post(
        Uri.http(Settings.serverHost, '/tables/$tableId/ticket'),
        headers: {'Authorization': 'Bearer $jwt'});
    final jsonResponse = jsonDecode(response.body);
    return Table.fromJson(jsonResponse);
  }
}
