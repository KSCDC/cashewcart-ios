import 'package:flutter/material.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class CustomStarRatingTile extends StatelessWidget {
  const CustomStarRatingTile({
    super.key,
    required this.iconAndTextSize,
    required this.numberOfRatings,
  });

  final double numberOfRatings;
  final double iconAndTextSize;

  @override
  Widget build(BuildContext context) {
    int i;
    
    return Row(
      children: [
        for (i = 1; i <= numberOfRatings; i++)
          Icon(
            Icons.star,
            color: Color(0xFFF7B305),
            size: iconAndTextSize,
          ),
        if (5 - numberOfRatings != 0)
            Icon(
              Icons.star_half,
              color: Color(0xFFBBBBBB),
              size: iconAndTextSize,
            ),
        kWidth,
        CustomTextWidget(
          text: numberOfRatings.toString(),
          fontColor: Color(0xFF828282),
          fontSize: iconAndTextSize,
        )
      ],
    );
  }
}
