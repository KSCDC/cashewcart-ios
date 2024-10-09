import 'package:flutter/material.dart';
import 'package:cashew_cart/core/colors.dart';
import 'package:cashew_cart/core/constants.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 18),
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
          height: 0,
        ),
      ],
    );
  }
}
