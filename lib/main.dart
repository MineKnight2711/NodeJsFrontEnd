import 'package:flutter/material.dart';
import 'package:quanlyquantrasua/controller/main_controller.dart';

import 'package:quanlyquantrasua/screens/home/home_screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MainController.initializeControllers();
  runApp(
    MaterialApp(
      initialRoute: 'introduction_screen',
      debugShowCheckedModeBanner: false,
      routes: {
        'introduction_screen': (context) => HomeScreenView(),
      },
    ),
  );
}
