import 'dart:convert';

import 'package:agua_project/models/activity.dart';
import 'package:agua_project/models/water_item.dart';
import 'package:agua_project/pages/add_activity/add_activity.dart';
import 'package:agua_project/pages/home/home_page.dart';
import 'package:agua_project/pages/graph/graph_page.dart';
import 'package:agua_project/pages/learn/learn_page.dart';

import 'package:agua_project/services/activities_service.dart';
import 'package:agua_project/services/water_items_service.dart';
import 'package:agua_project/theme/colors.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UI extends StatefulWidget {
  static const routeName = '/UI';
  const UI({super.key});
  @override
  State<UI> createState() => _UIState();
}

class _UIState extends State<UI> with SingleTickerProviderStateMixin {
  final WaterItemsService serviceWaterItems = WaterItemsService();
  final ActivitiesService serviceActivites = ActivitiesService();

  late final AppLifecycleListener _listener;
  late SharedPreferences prefInit;

  late List<Widget> _pages;
  int _selectedIndex = 0;

  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    getDataFromCache();
    _listener = AppLifecycleListener(onStateChange: _handleStateChange);

    _pages = [Home(serviceWaterItems: serviceWaterItems), Graph(), Learn()];

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(
      curve: Curves.easeInOut,
      parent: _animationController,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
  }

  @override
  void dispose() {
    super.dispose();
    serviceWaterItems.dispose();
    _listener.dispose();
  }

  void _handleStateChange(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      saveDataAtCache();
    }
  }

  void saveDataAtCache() {
    prefInit.setStringList(
      "waterItems",
      List.from(
        serviceWaterItems
            .getState()
            .map((item) => jsonEncode(item.toJson()))
            .toList(),
      ),
    );
    prefInit.setStringList(
      "activities",
      List.from(
        serviceActivites
            .getState()
            .map((item) => jsonEncode(item.toJson()))
            .toList(),
      ),
    );
  }

  Future<void> getDataFromCache() async {
    List<String> itemsWaterJson = [];
    List<String> activitiesJson = [];
    await SharedPreferences.getInstance().then(
      (values) => {
        prefInit = values,
        itemsWaterJson = (values.getStringList("waterItems") ?? []),
        activitiesJson = (values.getStringList("activities") ?? []),
        if (itemsWaterJson.isNotEmpty)
          {
            serviceWaterItems.setState(
              itemsWaterJson
                  .map((item) => WaterItem.fromJson(jsonDecode(item)))
                  .toList(),
            ),
          },

        if (activitiesJson.isNotEmpty)
          {
            serviceActivites.setState(
              activitiesJson
                  .map((item) => Activity.fromJson(jsonDecode(item)))
                  .toList(),
            ),
          },
      },
    );
  }

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget buildIcon(IconData iconData, String text, int index) {
    final bool isSelected = _selectedIndex == index;
    return SizedBox(
      width: double.infinity,
      height: kBottomNavigationBarHeight,

      child: Material(
        color: isSelected ? AppColors.primaryMainDarker : AppColors.primaryMain,

        child: InkWell(
          onTap: () => _selectPage(index),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(iconData, color: Colors.white),
              Text(text, style: TextStyle(fontSize: 12, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_selectedIndex]),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionBubble(
              backGroundColor: Theme.of(context).primaryColor,
              items: [
                Bubble(
                  title: "Add activity",
                  iconColor: Colors.white,
                  bubbleColor: Theme.of(context).primaryColor,
                  icon: Icons.add,
                  titleStyle: TextStyle(fontSize: 16, color: Colors.white),
                  onPress: () {
                    _animationController.reverse();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddActivity(
                          serviceWaterItems: serviceWaterItems,
                          serviceActivites: serviceActivites,
                        ),
                      ),
                    );
                  },
                ),
                Bubble(
                  title: "Add with camera",
                  iconColor: Colors.white,
                  bubbleColor: Theme.of(context).primaryColor,
                  icon: Icons.home,
                  titleStyle: TextStyle(fontSize: 16, color: Colors.white),
                  onPress: () {
                    _animationController.reverse();
                  },
                ),
                Bubble(
                  title: "Add Routine",
                  iconColor: Colors.white,
                  bubbleColor: Theme.of(context).primaryColor,
                  icon: Icons.home,
                  titleStyle: TextStyle(fontSize: 16, color: Colors.white),
                  onPress: () {
                    _animationController.reverse();
                  },
                ),
              ],
              animation: _animation,
              onPress: () => {
                if (_animationController.isCompleted)
                  {_animationController.reverse()}
                else
                  {_animationController.forward()},
              },
              iconColor: Colors.white,
              iconData: Icons.more_vert_outlined,
            )
          : Container(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedFontSize: 0,
        onTap: _selectPage,
        selectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: buildIcon(Icons.home_rounded, "Home", 0),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: buildIcon(Icons.auto_graph, "Graphs", 1),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: buildIcon(Icons.menu_book, "Learn", 2),
            label: "",
          ),
        ],
      ),
    );
  }
}
