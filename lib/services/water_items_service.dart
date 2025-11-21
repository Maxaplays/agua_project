import 'package:agua_project/models/water_item.dart';
import 'package:rxdart/rxdart.dart';

class WaterItemsService {
  List<WaterItem> waterItems = [];

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
