import 'package:flutter/material.dart';
import 'package:internship_sample/core/constatns.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("lib/core/assets/images/avatar.jpeg"),
            ),
          ),
          kHeight,
          CustomTextWidget(
            text: "Name",
            fontSize: 16,
            fontweight: FontWeight.w600,
          )
        ],
      ),
    );
  }
}
