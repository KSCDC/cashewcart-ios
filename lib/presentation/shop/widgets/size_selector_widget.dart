import 'package:flutter/material.dart';
import 'package:internship_sample/presentation/shop/widgets/shop_product_details_tile.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class SizeSelectorWidget extends StatelessWidget {
  const SizeSelectorWidget({
    super.key,
    required this.index,
    required this.fontColor,
    required this.backgroundColor, required this.label,
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
          foregroundColor: Color(0xFFFA7189),
          backgroundColor: backgroundColor,
          side: BorderSide(
            width: 2,
            color: Color(0xFFFA7189),
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
