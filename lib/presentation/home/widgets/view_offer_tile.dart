import 'package:flutter/material.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class ViewOfferTile extends StatelessWidget {
  const ViewOfferTile({
    super.key,
    required this.color,
    required this.mainLabel,
    required this.icon,
    required this.subLabel,
  });
  final Color color;
  final String mainLabel;
  final IconData icon;
  final String subLabel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: mainLabel,
                  fontSize: 16,
                  fontColor: Colors.white,
                  fontweight: FontWeight.w500,
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      icon,
                      color: Colors.white,
                      size: 16,
                    ),
                    CustomTextWidget(
                      text: subLabel,
                      fontSize: 12,
                      fontColor: Colors.white,
                      fontweight: FontWeight.w400,
                    )
                  ],
                )
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              side: BorderSide(width: 1, color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Container(
              width: 89,
              child: Row(
                children: [
                  CustomTextWidget(
                    text: "Shop Now",
                    fontSize: 12,
                    fontColor: Colors.white,
                    fontweight: FontWeight.w600,
                  ),
                  Icon(
                    Icons.arrow_forward_outlined,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
