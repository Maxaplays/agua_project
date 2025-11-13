import 'package:agua_project/ui/ui_main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'APP',
      themeMode: ThemeMode.system,
      theme: ThemeData(primaryColor: Colors.blue[900], fontFamily: 'Lato'),
      routes: {'/': (ctx) => Ui()},
    );
  }
}
