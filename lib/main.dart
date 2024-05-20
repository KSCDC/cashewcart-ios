import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/presentation/authentication/signin_screen.dart';
import 'package:internship_sample/presentation/authentication/signup_screen.dart';
import 'package:internship_sample/presentation/main_page/main_page_screen.dart';
import 'package:internship_sample/presentation/splash/splash_screen.dart';

// List<int> previousPageIndexes = [0];
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, _) {
          return GetMaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: kMainThemeColor),
              useMaterial3: true,
            ),
            home: SplashScreen(),
          );
        });
  }
}
