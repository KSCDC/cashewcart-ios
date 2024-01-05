import 'package:flutter/material.dart';
import 'package:internship_sample/core/colors.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({
    super.key,
    required this.text,
    this.fontFamily = 'Montserrat',
    this.fontSize = 14,
    this.fontColor = Colors.black,
    this.fontweight = FontWeight.normal,
    this.textAlign = TextAlign.start,
    this.underline = false,
    this.height = 1.5,
  });

  final String text;
  final String fontFamily;
  final double fontSize;
  final Color fontColor;
  final FontWeight fontweight;
  final TextAlign textAlign;
  final bool underline;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        color: fontColor,
        fontWeight: fontweight,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
        decorationColor: kMainThemeColor,
        height: height,
      ),
      overflow: TextOverflow.visible,
      textAlign: textAlign,
    );
  }
}
