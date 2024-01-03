import 'package:flutter/material.dart';
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

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  TextEditingController usernameOrEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                  heading: "Welcome",
                ),
                AuthenticationPageTitle(
                  heading: "Back!",
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
                      final _email = usernameOrEmailController.text;
                      final _password = passwordController.text;
                      if (_email == "ajs" && _password == "1234") {
                        const snackBar = SnackBar(
                          content: Text('Login success'),
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(20),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => MainPageScreen(),
                          ),
                        );
                      } else {
                        const snackBar = SnackBar(
                          content: Text('Username and password doesnot match!'),
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(20),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ),
                      ),
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
