import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:total_pos_waiter/models/settings.dart';

class UtilsService {
  Future<bool> testConnection(String serverHost) async {
    try {
      final response = await http.get(Uri.http(serverHost, '/ping'));
      return response.body == "pong";
    } catch (e) {
      return false;
    }
  }

  Future<String> getInfo() async {
    try {
      final response = await http.get(Uri.http(Settings.serverHost, '/info'));
      log(response.body);
      return response.body;
    } catch (e) {
      return "";
    }
  }
}
