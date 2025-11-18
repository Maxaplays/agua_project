import 'package:agua_project/pages/add_activity/add_activity.dart';
import 'package:agua_project/pages/home/home_page.dart';
import 'package:agua_project/services/water_items_service.dart';
import 'package:agua_project/theme/colors.dart';
import 'package:flutter/material.dart';

class UI extends StatefulWidget {
  static const routeName = '/UI';
  const UI({super.key});
  @override
  State<UI> createState() => _UIState();
}

class _UIState extends State<UI> {
  final WaterItemsService service = WaterItemsService();
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
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
      body: SafeArea(child: Home(service: service)),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddActivity(service: service),
            ),
          ),
        },
      ),
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
