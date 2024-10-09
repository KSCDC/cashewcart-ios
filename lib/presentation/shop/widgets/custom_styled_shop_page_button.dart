import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';

class CustomStyledShopPageButton extends StatelessWidget {
  const CustomStyledShopPageButton({
    super.key,
    required this.gradientColors,
    required this.icon,
    required this.label,
  });

  final List<Color> gradientColors;
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            height: 40,
            width: 140,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: gradientColors,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                )),
            child: Container(
              padding: EdgeInsets.only(left: 45, right: 10),
              child: Row(
                children: [
                  CustomTextWidget(
                    text: label,
                    fontSize: 14,
                    fontColor: Colors.white,
                    fontweight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(colors: gradientColors),
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 25,
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
