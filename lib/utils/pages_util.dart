import 'package:agua_project/pages/home/home_page.dart';
import 'package:agua_project/services/water_items_service.dart';
import 'package:flutter/widgets.dart';

List<Widget> generatePages(WaterItemsService serviceHome) {
  return [
    Home(service: serviceHome),
    Center(child: Text("Graphs")),
    Center(child: Text("Learn")),
  ];
}
