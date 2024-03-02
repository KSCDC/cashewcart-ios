import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/main.dart';
import 'package:internship_sample/presentation/account/widgets/custom_text_button.dart';
import 'package:internship_sample/presentation/authentication/signin_screen.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/profile/profile_screen.dart';
import 'package:internship_sample/presentation/widgets/custom_elevated_button.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/services/api_services.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});
  AppController controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("lib/core/assets/images/avatar.jpeg"),
            ),
          ),
          SizedBox(height: 20),
          Obx(() {
            return controller.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Center(
                        child: CustomTextWidget(
                          text: controller.userName,
                          fontSize: 20,
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
                        text: controller.email,
                        fontSize: 16,
                      ),
                      kHeight,
                      CustomTextWidget(
                        text: controller.phoneNo,
                        fontSize: 16,
                      ),
                    ],
                  );
          }),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextButton(
                label: "My Orders",
                onPressed: () {
                  previousPageIndexes.add(3);
                  bottomNavbarIndexNotifier.value = 6;
                },
              ),
              kWidth,
              CustomTextButton(
                label: "Buy Again",
                onPressed: () {
                  previousPageIndexes.add(3);

                  bottomNavbarIndexNotifier.value = 6;
                },
              ),
              
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextButton(
                  label: "Edit Profile",
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(),
                      ),
                    );
                  }),
              kWidth,
              CustomTextButton(
                label: "Logout",
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                    (route) => false, // Remove all previous routes
                  );
                },
              ),
              // CustomElevatedButton(label: "label"),
            ],
          ),
        ],
      ),
    );
  }
}
