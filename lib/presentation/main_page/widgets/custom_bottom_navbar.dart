import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/main.dart';
import 'package:internship_sample/presentation/home/home_screen.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar_item.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

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
          int previousPageIndex = previousPageIndexes.last;
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: kMainThemeColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomBottomNavbarItem(
                      iconWidget: SvgPicture.asset(
                        "lib/core/assets/images/home_icon.svg",
                        color: bottomNavbarIndexNotifier.value == 0 || previousPageIndex == 0 ? Colors.white : Colors.white.withOpacity(0.5),
                      ),
                      label: "Home",
                      index: 0,
                      color: bottomNavbarIndexNotifier.value == 0 || previousPageIndex == 0 ? Colors.white : Colors.white.withOpacity(0.5),
                    ),
                    CustomBottomNavbarItem(
                      iconWidget: Icon(Icons.category_outlined),
                      label: "Categories",
                      index: 1,
                      color: bottomNavbarIndexNotifier.value == 1 || previousPageIndex == 1 ? Colors.white : Colors.white.withOpacity(0.5),
                    ),
                    Stack(
                      children: [
                        CustomBottomNavbarItem(
                          iconWidget: Icon(Icons.shopping_cart_outlined),
                          label: "Cart",
                          index: 2,
                          color: bottomNavbarIndexNotifier.value == 2 || previousPageIndex == 2 ? Colors.white : Colors.white.withOpacity(0.5),
                        ),
                        Positioned(
                          top: 7,
                          right: 10,
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
                      iconWidget: Icon(Icons.person_outlined),
                      label: "Account",
                      index: 3,
                      color: bottomNavbarIndexNotifier.value == 3 || previousPageIndex == 3 ? Colors.white : Colors.white.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
