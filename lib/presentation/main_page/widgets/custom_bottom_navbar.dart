import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar_item.dart';

ValueNotifier<int> bottomNavbarIndexNotifier = ValueNotifier(0);

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("value ${bottomNavbarIndexNotifier.value}");
    return ValueListenableBuilder(
        valueListenable: bottomNavbarIndexNotifier,
        builder: (BuildContext context, int newIndex, _) {
          return Container(
            color: Colors.white,
            height: 70,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomBottomNavbarItem(
                    icon: Icon(Icons.home),
                    label: "Home",
                    index: 0,
                    color: bottomNavbarIndexNotifier.value == 0 ? Color(0xffEB3030) : Colors.black,
                  ),
                  Spacer(),
                  CustomBottomNavbarItem(
                    icon: Icon(Icons.favorite_border),
                    label: "Wishlist",
                    index: 1,
                    color: bottomNavbarIndexNotifier.value == 1 ? Color(0xffEB3030) : Colors.black,
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  CustomBottomNavbarItem(
                    icon: Icon(Icons.search),
                    label: "Search",
                    index: 3,
                    color: bottomNavbarIndexNotifier.value == 3 ? Color(0xffEB3030) : Colors.black,
                  ),
                  Spacer(),
                  CustomBottomNavbarItem(
                    icon: Icon(Icons.settings),
                    label: "Setting",
                    index: 4,
                    color: bottomNavbarIndexNotifier.value == 4 ? Color(0xffEB3030) : Colors.black,
                  ),
                ],
              ),
            ),
          );
        });
  }
}



// BottomNavigationBar(
//             currentIndex: bottomNavbarIndexNotifier.value,
//             onTap: (index) {
//               bottomNavbarIndexNotifier.value = index;
//             },
//             type: BottomNavigationBarType.fixed,
//             backgroundColor: Colors.white,
//             selectedItemColor: Color(0xffEB3030),
//             unselectedItemColor: Colors.black54,
//             items: const [
//               BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.favorite_border), label: "Wishlist"),
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.shopping_cart_outlined), label: "Kart"),
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.search), label: "Search"),
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.settings), label: "Setting"),
//             ],
//           );