import 'package:flutter/material.dart';
import 'package:internship_sample/core/colors.dart';

import 'package:internship_sample/presentation/authentication/widgets/authentication_page_title.dart';
import 'package:internship_sample/presentation/authentication/widgets/custom_icon_text_field.dart';

import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  TextEditingController usernameOrEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(29),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthenticationPageTitle(
                  heading: "Forgot",
                ),
                AuthenticationPageTitle(
                  heading: "Password?",
                ),
                const SizedBox(height: 10),
                CustomIconTextField(
                  icon: Icons.mail,
                  hintText: "Enter your email address",
                  controller: usernameOrEmailController,
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextWidget(
                      text: "* ",
                      fontSize: 12,
                      fontColor: Color(0xffFF4B26),
                      fontweight: FontWeight.w400,
                    ),
                    SizedBox(
                      width: screenSize.width * 0.7,
                      child: const CustomTextWidget(
                        text:
                            "We will send you a message to set or reset your new password ",
                        fontSize: 12,
                        fontColor: kAuthentificationPageTextColor,
                        fontweight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kMainThemeColor,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4)))),
                    onPressed: () {
                      final _email = usernameOrEmailController.text;

                      SnackBar snackBar = SnackBar(
                        content: Text('OTP send to your email $_email'),
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(20),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: const CustomTextWidget(
                      text: "Submit",
                      fontSize: 20,
                      fontColor: kButtonTextColor,
                      fontweight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
