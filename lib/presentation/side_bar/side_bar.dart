import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/main.dart';
import 'package:internship_sample/presentation/about/about_screen.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/profile/profile_screen.dart';
import 'package:internship_sample/presentation/side_bar/widgets/expandable_side_bar_item.dart';
import 'package:internship_sample/presentation/side_bar/widgets/side_bar_item_tile.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SideBar extends StatelessWidget {
  SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    // bottomNavbarIndexNotifier.value = 0;
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ),
              ),
              child: CircleAvatar(
                radius: 60,
                child: Image.asset("lib/core/assets/images/avatar.jpeg"),
              ),
            ),
            SizedBox(height: 20),
            Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
            GestureDetector(
              onTap: () async {
                SharedPreferences sharedPref = await SharedPreferences.getInstance();
                String? email = sharedPref.getString(EMAIL);
                String? password = sharedPref.getString(ENCRYPTEDPASSWORD);

                if (email != null && password != null) {
                  previousPageIndexes.add(3);
                  bottomNavbarIndexNotifier.value = 6;
                } else {
                  Services().showLoginAlert(context, "Please login to see your orders");
                }
              },
              child: SideBarItemTile(
                icon: Icons.local_shipping_outlined,
                label: "My Orders",
              ),
            ),
            ExpandableProductsSideBarItem(),
            GestureDetector(
              onTap: () {
                Get.to(() => AboutUsScreen());
              },
              child: SideBarItemTile(
                icon: Icons.info_outline,
                label: "About KSCDC",
              ),
            ),
            GestureDetector(
              onTap: () async {
                final url = Uri.parse("https://www.cashewcart.com");
                if (await canLaunchUrl(url)) {
                  await launchUrl(
                    url,
                    mode: LaunchMode.externalApplication,
                  );
                } else {
                  throw 'Could not launch "https://www.cashewcart.com/"';
                }
              },
              child: SideBarItemTile(
                icon: Icons.language,
                label: "Visit our website",
              ),
            ),
            SideBarItemTile(
              icon: Icons.star_rate_outlined,
              label: "Rate Us",
            ),
            SideBarItemTile(
              icon: Icons.share,
              label: "Share App",
            ),
          ],
        ),
      ),
    );
  }
}
