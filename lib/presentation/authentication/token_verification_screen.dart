import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:internship_sample/presentation/authentication/create_account_screen.dart';
import 'package:internship_sample/presentation/authentication/reset_password_screen.dart';
import 'package:internship_sample/presentation/authentication/widgets/custom_icon_text_field.dart';
import 'package:internship_sample/presentation/widgets/custom_elevated_button.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/services/api_services.dart';
import 'package:internship_sample/services/services.dart';

class TokenVerificationScreen extends StatelessWidget {
  TokenVerificationScreen({super.key, required this.isNewUser});
  final bool isNewUser;
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
                  text: "We have sent the code verification\nto your mobile number",
                  fontColor: Colors.grey,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                CustomIconTextField(
                  icon: Icons.key,
                  hintText: "Copy and paste your secret key from the mail here",
                  controller: _tokenController,
                ),
                SizedBox(height: 10),
                Container(
                  height: 40,
                  width: double.infinity,
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    final response = await ApiServices().verifyMail(_tokenController.text);
                    if (response != null) {
                      Services().showCustomSnackBar(context, "Email verification success");
                      isNewUser
                          ? Get.offAll(() => CreateAccountScreen(
                                token: _tokenController.text,
                              ))
                          : Get.offAll(() => ResetPasswordScreen());
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
