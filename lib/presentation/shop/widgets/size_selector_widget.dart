import 'package:flutter/material.dart';
import 'package:cashew_cart/core/colors.dart';
import 'package:cashew_cart/presentation/shop/widgets/shop_product_details_tile.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';

class SizeSelectorWidget extends StatelessWidget {
  const SizeSelectorWidget({
    super.key,
    required this.index,
    required this.fontColor,
    required this.backgroundColor,
    required this.label,
  });
  final int index;
  final String label;
  final Color fontColor;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextButton(
        onPressed: () {
          sizeSelectNotifier.value = index;
        },
        style: TextButton.styleFrom(
          foregroundColor: kMainThemeColor,
          backgroundColor: backgroundColor,
          side: BorderSide(
            width: 2,
            color: kMainThemeColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Container(
          child: Row(
            children: [
              CustomTextWidget(
                text: label,
                fontSize: 14,
                fontColor: fontColor,
                fontweight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
