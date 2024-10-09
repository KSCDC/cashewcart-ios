import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cashew_cart/core/colors.dart';
import 'package:cashew_cart/main.dart';
import 'package:cashew_cart/presentation/home/home_screen.dart';
import 'package:cashew_cart/presentation/main_page/widgets/custom_bottom_navbar_item.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';

ValueNotifier<int> bottomNavbarIndexNotifier = ValueNotifier(0);
ValueNotifier<int> cartCountNotifier = ValueNotifier(0);

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("value ${bottomNavbarIndexNotifier.value}");
    return ValueListenableBuilder(
        valueListenable: bottomNavbarIndexNotifier,
        builder: (BuildContext context, int newIndex, _) {
          // int previousPageIndex = previousPageIndexes.last;
          return Container(
            height: 70,
            // decoration: BoxDecoration(
            //   color: kMainThemeColor,
            //   borderRadius: BorderRadius.only(
            //     topLeft: Radius.circular(25),
            //     topRight: Radius.circular(25),
            //     bottomLeft: Radius.circular(25),
            //     bottomRight: Radius.circular(25),
            //   ),
            // ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomBottomNavbarItem(
                    iconWidget: SvgPicture.asset(
                      "lib/core/assets/images/home_icon.svg",
                      color: bottomNavbarIndexNotifier.value == 0 ? kMainThemeColor : Colors.black,
                    ),
                    label: "Home",
                    index: 0,
                    color: bottomNavbarIndexNotifier.value == 0 ? kMainThemeColor : Colors.black,
                  ),
                  CustomBottomNavbarItem(
                    iconWidget: Icon(
                      Icons.category_outlined,
                      color: bottomNavbarIndexNotifier.value == 1 ? kMainThemeColor : Colors.black,
                    ),
                    label: "Categories",
                    index: 1,
                    color: bottomNavbarIndexNotifier.value == 1 ? kMainThemeColor : Colors.black,
                  ),
                  Stack(
                    children: [
                      CustomBottomNavbarItem(
                        iconWidget: Icon(
                          Icons.shopping_cart_outlined,
                          color: bottomNavbarIndexNotifier.value == 2 ? kMainThemeColor : Colors.black,
                        ),
                        label: "Cart",
                        index: 2,
                        color: bottomNavbarIndexNotifier.value == 2 ? kMainThemeColor : Colors.black,
                      ),
                      Positioned(
                        top: 7,
                        right: 3,
                        child: CircleAvatar(
                          radius: 7,
                          child: ValueListenableBuilder(
                              valueListenable: cartCountNotifier,
                              builder: (context, value, _) {
                                return CustomTextWidget(
                                  text: value.toString(),
                                  fontSize: 10,
                                  fontColor: kMainThemeColor,
                                  fontweight: FontWeight.w600,
                                );
                              }),
                        ),
                      )
                    ],
                  ),
                  CustomBottomNavbarItem(
                    iconWidget: Icon(
                      Icons.person_outlined,
                      color: bottomNavbarIndexNotifier.value == 3 ? kMainThemeColor : Colors.black,
                    ),
                    label: "Account",
                    index: 3,
                    color: bottomNavbarIndexNotifier.value == 3 ? kMainThemeColor : Colors.black,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
