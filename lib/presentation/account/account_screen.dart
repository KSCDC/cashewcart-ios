import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/controllers/profile_controller.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/main.dart';
import 'package:internship_sample/presentation/account/widgets/account_item_tile.dart';
import 'package:internship_sample/presentation/account/widgets/custom_text_button.dart';
import 'package:internship_sample/presentation/authentication/signin_screen.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/my_orders/my_orders_screen.dart';
import 'package:internship_sample/presentation/profile/profile_screen.dart';
import 'package:internship_sample/presentation/splash/splash_screen.dart';
import 'package:internship_sample/presentation/widgets/custom_appbar.dart';
import 'package:internship_sample/presentation/widgets/custom_elevated_button.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/presentation/widgets/no_access_tile.dart';
import 'package:internship_sample/services/api_services.dart';
import 'package:internship_sample/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});
  AppController controller = Get.put(AppController());
  ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: kMainThemeColor,
        centerTitle: true,

        title: CustomTextWidget(
          text: "Account",
          fontSize: 18,
          fontweight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Obx(() {
            return !controller.isLoggedIn.value
                ? Padding(
                    padding: EdgeInsets.only(top: 20.w),
                    child: NoAccessTile(),
                  )
                : Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white.withOpacity(0),
                          // backgroundImage: AssetImage("lib/core/assets/images/avatar.jpeg"),
                          child: Icon(
                            Icons.person,
                            size: 100,
                            color: kMainThemeColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.w),
                      Obx(() {
                        return profileController.isLoadingProfile.value
                            ? Skeletonizer(
                                enabled: true,
                                child: Column(
                                  children: [
                                    Center(
                                      child: CustomTextWidget(
                                        text: "User Name",
                                        fontSize: 20.sp,
                                        fontweight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Divider(
                                      thickness: 0.2,
                                      color: Colors.grey,
                                    ),
                                    kHeight,
                                    CustomTextWidget(
                                      text: "sampleuser@gmail.com",
                                      fontSize: 16.sp,
                                    ),
                                    kHeight,
                                    CustomTextWidget(
                                      text: "9876543210",
                                      fontSize: 16.sp,
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  Center(
                                    child: CustomTextWidget(
                                      text: profileController.userName.value,
                                      fontSize: 20.sp,
                                      fontweight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Divider(
                                    thickness: 0.2,
                                    color: Colors.grey,
                                  ),
                                  kHeight,
                                  CustomTextWidget(
                                    text: profileController.email.value,
                                    fontSize: 16.sp,
                                  ),
                                  kHeight,
                                  CustomTextWidget(
                                    text: profileController.phoneNo.value,
                                    fontSize: 16.sp,
                                  ),
                                ],
                              );
                      }),
                      SizedBox(height: 50.w),
                      AccountItemTile(
                        icon: Icons.local_shipping_outlined,
                        label: "My orders",
                        onTap: () {
                          // previousPageIndexes.add(3);
                          // bottomNavbarIndexNotifier.value = 6;
                          // Get.to(() => MyOrdersScreen());
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyOrdersScreen()));
                        },
                      ),
                      AccountItemTile(
                        icon: Icons.location_on_outlined,
                        label: "Track Orders",
                        onTap: () async {
                          // previousPageIndexes.add(3);
                          // bottomNavbarIndexNotifier.value = 6;
                          final url = Uri.parse("https://www.indiapost.gov.in/vas/Pages/IndiaPostHome.aspx");
                          if (await canLaunchUrl(url)) {
                            await launchUrl(
                              url,
                              mode: LaunchMode.externalApplication,
                            );
                          } else {
                            throw 'Could not launch "https://www.indiapost.gov.in/vas/Pages/IndiaPostHome.aspx"';
                          }
                        },
                      ),
                      AccountItemTile(
                        icon: Icons.edit,
                        label: "Edit Profile",
                        onTap: () async {
                          SharedPreferences sharedPref = await SharedPreferences.getInstance();
                          final email = sharedPref.getString(EMAIL);
                          final password = sharedPref.getString(ENCRYPTEDPASSWORD);
                          if (email != null && password != null) {
                            if (profileController.userName == "") {
                              profileController.getProfileDetails();
                            }
                            profileController.getUserAddresses();
                            Get.to(() => ProfileScreen());
                          } else {
                            Services().showLoginAlert(context, "Please login to access the profile");
                          }
                        },
                      ),
                      AccountItemTile(
                        icon: Icons.star_border_outlined,
                        label: "Rate Us",
                      ),
                      AccountItemTile(
                        icon: Icons.share,
                        label: "Share App",
                      ),
                      AccountItemTile(
                        icon: Icons.logout,
                        label: "Logout",
                        onTap: () async {
                          SharedPreferences sharedPref = await SharedPreferences.getInstance();
                          await sharedPref.clear();
                          cartCountNotifier.value = 0;

                          // bottomNavbarIndexNotifier.value = 0;
                          // Navigator.of(context).pushAndRemoveUntil(
                          //   MaterialPageRoute(builder: (context) => SignInScreen()),
                          //   (route) => false, // Remove all previous routes
                          // );
                          Get.offAll(() => SignInScreen());
                          controller.isLoggedIn.value = false;
                        },
                      ),
                      SizedBox(
                        height: 70.w,
                      )
                    ],
                  );
          }),
        ),
      ),
    );
  }
}
