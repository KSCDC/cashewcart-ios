import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cashew_cart/core/colors.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.label,
    this.fontSize = 20,
    this.width = double.infinity,
  });

  final String label;
  final double fontSize;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.w,
      width: width,
      decoration: const BoxDecoration(
        color: kMainThemeColor,
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: Center(
        child: CustomTextWidget(
          text: label,
          fontSize: fontSize,
          fontColor: kButtonTextColor,
          fontweight: FontWeight.w600,
        ),
      ),
    );
  }
}
