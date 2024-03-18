import 'package:flutter/material.dart';
import 'package:internship_sample/core/base_url.dart';
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
        height: 110,
        width: 90,
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(imagePath),
            ),
            CustomTextWidget(
              text: label,
              fontSize: 10,
              fontweight: FontWeight.w400,
              fontColor: Color(0xFF21003D),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
