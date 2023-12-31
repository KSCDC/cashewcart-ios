import 'package:flutter/material.dart';
import 'package:internship_sample/core/constatns.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class OnboardingTile extends StatelessWidget {
  OnboardingTile({
    super.key,
    required this.imagePath,
    required this.heading,
    required this.description,
  });

  final String imagePath;
  final String heading;
  final String description;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(
            flex: 4,
          ),
          Image(
            image: AssetImage(
              imagePath,
            ),
            width: screenSize.width,
          ),
          Spacer(),
          CustomTextWidget(
            text: heading,
            fontSize: 24,
            fontweight: FontWeight.w800,
          ),
          Spacer(),
          CustomTextWidget(
            text: description,
            fontweight: FontWeight.w600,
            fontColor: Color(0xffA8A8A9),
            textAlign: TextAlign.center,
          ),
          Spacer(
            flex: 4,
          )
        ],
      ),
    );
  }
}
