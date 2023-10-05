import 'dart:convert';

import 'package:total_pos_waiter/models/account.dart';
import 'package:total_pos_waiter/models/model.dart';
import 'package:total_pos_waiter/models/ticket.dart';

class Table extends Model {
  Table({
    required super.id,
    required super.createAt,
    required super.updateAt,
    required super.deleteAt,
    required this.name,
    required this.posX,
    required this.posY,
    required this.account,
    required this.ticket,
  });

  factory Table.fromJson(Map<String, dynamic> json) {
    final model = Model.fromJson(json);
    return Table(
      id: model.id,
      createAt: model.createAt,
      updateAt: model.updateAt,
      deleteAt: model.deleteAt,
      name: json['name'],
      posX: json['pos_x'],
      posY: json['pos_y'],
      account: json['account']['id'] != 0 ? Account.fromJson(json['account']) : null,
      ticket: json['ticket']['id'] != 0 ? Ticket.fromJson(json['ticket']) : null,
    );
  }

  final String name;
  final int posX;
  final int posY;
  final Account? account;
  final Ticket? ticket;

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'name': name,
      'posX': posX,
      'posY': posY,
      'account': account?.toJson(),
      'ticket': ticket?.toJson(),
    };
  }

  @override
  String toString() => '$runtimeType => ${jsonEncode(toJson())}';
}
