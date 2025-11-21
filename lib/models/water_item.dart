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

  Map<String, dynamic> toJson() => {
    'name': name,
    'count': count,
    'value': value,
    'color': color.toARGB32(),
    'icon': {'code_point': icon.codePoint, 'font_family': icon.fontFamily},
  };
  factory WaterItem.fromJson(Map<String, dynamic> json) {
    return WaterItem(
      name: json["name"],
      count: json["count"],
      value: json["value"],
      color: Color(json["color"]),
      icon: IconData(
        json['icon']["code_point"],
        fontFamily: json['icon']["font_family"],
      ),
    );
  }
}
