import 'package:flutter/material.dart' show Colors, MaterialColor;

enum Color { indigo, red, purple, green }

MaterialColor colorsEnumToColor(Color color) {
  switch (color) {
    case Color.indigo:
      return Colors.indigo;
    case Color.red:
      return Colors.red;
    case Color.purple:
      return Colors.purple;
    case Color.green:
      return Colors.green;
    default:
      return Colors.indigo;
  }
}

Color colorToMaterialColor(MaterialColor color) {
  switch (color) {
    case Colors.indigo:
      return Color.indigo;
    case Colors.red:
      return Color.red;
    case Colors.purple:
      return Color.purple;
    case Colors.green:
      return Color.green;
    default:
      return Color.indigo;
  }
}

Color stringToColor(String color) => Color.values
    .firstWhere((ce) => ce.name == color, orElse: () => Color.indigo);
