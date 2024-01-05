import 'package:flutter/material.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/presentation/home/home_screen.dart';
import 'package:internship_sample/presentation/cart/cart_screen.dart';
import 'package:internship_sample/presentation/shop/shop_screen.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar_item.dart';
import 'package:internship_sample/presentation/search/search_screen.dart';
import 'package:internship_sample/presentation/settings/settings_screen.dart';
import 'package:internship_sample/presentation/widgets/main_appbar.dart';
import 'package:internship_sample/presentation/wishlist/wishlist_screen.dart';

class MainPageScreen extends StatelessWidget {
  MainPageScreen({Key? key}) : super(key: key);

  final pages = [
    HomeScreen(),
    WishlistScreen(),
    CartScreen(),
    SearchScreen(),
    SettingsScreen(),
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
      floatingActionButton: ValueListenableBuilder(
          valueListenable: bottomNavbarIndexNotifier,
          builder: (BuildContext context, int value, _) {
            return FloatingActionButton(
              shape: CircleBorder(),
              onPressed: () {
                bottomNavbarIndexNotifier.value = 2;
              },
              backgroundColor: bottomNavbarIndexNotifier.value == 2
                  ? Color(0xffEB3030)
                  : Colors.white,
              foregroundColor: bottomNavbarIndexNotifier.value == 2
                  ? Colors.white
                  : Colors.black,
              child: Icon(Icons.shopping_cart_outlined),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
