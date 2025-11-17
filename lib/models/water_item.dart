import 'package:flutter/material.dart';

class WaterItem {
  String name;
  int count;
  IconData icon;
  int value;
  Color color;

  WaterItem({
    required this.name,
    required this.count,
    required this.icon,
    required this.value,
    this.color = Colors.blue,
  });
}
