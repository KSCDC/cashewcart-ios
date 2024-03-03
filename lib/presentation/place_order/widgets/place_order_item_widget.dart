import 'package:flutter/material.dart';
import 'package:internship_sample/core/base_url.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class PlaceOrderItemWidget extends StatelessWidget {
  const PlaceOrderItemWidget({
    super.key,
    required this.imagePath,
    required this.productName,
    required this.productDescription,
    required this.count,
  });
  final String imagePath;
  final String productName;
  final String productDescription;
  final int count;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            height: 100,
            width: screenSize.width * 0.25,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("$baseUrl$imagePath"),
                fit: BoxFit.fitWidth,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 250,
                child: CustomTextWidget(
                  text: productName,
                  fontweight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5),
              Container(
                width: screenSize.width * 0.6,
                child: CustomTextWidget(
                  text: productDescription,
                  fontSize: 13,
                  fontweight: FontWeight.w400,
                ),
              ),
              kHeight,
              CustomTextWidget(text: "Nos : $count"),
              kHeight,
            ],
          ),
        )
      ],
    );
  }
}
