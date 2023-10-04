import 'dart:convert';

import 'package:total_pos_waiter/models/model.dart';

class Category extends Model {
  Category({
    required super.id,
    required super.createAt,
    required super.updateAt,
    required super.deleteAt,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    final model = Model.fromJson(json);
    return Category(
      id: model.id,
      name: json['name'],
      createAt: model.createAt,
      updateAt: model.updateAt,
      deleteAt: model.deleteAt,
    );
  }

  final String name;

  @override
  Map<String, dynamic> toJson() => {'name': name, ...super.toJson()};

  @override
  String toString() => '$runtimeType => ${jsonEncode(toJson())}';
}
