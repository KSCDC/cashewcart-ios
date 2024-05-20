import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
import 'package:internship_sample/presentation/splash/splash_screen.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/services/services.dart';

class MainPageScreen extends StatelessWidget {
  MainPageScreen({Key? key}) : super(key: key);

  // final pages = [
  //   HomeScreen(),
  //   CategoriesScreen(),
  //   CartScreen(),
  //   AccountScreen(),
  //   // ShopScreen(),
  //   // ProductListingScreen(),
  //   MyOrdersScreen(),
  //   // ProductListingScreen(),
  //   // ProductListingScreen(),
  //   // TrendingModelProductListingScreen(),
  // ];
  AppController controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          activeColor: kMainThemeColor,
          inactiveColor: Colors.grey,
          height: 50.w,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.category_outlined,
              ),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                  ),
                  Positioned(
                    top: 0,
                    right: 3,
                    child: CircleAvatar(
                      radius: 7,
                      child: ValueListenableBuilder(
                          valueListenable: cartCountNotifier,
                          builder: (context, value, _) {
                            return CustomTextWidget(
                              text: value.toString(),
                              fontSize: 10,
                              fontColor: Colors.black,
                              fontweight: FontWeight.w600,
                            );
                          }),
                    ),
                  )
                ],
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
              ),
              label: 'Account',
            ),
          ],
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: (context) {
                  if (controller.circleAvatarProductsList.isEmpty) {
                    controller.getCircleAvatarProductList();
                  }

                  if (!controller.isAlreadyLoadedAllProducts) {
                    //log("getting all products");
                    controller.getAllProducts();
                  }
                  if (!controller.isAlreadyLoadedBestsellers) {
                    controller.getBestSellerProducts();
                  }
                  if (!controller.isAlreadyLoadedSponserd) {
                    controller.getSponserdProducts();
                  }
                  if (!controller.isAlreadyLoadedTrending) {
                    controller.getTrendingProducts();
                  }

                  controller.getCartList();

                  return CupertinoPageScaffold(child: HomeScreen());
                },
              );
            case 1:
              return CupertinoTabView(
                builder: (context) {
                  if (controller.circleAvatarProductsList.isEmpty) {
                    controller.getCircleAvatarProductList();
                  }

                  controller.getCartList();
                  return CupertinoPageScaffold(child: CategoriesScreen());
                },
              );
            case 2:
              return CupertinoTabView(
                builder: (context) {
                  if (SplashScreen.email != null) {
                    controller.getCartList();
                  } else {
                    Services().showLoginAlert(context, "Please login to access Cart");
                  }

                  return CupertinoPageScaffold(child: CartScreen());
                },
              );
            case 3:
              return CupertinoTabView(
                builder: (context) {
                  // controller.getProfileDetails();
                  log("Emaill :${SplashScreen.email}");
                  if (SplashScreen.email != null) {
                    controller.getProfileDetails();
                  } else {
                    Services().showLoginAlert(context, "Please login to access Account");
                  }

                  return CupertinoPageScaffold(child: AccountScreen());
                },
              );
            default:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(child: HomeScreen());
                },
              );
          }
        },
      ),
    );
  }
}
