import 'package:flutter/material.dart';
import 'package:internship_sample/core/constatns.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class CustomStarRatingTile extends StatelessWidget {
  const CustomStarRatingTile({
    super.key,
    required this.iconAndTextSize,
    required this.numberOfRatings,
  });

  final String numberOfRatings;
  final double iconAndTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < 4; i++)
          Icon(
            Icons.star,
            color: Color(0xFFF7B305),
            size: iconAndTextSize,
          ),
        Icon(
          Icons.star_half,
          color: Color(0xFFBBBBBB),
          size: iconAndTextSize,
        ),
        kWidth,
        CustomTextWidget(
          text: numberOfRatings,
          fontColor: Color(0xFF828282),
          fontSize: iconAndTextSize,
        )
      ],
    );
  }
}
