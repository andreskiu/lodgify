import 'package:flutter/material.dart';

import 'config/injectable/injectable.dart';
import 'presentation/palette/colors.dart';
import 'presentation/tasks/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initConfig();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lodgify',
      theme: ThemeData(
        primaryColor: ColorPalette.green,
        appBarTheme: const AppBarTheme(
          color: ColorPalette.green,
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: ColorPalette.green,
        ),
      ),
      home: const MyHomePage(title: 'TO-DO List'),
    );
  }
}
