import 'package:flutter/material.dart';
import 'package:cashew_cart/core/colors.dart';

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
    this.maxLines = 50,
    this.textOverflow = TextOverflow.ellipsis,
  });

  final String text;
  final String fontFamily;
  final double fontSize;
  final Color fontColor;
  final FontWeight fontweight;
  final TextAlign textAlign;
  final bool underline;
  final double height;
  final int maxLines;
  final TextOverflow textOverflow;
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
        decorationColor: fontColor,
        height: height,
      ),
      overflow: textOverflow,
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}
