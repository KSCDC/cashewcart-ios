import 'package:flutter/material.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class SlidingImageTile extends StatelessWidget {
  const SlidingImageTile({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: [
          Container(
            width: screenSize.width * 0.89,
            height: screenSize.width * 0.8,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/core/assets/images/other/offer_image1.jpg"),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: "50-40% OFF",
                  fontSize: 20,
                  fontColor: Colors.white,
                  fontweight: FontWeight.w700,
                ),
                CustomTextWidget(
                  text: "Now in (product)",
                  fontSize: 12,
                  fontColor: Colors.white,
                  fontweight: FontWeight.w400,
                ),
                CustomTextWidget(
                  text: "All colours",
                  fontSize: 12,
                  fontColor: Colors.white,
                  fontweight: FontWeight.w400,
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
                    width: 100,
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
          )
        ],
      ),
    );
  }
}
