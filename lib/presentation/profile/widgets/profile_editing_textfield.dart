import 'package:flutter/material.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class ProfileEditingTextField extends StatelessWidget {
  ProfileEditingTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.enabled = true,
  });

  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: hintText,
          fontweight: FontWeight.w400,
        ),
        kHeight,
        TextFormField(
          enabled: enabled,
          controller: controller,
          obscureText: obscureText,
          style: const TextStyle(color: Colors.black),
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            fillColor: Colors.white,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: Color(0xffA8A8A9),
                width: 1,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
