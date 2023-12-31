import 'package:flutter/material.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';

class CustomBottomNavbarItem extends StatelessWidget {
  const CustomBottomNavbarItem(
      {super.key,
      required this.icon,
      required this.label,
      required this.index,
      required this.color});
  final Icon icon;
  final String label;
  final int index;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          color: color,
          onPressed: () {
            bottomNavbarIndexNotifier.value = index;
          },
          icon: icon,
        ),
        Text(label),
      ],
    );
  }
}
