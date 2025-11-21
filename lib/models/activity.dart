class Activity {
  String name;
  int consumption;
  Activity({required this.name, required this.consumption});
  Map<String, dynamic> toJson() => {'name': name, 'consumption': consumption};
  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(name: json["name"], consumption: json["consumption"]);
  }
}
