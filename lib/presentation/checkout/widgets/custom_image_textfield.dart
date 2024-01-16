import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:internship_sample/core/colors.dart';

class CustomImageTextField extends StatelessWidget {
  const CustomImageTextField({
    required this.imagePath,
    required this.hintText,
    // required this.controller,
    super.key,
  });
  final String imagePath;
  final String hintText;
  // final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        // controller: controller,
        style: const TextStyle(color: Colors.black),
        textCapitalization: TextCapitalization.sentences,
        textAlign: TextAlign.end,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: SvgPicture.asset(
              imagePath,
              height: 15,
            ),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: kAuthentificationPageTextColor),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Color(0xffA8A8A9),
              width: 1,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 2, color: kMainThemeColor),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
