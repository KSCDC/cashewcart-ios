import 'package:flutter/material.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/presentation/account/account_screen.dart';
import 'package:internship_sample/presentation/home/home_screen.dart';
import 'package:internship_sample/presentation/my_orders/my_orders_screen.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/categories/categories_screen.dart';

class MainPageScreen extends StatelessWidget {
  MainPageScreen({Key? key}) : super(key: key);

  final pages = [
    HomeScreen(),
    CategoriesScreen(),
    MyOrdersScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: bottomNavbarIndexNotifier,
            builder: (BuildContext context, int newIndex, _) {
              return pages[newIndex];
            }),
      ),
      bottomNavigationBar: BottomNavigationWidget(),
      //
    );
  }
}
