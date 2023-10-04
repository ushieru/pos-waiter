import 'dart:convert';

import 'package:total_pos_waiter/models/user.dart';

class AuthResponseDTO {
  AuthResponseDTO({
    required this.jwtToken,
    required this.user,
  });

  factory AuthResponseDTO.fromJson(Map<String, dynamic> json) {
    return AuthResponseDTO(
      jwtToken: json['token'],
      user: User.fromJson(json['user']),
    );
  }

  final String jwtToken;
  final User user;

  Map<String, dynamic> toJson() => {
        'token': jwtToken,
        'user': user.toJson(),
      };

  @override
  String toString() => '$runtimeType => ${jsonEncode(toJson())}';
}
