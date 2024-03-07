import 'package:flutter/material.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class CustomSearchFilteringButton extends StatelessWidget {
  const CustomSearchFilteringButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 24,
        width: 90,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        child: Row(
          children: [
            CustomTextWidget(
              text: label,
              fontSize: 12,
              fontweight: FontWeight.w400,
            ),
            Icon(
              icon,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
