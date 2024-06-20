import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/controllers/profile_controller.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/presentation/home/home_screen.dart';
import 'package:internship_sample/presentation/profile/profile_screen.dart';
import 'package:internship_sample/presentation/side_bar/side_bar.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  MainAppBar({super.key});
  ProfileController controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kMainThemeColor,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
            child: Image.asset(
              "lib/core/assets/images/logos/company_logo.png",
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () async {
              SharedPreferences sharedPref = await SharedPreferences.getInstance();
              final email = sharedPref.getString(EMAIL);
              final password = sharedPref.getString(ENCRYPTEDPASSWORD);
              if (email != null && password != null) {
                if (controller.userName == "") {
                  controller.getProfileDetails();
                }
                controller.getUserAddresses();
                Get.to(() => ProfileScreen());
              } else {
                Services().showLoginAlert(context, "Please login to access the profile");
              }
            },
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0),
              child: Icon(
                Icons.person,
                size: 40,
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
