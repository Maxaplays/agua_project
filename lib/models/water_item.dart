import 'package:flutter/material.dart';

class WaterItem {
  final String name;
  final IconData icon;
  final int value;
  final Color color;

  WaterItem({
    required this.name,
    required this.icon,
    required this.value,
    this.color = Colors.blue,
  });
}
