import 'dart:convert';

import 'package:total_pos_waiter/models/model.dart';

class Account extends Model {
  Account(
      {required super.id,
      required super.createAt,
      required super.updateAt,
      required super.deleteAt,
      required this.username,
      required this.isActive,
      required this.accountType});

  factory Account.fromJson(Map<String, dynamic> json) {
    final model = Model.fromJson(json);
    return Account(
      id: model.id,
      username: json['username'],
      isActive: json['is_active'],
      accountType: AccountType.values.firstWhere(
          (accountType) => accountType.name == json['account_type'],
          orElse: () => AccountType.waiter),
      createAt: model.createAt,
      updateAt: model.updateAt,
      deleteAt: model.deleteAt,
    );
  }

  final String username;
  final bool isActive;
  final AccountType accountType;

  @override
  Map<String, dynamic> toJson() => {
        'username': username,
        'is_active': isActive,
        ...super.toJson(),
      };

  @override
  String toString() => '$runtimeType => ${jsonEncode(toJson())}';
}

enum AccountType { admin, cashier, waiter }
