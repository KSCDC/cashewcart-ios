import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/controllers/cart_controller.dart';
import 'package:internship_sample/controllers/profile_controller.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/main.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomBottomNavbarItem extends StatelessWidget {
  CustomBottomNavbarItem({super.key, required this.iconWidget, required this.label, required this.index, required this.color});
  final Widget iconWidget;
  final String label;
  final int index;
  final Color color;

  AppController controller = Get.put(AppController());
  CartController cartController = Get.put(CartController());
  ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // previousPageIndex = index;
        SharedPreferences sharedPref = await SharedPreferences.getInstance();
        String? email = sharedPref.getString(EMAIL);
        String? password = sharedPref.getString(ENCRYPTEDPASSWORD);
        //fetching items in cart when cart is selected from bottom navbar
        if (index == 0 || index == 1) {
          bottomNavbarIndexNotifier.value = index;
          // controller.haveSearchResult.value = false;
          if (controller.circleAvatarProductsList.isEmpty) {
            controller.getCircleAvatarProductList();
          }

          if (!controller.isAlreadyLoadedAllProducts.value) {
            //log("getting all products");
            controller.getAllProducts();
          }
          if (!controller.isAlreadyLoadedBestsellers) {
            controller.getBestSellerProducts();
          }
          if (!controller.isAlreadyLoadedSponserd) {
            controller.getSponserdProducts();
          }

          // cartController.getCartList();
        }
        if (index == 2) {
          //log("index =2");
          if (email != null && password != null) {
            //log("setting index");
            bottomNavbarIndexNotifier.value = index;
            // if (controller.cartProducts.value.count != 0) {
            // cartController.getCartList();
            // }
          } else {
            Services().showLoginAlert(context, "Please login to access Cart");
          }
        }

        // fetching of account details
        if (index == 3) {
          if (email != null && password != null) {
            bottomNavbarIndexNotifier.value = index;
            profileController.getProfileDetails();
          } else {
            Services().showLoginAlert(context, "Please login to access Account");
          }
        }
        if (bottomNavbarIndexNotifier.value < 4) {
          // bottomNavbarIndexNotifier.value = index;
          // previousPageIndexes.add(index);
        } else {
          print("Adding");
          // previousPageIndexes.add(bottomNavbarIndexNotifier.value);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconWidget,
          CustomTextWidget(
            text: label,
            fontColor: color,
            fontFamily: "",
            fontweight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
