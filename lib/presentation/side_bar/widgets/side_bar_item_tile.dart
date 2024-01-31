import 'package:flutter/material.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class SideBarItemTile extends StatelessWidget {
  const SideBarItemTile({
    super.key,
    required this.icon,
    required this.label,
  });
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(icon),
              kWidth,
              CustomTextWidget(text: label, fontSize: 18),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: kMainThemeColor,
              )
            ],
          ),
        ),
        Divider(
          thickness: 0.5,
        ),
      ],
    );
  }
}
