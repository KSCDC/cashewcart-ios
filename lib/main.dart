import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:internship_sample/presentation/authentication/signin_screen.dart';
import 'package:internship_sample/presentation/authentication/signup_screen.dart';
import 'package:internship_sample/presentation/main_page/main_page_screen.dart';
import 'package:internship_sample/presentation/splash/splash_screen.dart';

List<int> previousPageIndexes = [0];
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffF83758)),
        useMaterial3: true,
      ),
      // home: const SplashScreen(),
      home: SignInScreen(),
      // home: MainPageScreen(),
    );
  }
}
