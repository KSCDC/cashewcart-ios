import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({
    super.key,
    required this.text,
    this.fontFamily = 'Montserrat',
    this.fontSize = 14,
    this.fontColor = Colors.black,
    this.fontweight = FontWeight.normal,
    this.textAlign = TextAlign.start
  });

  final String text;
  final String fontFamily;
  final double fontSize;
  final Color fontColor;
  final FontWeight fontweight;
  final TextAlign textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        color: fontColor,
        fontWeight: fontweight,
        
      ),
      textAlign: textAlign,
    );
  }
}
