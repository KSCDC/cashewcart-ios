import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/main.dart';
import 'package:internship_sample/presentation/about/about_screen.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/my_orders/my_orders_screen.dart';
import 'package:internship_sample/presentation/policies_and_T&C/cancellation_policy_screen.dart';
import 'package:internship_sample/presentation/policies_and_T&C/privacy_policy_screen.dart';
import 'package:internship_sample/presentation/policies_and_T&C/shipping_policy_screen.dart';
import 'package:internship_sample/presentation/policies_and_T&C/terms_and_conditions_screen.dart';
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white.withOpacity(0),
                  child: Icon(
                    Icons.person,
                    size: 120,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Divider(
                thickness: 0.5,
                color: Colors.grey,
                height: 0,
              ),
              InkWell(
                onTap: () async {
                  SharedPreferences sharedPref = await SharedPreferences.getInstance();
                  String? email = sharedPref.getString(EMAIL);
                  String? password = sharedPref.getString(ENCRYPTEDPASSWORD);

                  if (email != null && password != null) {
                    // previousPageIndexes.add(3);
                    // bottomNavbarIndexNotifier.value = 6;
                    Get.to(() => MyOrdersScreen());
                  } else {
                    Services().showLoginAlert(context, "Please login to see your orders");
                  }
                },
                child: SideBarItemTile(
                  icon: Icons.local_shipping_outlined,
                  label: "My Orders",
                ),
              ),

              // products
              ExpandableProductsSideBarItem(),
              InkWell(
                onTap: () {
                  Get.to(() => AboutUsScreen());
                },
                child: SideBarItemTile(
                  icon: Icons.info_outline,
                  label: "About KSCDC",
                ),
              ),
              InkWell(
                onTap: () async {
                  final url = Uri.parse("https://www.cashewcorporation.com/");
                  if (await canLaunchUrl(url)) {
                    await launchUrl(
                      url,
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    throw 'Could not launch "https://www.cashewcorporation.com//"';
                  }
                },
                child: SideBarItemTile(
                  icon: Icons.language,
                  label: "Visit our website",
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => TermsAndConditionsScreen());
                },
                child: SideBarItemTile(
                  icon: Icons.new_releases_outlined,
                  label: "Terms & Conditions",
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => CancellationPolicyScreen());
                },
                child: SideBarItemTile(
                  icon: Icons.new_releases_outlined,
                  label: "Cancellation Policy",
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => PrivacyPolicyScreen());
                },
                child: SideBarItemTile(
                  icon: Icons.new_releases_outlined,
                  label: "Privacy Policy",
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => ShippingPolicyScreen());
                },
                child: SideBarItemTile(
                  icon: Icons.new_releases_outlined,
                  label: "Shipping Policy",
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
              SizedBox(height: 50.w)
            ],
          ),
        ),
      ),
    );
  }
}
