import 'dart:convert';

import 'package:total_pos_waiter/models/account.dart';
import 'package:total_pos_waiter/models/model.dart';

class User extends Model {
  User({
    required super.id,
    required super.createAt,
    required super.updateAt,
    required super.deleteAt,
    required this.name,
    required this.email,
    required this.account,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final model = Model.fromJson(json);
    return User(
      id: model.id,
      name: json['name'],
      email: json['email'],
      account: Account.fromJson(json['account']),
      createAt: model.createAt,
      updateAt: model.updateAt,
      deleteAt: model.deleteAt,
    );
  }

  final String name;
  final String email;
  final Account account;

  @override
  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'account': account.toJson(),
        ...super.toJson()
      };

  @override
  String toString() => '$runtimeType => ${jsonEncode(toJson())}';
}
