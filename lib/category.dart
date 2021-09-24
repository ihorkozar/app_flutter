import 'package:app_flutter/unit.dart';
import 'package:flutter/material.dart';

class Category {
  final String name;
  final ColorSwatch color;
  final IconData iconLocation;
  final List<Unit> units;

  const Category({
    required this.name,
    required this.color,
    required this.iconLocation,
    required this.units
  });
}
