import 'package:flutter/material.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class CircleAvatarListItem extends StatelessWidget {
  const CircleAvatarListItem({
    super.key,
    required this.imagePath,
    required this.label,
  });
  final String imagePath;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 71,
        child: Column(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage(imagePath),
            ),
            CustomTextWidget(
              text: label,
              fontSize: 10,
              fontweight: FontWeight.w400,
              fontColor: Color(0xFF21003D),
            )
          ],
        ),
      ),
    );
  }
}
