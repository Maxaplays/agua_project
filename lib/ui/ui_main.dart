import 'package:agua_project/pages/add_activity/add_activity.dart';
import 'package:agua_project/pages/home/home_page.dart';
import 'package:agua_project/services/water_items_service.dart';
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

  Widget buildIcon(IconData iconData, String text, int index) => SizedBox(
    width: double.infinity,
    height: kBottomNavigationBarHeight,
    child: Material(
      color: Theme.of(context).primaryColor,
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(iconData, color: Colors.white),
            Text(text, style: TextStyle(fontSize: 12, color: Colors.white)),
          ],
        ),
        onTap: () => _selectPage(index),
      ),
    ),
  );

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
            icon: buildIcon(Icons.home_rounded, "Inicio", 0),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: buildIcon(Icons.article_rounded, "Mes", 1),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: buildIcon(Icons.app_shortcut_sharp, "Mas", 2),
            label: "",
          ),
        ],
      ),
    );
  }
}
