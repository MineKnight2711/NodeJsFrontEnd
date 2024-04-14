import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quanlyquantrasua/controller/main_controller.dart';

import 'package:quanlyquantrasua/screens/home/home_screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MainController.initializeControllers();
  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        // localizationsDelegates: context.localizationDelegates,
        // supportedLocales: context.supportedLocales,
        // locale: context.locale,
        initialRoute: 'introduction_screen',
        debugShowCheckedModeBanner: false,
        routes: {
          'introduction_screen': (context) => HomeScreenView(),
        },
      ),
    ),
  );
}
