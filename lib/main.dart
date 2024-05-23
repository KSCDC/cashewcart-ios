import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/presentation/authentication/signin_screen.dart';
import 'package:internship_sample/presentation/authentication/signup_screen.dart';
import 'package:internship_sample/presentation/main_page/main_page_screen.dart';
import 'package:internship_sample/presentation/policies_and_T&C/cancellation_policy_screen.dart';
import 'package:internship_sample/presentation/policies_and_T&C/privacy_policy_screen.dart';
import 'package:internship_sample/presentation/policies_and_T&C/shipping_policy_screen.dart';
import 'package:internship_sample/presentation/policies_and_T&C/terms_and_conditions_screen.dart';
import 'package:internship_sample/presentation/splash/splash_screen.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

// List<int> previousPageIndexes = [0];
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();

  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
    if (notificationResponse.payload != null) {
      final filePath = notificationResponse.payload;
      // Open the file using the file path
      await openFile(filePath);
    }
  });

  runApp(MyApp());
}

Future<void> openFile(String? filePath) async {
  if (filePath != null) {
    final file = File(filePath);
    await OpenFile.open(file.path);
  }
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
