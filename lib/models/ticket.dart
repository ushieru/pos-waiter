import 'dart:convert';

import 'package:total_pos_waiter/models/account.dart';
import 'package:total_pos_waiter/models/model.dart';
import 'package:total_pos_waiter/models/ticket_product.dart';

enum TicketStatus { open, close }

class Ticket extends Model {
  Ticket({
    required super.id,
    required super.createAt,
    required super.updateAt,
    required super.deleteAt,
    required this.account,
    required this.ticketStatus,
    required this.total,
    required this.ticketProducts,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    final model = Model.fromJson(json);
    final ticketProducts = (json['ticket_products'] as List<dynamic>? ?? [])
        .map((ticketProduct) => TicketProduct.fromJson(ticketProduct))
        .toList();
    return Ticket(
      id: model.id,
      createAt: model.createAt,
      updateAt: model.updateAt,
      deleteAt: model.deleteAt,
      account: Account.fromJson(json['account']),
      ticketStatus: TicketStatus.values.firstWhere(
          (ticketStatus) => ticketStatus.name == json['ticket_status'],
          orElse: () => TicketStatus.close),
      total: json['total'] * 1.0,
      ticketProducts: ticketProducts,
    );
  }

  final Account account;
  final TicketStatus ticketStatus;
  final double total;
  final List<TicketProduct> ticketProducts;

  @override
  String toString() => '$runtimeType => ${jsonEncode(toJson())}';
}
