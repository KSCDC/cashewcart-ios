import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class Heading extends StatelessWidget {
  const Heading({
    super.key,
    required this.heading,
    this.underline = true,
  });
  final String heading;
  final bool underline;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.w, bottom: 10.w),
      child: CustomTextWidget(
        text: heading,
        fontSize: 16.sp,
        fontweight: FontWeight.w600,
        underline: underline,
      ),
    );
  }
}
