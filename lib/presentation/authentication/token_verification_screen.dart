import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:cashew_cart/core/constants.dart';
import 'package:cashew_cart/presentation/authentication/create_account_screen.dart';
import 'package:cashew_cart/presentation/authentication/reset_password_screen.dart';
import 'package:cashew_cart/presentation/authentication/widgets/custom_icon_text_field.dart';
import 'package:cashew_cart/presentation/widgets/custom_elevated_button.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';
import 'package:cashew_cart/services/api_services.dart';
import 'package:cashew_cart/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenVerificationScreen extends StatelessWidget {
  TokenVerificationScreen({super.key, required this.isNewUser, required this.email});
  final bool isNewUser;
  final String email;
  TextEditingController _tokenController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                CustomTextWidget(
                  text: "Enter Verification Code",
                  fontSize: 24,
                  fontweight: FontWeight.w600,
                ),
                SizedBox(height: 10),
                CustomTextWidget(
                  text: "We have sent the key to\n$email",
                  fontSize: 12.sp,
                  fontColor: Colors.red,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                CustomIconTextField(
                  icon: Icons.key,
                  hintText: "Paste your secret key here",
                  controller: _tokenController,
                ),
                SizedBox(height: 10),
                CustomTextWidget(
                  text: "Please check your mail, copy the secret key we have sent to you and paste it in the above field.",
                  fontColor: Colors.red,
                  fontSize: 12.sp,
                  textAlign: TextAlign.center,
                ),
                Container(
                  height: 40,
                  width: double.infinity,
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    final response = await ApiServices().verifyMail(_tokenController.text);
                    if (response != null) {
                      print(response.data.toString());

                      SharedPreferences sharedPref = await SharedPreferences.getInstance();
                      sharedPref.setString(ACCESSTOKEN, _tokenController.text);

                      // print(tokenValue);
                      Services().showCustomSnackBar(context, "Email verification success");
                      isNewUser
                          ? Get.offAll(() => CreateAccountScreen(
                                token: _tokenController.text,
                              ))
                          : Get.offAll(
                              () => ResetPasswordScreen(
                                email: email,
                              ),
                            );
                    } else {
                      Services().showCustomSnackBar(context, "Email verification failed");
                    }
                  },
                  child: CustomElevatedButton(
                    label: "Verify",
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
