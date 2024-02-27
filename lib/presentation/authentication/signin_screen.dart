import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/presentation/authentication/forgot_password_screen.dart';
import 'package:internship_sample/presentation/authentication/signup_screen.dart';
import 'package:internship_sample/presentation/authentication/widgets/alternative_signin_options.dart.dart';
import 'package:internship_sample/presentation/authentication/widgets/authentication_page_title.dart';
import 'package:internship_sample/presentation/authentication/widgets/custom_icon_text_field.dart';
import 'package:internship_sample/presentation/authentication/widgets/custom_password_text_field.dart';
import 'package:internship_sample/presentation/main_page/main_page_screen.dart';
import 'package:internship_sample/presentation/widgets/custom_elevated_button.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:validatorless/validatorless.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
                  heading: "Welcome",
                ),
                AuthenticationPageTitle(
                  heading: "Back!",
                ),
                const SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomIconTextField(
                        icon: Icons.person_2,
                        hintText: "Email",
                        controller: emailController,
                        validator: Validatorless.multiple(
                          [
                            Validatorless.required('Email is required'),
                            Validatorless.email("Invalid Email"),
                          ],
                        ),
                      ),
                      CustomPasswordTextField(
                        hintText: "Password",
                        controller: passwordController,
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
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgotPasswordScreen())),
                      child: const CustomTextWidget(
                        text: "Forgot Password?",
                        fontSize: 12,
                        fontColor: Color(0xffF83758),
                        fontweight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        print("Trying to register user");
                        controller.loginUser(context, emailController.text, passwordController.text);
                      }
                    },
                    child: CustomElevatedButton(
                      label: "Login",
                    ),
                  ),
                ),
                const AlternativeSigninOptionsWidget(),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
