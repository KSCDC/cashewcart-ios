import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/presentation/account/account_screen.dart';
import 'package:internship_sample/presentation/cart/cart_screen.dart';
import 'package:internship_sample/presentation/home/home_screen.dart';
import 'package:internship_sample/presentation/my_orders/my_orders_screen.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/categories/categories_screen.dart';
import 'package:internship_sample/presentation/product_list/product_listing_screen.dart';
import 'package:internship_sample/presentation/product_list/trending_model_product_listing_screen.dart';
import 'package:internship_sample/presentation/shop/shop_screen.dart';
import 'package:internship_sample/presentation/side_bar/side_bar.dart';

class MainPageScreen extends StatelessWidget {
  MainPageScreen({Key? key}) : super(key: key);

  final pages = [
    HomeScreen(),
    CategoriesScreen(),
    CartScreen(),
    AccountScreen(),
    ShopScreen(),
    ProductListingScreen(),
    MyOrdersScreen(),
    ProductListingScreen(),
    ProductListingScreen(),
    TrendingModelProductListingScreen(),
  ];
  AppController controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      // drawer: SideBar(),
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
