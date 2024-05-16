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
        // height: 120,
        width: 90,
        child: Column(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.network(
                  imagePath,
                  fit: BoxFit.scaleDown, // Apply your desired BoxFit property here
                  width: 70, // Ensure the width and height match the CircleAvatar's size
                  height: 70,
                ),
              ),
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
