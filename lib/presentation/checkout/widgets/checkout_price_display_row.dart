import 'package:flutter/material.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class CheckoutScreenPriceDisplayRow extends StatelessWidget {
  const CheckoutScreenPriceDisplayRow({
    super.key,
    required this.lable,
    required this.price,
    required this.color,
  });

  final String lable;
  final String price;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextWidget(
          text: lable,
          fontSize: 18,
          fontColor: color,
          fontweight: FontWeight.w500,
        ),
        CustomTextWidget(
          text: "₹ ${price}",
          fontSize: 18,
          fontColor: color,
          fontweight: FontWeight.w500,
        ),
      ],
    );
  }
}
