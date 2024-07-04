import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cashew_cart/controllers/app_controller.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:cashew_cart/core/colors.dart';
import 'package:cashew_cart/core/constants.dart';
import 'package:cashew_cart/presentation/authentication/otp_verification.dart';
import 'package:cashew_cart/presentation/authentication/token_verification_screen.dart';

import 'package:cashew_cart/presentation/authentication/widgets/alternative_signin_options.dart.dart';
import 'package:cashew_cart/presentation/authentication/widgets/authentication_page_title.dart';
import 'package:cashew_cart/presentation/authentication/widgets/custom_icon_text_field.dart';
import 'package:cashew_cart/presentation/authentication/widgets/custom_password_text_field.dart';
import 'package:cashew_cart/presentation/main_page/main_page_screen.dart';
import 'package:cashew_cart/presentation/widgets/custom_elevated_button.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';
import 'package:cashew_cart/services/api_services.dart';
import 'package:validatorless/validatorless.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  TextEditingController usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AppController controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Obx(() => controller.isLoading.value
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: double.infinity),
                      SizedBox(height: 100),
                      CustomTextWidget(
                        text: "Signing up",
                        fontSize: 20,
                        fontweight: FontWeight.w600,
                      ),
                      kHeight,
                      Container(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kHeight,
                      AuthenticationPageTitle(
                        heading: "Verify your\nEmail",
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
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomTextWidget(
                            text: "* ",
                            fontSize: 12,
                            fontColor: kMainThemeColor,
                            fontweight: FontWeight.w400,
                          ),
                          SizedBox(
                            width: screenSize.width * 0.7,
                            child: const CustomTextWidget(
                              text: "We will send a message to verify your mail",
                              fontSize: 12,
                              fontColor: kAuthentificationPageTextColor,
                              fontweight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        height: 55,
                        width: double.infinity,
                        child: GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              final response = await ApiServices().sendVerificationMail(context, _emailController.text);
                              if (response != null) {
                                Get.to(
                                  () => TokenVerificationScreen(
                                    isNewUser: true,
                                    email: _emailController.text,
                                  ),
                                );
                              }
                            }
                          },
                          child: CustomElevatedButton(
                            label: "Verify Email",
                          ),
                        ),
                      ),
                      // const AlternativeSigninOptionsWidget(),
                      SizedBox(height: 20.w),
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
                      ),
                      kHeight,
                    ],
                  )),
          ),
        ),
      ),
    );
  }
}
