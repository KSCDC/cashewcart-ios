import 'package:flutter/material.dart';
import 'package:internship_sample/core/colors.dart';

import 'package:internship_sample/presentation/authentication/widgets/alternative_signin_options.dart.dart';
import 'package:internship_sample/presentation/authentication/widgets/authentication_page_title.dart';
import 'package:internship_sample/presentation/authentication/widgets/custom_icon_text_field.dart';
import 'package:internship_sample/presentation/authentication/widgets/custom_password_text_field.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  TextEditingController usernameOrEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(29),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthenticationPageTitle(
                  heading: "Create an",
                ),
                AuthenticationPageTitle(
                  heading: "account",
                ),
                const SizedBox(height: 10),
                CustomIconTextField(
                  icon: Icons.person_2,
                  hintText: "Username or Email",
                  controller: usernameOrEmailController,
                ),
                CustomPasswordTextField(
                  hintText: "Password",
                  controller: passwordController,
                ),
                CustomPasswordTextField(
                  hintText: "Confirm  Password",
                  controller: confirmPasswordController,
                ),
                const Wrap(
                  children: [
                    CustomTextWidget(
                      text: "By clicking the ",
                      fontSize: 12,
                      fontColor: kAuthentificationPageTextColor,
                      fontweight: FontWeight.w400,
                    ),
                    CustomTextWidget(
                      text: "Register ",
                      fontSize: 12,
                      fontColor: Color(0xffFF4B26),
                      fontweight: FontWeight.w400,
                    ),
                    CustomTextWidget(
                      text: "button, you agree",
                      fontSize: 12,
                      fontColor: kAuthentificationPageTextColor,
                      fontweight: FontWeight.w400,
                    ),
                    CustomTextWidget(
                      text: "to the public offer",
                      fontSize: 12,
                      fontColor: kAuthentificationPageTextColor,
                      fontweight: FontWeight.w400,
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
                      final _password = passwordController.text;
                      final _confirmPassword = confirmPasswordController.text;
                      if (_password != _confirmPassword) {
                        const snackBar = SnackBar(
                          content: Text("Passwords doesn't match!"),
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(20),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        const snackBar = SnackBar(
                          content: Text('Account created successfully'),
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(20),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: const CustomTextWidget(
                      text: "Create Account",
                      fontSize: 20,
                      fontColor: kButtonTextColor,
                      fontweight: FontWeight.w600,
                    ),
                  ),
                ),
                const AlternativeSigninOptionsWidget(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomTextWidget(
                      text: "I Already Have An Account ",
                      fontSize: 14,
                      fontweight: FontWeight.w400,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const CustomTextWidget(
                        text: "Login",
                        fontSize: 14,
                        fontColor: kMainThemeColor,
                        fontweight: FontWeight.w600,
                        underline: true,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
