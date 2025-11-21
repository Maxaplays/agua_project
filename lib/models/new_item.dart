import 'package:agua_project/models/activity.dart';
import 'package:flutter/widgets.dart';

class NewItem {
  Activity activity;
  int time;
  IconData icon;
  NewItem({required this.activity, required this.time, required this.icon});
  Map<String, dynamic> toJson() => {
    'activity': activity.toJson(),
    'time': time,
    'icon': {'code_point': icon.codePoint, 'font_family': icon.fontFamily},
  };
  factory NewItem.fromJson(Map<String, dynamic> json) {
    return NewItem(
      activity: Activity.fromJson(json["activity"]),
      time: int.parse(json["time"]),
      icon: IconData(
        json['icon']["code_point"],
        fontFamily: json['icon']["font_family"],
      ),
    );
  }
}
