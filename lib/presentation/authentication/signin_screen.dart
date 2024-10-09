import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cashew_cart/controllers/app_controller.dart';
import 'package:cashew_cart/core/colors.dart';
import 'package:cashew_cart/core/constants.dart';
import 'package:cashew_cart/presentation/authentication/forgot_password_screen.dart';
import 'package:cashew_cart/presentation/authentication/signup_screen.dart';
import 'package:cashew_cart/presentation/authentication/widgets/alternative_signin_options.dart.dart';
import 'package:cashew_cart/presentation/authentication/widgets/authentication_page_title.dart';
import 'package:cashew_cart/presentation/authentication/widgets/custom_icon_text_field.dart';
import 'package:cashew_cart/presentation/authentication/widgets/custom_password_text_field.dart';
import 'package:cashew_cart/presentation/main_page/main_page_screen.dart';
import 'package:cashew_cart/presentation/widgets/custom_elevated_button.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';
import 'package:cashew_cart/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

import 'package:encrypt/encrypt.dart' as enc;

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  static final TextEditingController _emailController = TextEditingController();
  static final TextEditingController _passwordController = TextEditingController();
  static final _formKey = GlobalKey<FormState>();
  AppController controller = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(29),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthenticationPageTitle(
                  heading: "Welcome to",
                ),
                AuthenticationPageTitle(
                  heading: "KSCDC Cashewcart",
                ),
                const SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomIconTextField(
                        icon: Icons.mail_outline,
                        hintText: "Email",
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: Validatorless.multiple(
                          [
                            Validatorless.required('Email is required'),
                            Validatorless.email("Invalid Email"),
                          ],
                        ),
                      ),
                      CustomPasswordTextField(
                        hintText: "Password",
                        controller: _passwordController,
                        validator: Validatorless.multiple(
                          [
                            Validatorless.required('Password is required'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(() => ForgotPasswordScreen()),
                      child: const CustomTextWidget(
                        text: "Forgot Password?",
                        fontSize: 12,
                        fontColor: kMainThemeColor,
                        fontweight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Obx(() {
                  return controller.isLoading.value
                      ? Container(
                          height: 55,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: kMainThemeColor,
                          ),
                          child: Center(
                            child: SizedBox(
                              height: 40,
                              width: 40,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              print("Trying to login user");
                              final loginSuccess = await controller.loginUser(context, _emailController.text, _passwordController.text);
                              if (loginSuccess != null && loginSuccess != false) {
                                _emailController.clear();
                                _passwordController.clear();
                                Get.offAll(() => MainPageScreen());
                              }
                            }
                          },
                          child: CustomElevatedButton(
                            label: "Login",
                          ),
                        );
                }),

                SizedBox(height: 30),
                GestureDetector(
                  onTap: () async {
                    Get.offAll(() => MainPageScreen());
                  },
                  child: CustomElevatedButton(
                    label: "Explore without Login",
                  ),
                ),
                // const AlternativeSigninOptionsWidget(),
                SizedBox(height: 20.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomTextWidget(
                      text: "Create An Account ",
                      fontSize: 14,
                      fontColor: kAuthentificationPageTextColor,
                      fontweight: FontWeight.w400,
                    ),
                    GestureDetector(
                      onTap: () => Get.to(() => SignUpScreen()),
                      child: const CustomTextWidget(
                        text: "Sign Up",
                        fontSize: 14,
                        fontColor: kMainThemeColor,
                        fontweight: FontWeight.w600,
                        underline: true,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
