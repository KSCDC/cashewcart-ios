import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cashew_cart/presentation/authentication/signin_screen.dart';
import 'package:cashew_cart/presentation/widgets/custom_elevated_button.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';
import 'package:lottie/lottie.dart';

class NoAccessTile extends StatelessWidget {
  const NoAccessTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 20.h),
        CustomTextWidget(
          text: "No Access!",
          fontSize: 22.sp,
          fontweight: FontWeight.w600,
          fontColor: Colors.red,
        ),
        Center(
          child: Lottie.asset("lib/core/assets/lottie/lock.json"),
        ),
        SizedBox(height: 20.h),
        GestureDetector(
          onTap: () {
            Get.offAll(() => SignInScreen());
          },
          child: CustomElevatedButton(label: "Login"),
        )
      ],
    );
  }
}
