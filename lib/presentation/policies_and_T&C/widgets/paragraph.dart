import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';

class Paragraph extends StatelessWidget {
  const Paragraph({
    super.key,
    required this.paragraph,
    this.showBullet = false,
  });
  final String paragraph;
  final bool showBullet;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showBullet)
            Padding(
              padding: EdgeInsets.all(5.w),
              child: CircleAvatar(
                radius: 5.r,
                backgroundColor: Colors.black,
              ),
            ),
          Expanded(
            child: CustomTextWidget(
              text: paragraph,
              fontSize: 12.sp,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
