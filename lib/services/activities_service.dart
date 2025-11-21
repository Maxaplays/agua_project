import 'package:agua_project/models/activity.dart';
import 'package:rxdart/rxdart.dart';

class ActivitiesService {
  final List<Activity> activities = [];

  late final BehaviorSubject<List<Activity>> _activitiesController;

  Stream<List<Activity>> get activities$ => _activitiesController.stream;

  void setState(List<Activity> data) {
    _activitiesController.add(data);
  }

  List<Activity> getState() {
    return _activitiesController.value;
  }

  void dispose() {
    _activitiesController.close();
  }

  ActivitiesService() {
    _activitiesController = BehaviorSubject<List<Activity>>.seeded(activities);
  }
}
