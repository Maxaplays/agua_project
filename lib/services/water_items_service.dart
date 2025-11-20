import 'package:agua_project/models/water_item.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class WaterItemsService {
  List<WaterItem> waterItems = [
    WaterItem(
      name: "Shower",
      count: 1,
      icon: Icons.shower,
      value: 150,
      color: Colors.lightBlue,
    ),
    WaterItem(
      name: "Clean Hands",
      count: 1,
      icon: Icons.clean_hands_rounded,
      value: 50,
      color: Colors.blue.shade400,
    ),
    WaterItem(
      name: "Drink Water",
      count: 1,
      icon: Icons.local_drink_rounded,
      value: 60,
      color: Colors.blue.shade700,
    ),
    // WaterItem(
    //   name: "Wash Dishes",
    //   count: 1,
    //   icon: Icons.waves_sharp,
    //   value: 200,
    //   color: Colors.blue.shade300,
    // ),
    // WaterItem(
    //   name: "Bathroom",
    //   count: 1,
    //   icon: Icons.wc_sharp,
    //   value: 110,
    //   color: Colors.blue.shade200,
    // ),
    // WaterItem(
    //   name: "Wash Clothes",
    //   count: 1,
    //   icon: Icons.local_laundry_service_rounded,
    //   value: 300,
    // ),
  ];

  late final BehaviorSubject<List<WaterItem>> _waterItemsController;

  Stream<List<WaterItem>> get waterItems$ => _waterItemsController.stream;

  void setState(List<WaterItem> data) {
    _waterItemsController.add(data);
  }

  List<WaterItem> getState() {
    return _waterItemsController.value;
  }

  void dispose() {
    _waterItemsController.close();
  }

  WaterItemsService() {
    _waterItemsController = BehaviorSubject<List<WaterItem>>.seeded(waterItems);
  }
}
