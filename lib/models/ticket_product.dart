import 'dart:convert';

import 'package:total_pos_waiter/models/model.dart';
import 'package:total_pos_waiter/models/product.dart';

class TicketProduct extends Model {
  TicketProduct({
    required super.id,
    required super.createAt,
    required super.updateAt,
    required super.deleteAt,
    required this.product,
    required this.quantity,
  });

  factory TicketProduct.fromJson(Map<String, dynamic> json) {
    final model = Model.fromJson(json);
    return TicketProduct(
      id: model.id,
      createAt: model.createAt,
      updateAt: model.updateAt,
      deleteAt: model.deleteAt,
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }

  final Product product;
  final int quantity;

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'product': product,
      'quantity': quantity,
    };
  }

  @override
  String toString() => '$runtimeType => ${jsonEncode(toJson())}';
}
