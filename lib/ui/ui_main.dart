import 'package:agua_project/pages/home/home_page.dart';
import 'package:flutter/material.dart';

class Ui extends StatefulWidget {
  static const routeName = '/UI';

  const Ui({super.key});
  @override
  State<Ui> createState() => _UiState();
}

class _UiState extends State<Ui> {
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text("Yaku"),
      ),
      body: Home(),
      bottomNavigationBar: BottomNavigationBar(
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
