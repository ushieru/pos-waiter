import 'dart:convert';

import 'package:total_pos_waiter/models/category.dart';
import 'package:total_pos_waiter/models/model.dart';

class Product extends Model {
  Product({
    required super.id,
    required super.createAt,
    required super.updateAt,
    required super.deleteAt,
    required this.name,
    required this.description,
    required this.price,
    this.categories,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final model = Model.fromJson(json);
    final categories = (json['categories'] as List<dynamic>?)
        ?.map<Category>((jsonCategory) => Category.fromJson(jsonCategory))
        .toList();
    return Product(
      id: model.id,
      name: json['name'],
      description: json['description'],
      price: json['price'] * 1.0,
      categories: categories,
      createAt: model.createAt,
      updateAt: model.updateAt,
      deleteAt: model.deleteAt,
    );
  }

  final String name;
  final String description;
  final double price;
  final List<Category>? categories;

  @override
  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'price': price,
        'categories': categories?.map((c) => c.toJson()).toList(),
        ...super.toJson()
      };

  @override
  String toString() => '$runtimeType => ${jsonEncode(toJson())}';
}
