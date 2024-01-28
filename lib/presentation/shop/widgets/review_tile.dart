import 'package:flutter/material.dart';
import 'package:internship_sample/core/constatns.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class ReviewTile extends StatelessWidget {
  const ReviewTile({
    super.key,
    required this.rating,
    required this.review,
    required this.reviewerName,
  });

  final int rating;
  final String review;
  final String reviewerName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              for (int i = 0; i < rating; i++)
                Icon(
                  Icons.star,
                  color: Color(0xFFF7B305),
                  size: 18,
                ),
            ],
          ),
          kHeight,
          CustomTextWidget(text: review),
          SizedBox(height: 20),
          Row(
            children: [
              Icon(
                Icons.person,
                size: 14,
              ),
              SizedBox(width: 5),
              CustomTextWidget(text: reviewerName),
            ],
          ),
          kHeight,
          Divider(),
        ],
      ),
    );
  }
}
