import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:total_pos_waiter/models/dto/auth_response_dto.dart';
import 'package:total_pos_waiter/models/errors/response_error.dart';
import 'package:total_pos_waiter/models/settings.dart';

class AuthService {
  Future<(AuthResponseDTO?, ErrorResponse?)> login(
      String username, String password) async {
    final response = await http.post(
        Uri.http(Settings.serverHost, '/auth/login'),
        body: {'username': username, 'password': password});
    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode != 200) {
      return (null, ErrorResponse.fromJson(jsonResponse));
    }
    return (AuthResponseDTO.fromJson(jsonResponse), null);
  }
}
