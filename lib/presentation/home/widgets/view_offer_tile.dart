import 'package:flutter/material.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class ViewOfferTile extends StatelessWidget {
  const ViewOfferTile({
    super.key,
    required this.mainLabel,
    required this.icon,
    required this.subLabel,
  });
  final String mainLabel;
  final IconData icon;
  final String subLabel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0xFF4392F9),
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
            style: ButtonStyle(
                // side: BorderSide(color: Colors.white, width: 1),
                ),
            child: Row(
              children: [
                CustomTextWidget(
                  text: "View all",
                  fontColor: Colors.white,
                ),
                Icon(
                  Icons.arrow_forward_outlined,
                  color: Colors.white,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

