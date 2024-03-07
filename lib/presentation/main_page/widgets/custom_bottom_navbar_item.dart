import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/main.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class CustomBottomNavbarItem extends StatelessWidget {
  CustomBottomNavbarItem({super.key, required this.iconWidget, required this.label, required this.index, required this.color});
  final Widget iconWidget;
  final String label;
  final int index;
  final Color color;

  AppController controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          color: color,
          onPressed: () {
            // previousPageIndex = index;

            //fetching items in cart when cart is selected from bottom navbar
            if (index == 0 || index == 1) {
              controller.haveSearchResult.value = false;
            }
            if (index == 2) {
              controller.getCartList();
            }

            // fetching of account details
            if (index == 3) {
              controller.getProfileDetails();
            }
            if (bottomNavbarIndexNotifier.value < 4) {
              previousPageIndexes.add(index);
            } else {
              print("Adding");
              previousPageIndexes.add(bottomNavbarIndexNotifier.value);
            }

            bottomNavbarIndexNotifier.value = index;
          },
          icon: iconWidget,
        ),
        CustomTextWidget(
          text: label,
          fontColor: color,
          fontFamily: "",
          fontweight: FontWeight.w600,
        ),
      ],
    );
  }
}
