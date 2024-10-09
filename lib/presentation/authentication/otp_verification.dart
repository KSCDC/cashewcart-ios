import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cashew_cart/core/colors.dart';
import 'package:cashew_cart/presentation/widgets/custom_elevated_button.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationScreen extends StatelessWidget {
  OtpVerificationScreen({super.key, required this.isNewUser});
  final bool isNewUser;
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
                PinCodeTextField(
                  appContext: context,
                  length: 5,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box, // Set the shape to box
                    fieldHeight: 60,
                    fieldWidth: 60,
                    activeColor: kMainThemeColor,
                    inactiveColor: Colors.grey,
                    selectedColor: kMainThemeColor,
                    activeFillColor: kMainThemeColor,
                    inactiveFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    borderRadius: BorderRadius.circular(0), // Set border radius to 0
                  ),
                  onCompleted: (value) {
                    print("completed typing");
                    print(value);
                  },
                ),
                SizedBox(height: 10),
                Container(
                  height: 40,
                  width: double.infinity,
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // isNewUser ? Get.offAll(() => CreateAccountScreen()) : Get.offAll(() => ResetPasswordScreen());
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
