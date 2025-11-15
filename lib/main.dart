import 'package:agua_project/pages/add_activity/add_activity.dart';
import 'package:agua_project/ui/ui_main.dart';
import 'package:agua_project/theme/colors.dart';
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
      theme: ThemeData(
        primaryColor: AppColors.primaryMain,
        fontFamily: 'Lato',
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color.fromRGBO(13, 71, 161, 1),
          selectionColor: Color.fromARGB(255, 128, 124, 124),
          selectionHandleColor: Color.fromRGBO(13, 71, 161, 1),
        ),
      ),
      routes: {
        '/': (ctx) => UI(),
        AddActivity.routeName: (ctx) => AddActivity(),
      },
    );
  }
}
