import 'package:flutter/material.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.label,
  });

  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kMainThemeColor,
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: Center(
        child: CustomTextWidget(
          text: label,
          fontSize: 20,
          fontColor: kButtonTextColor,
          fontweight: FontWeight.w600,
        ),
      ),
    );
  }
}
