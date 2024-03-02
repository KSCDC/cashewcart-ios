import 'package:flutter/material.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/main.dart';
import 'package:internship_sample/presentation/home/home_screen.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/shop/shop_screen.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class SlidingImageTile extends StatelessWidget {
  const SlidingImageTile({
    super.key,
    required this.productDetails,
  });
  final productDetails;

  @override
  Widget build(BuildContext context) {
    final String imagePath = productDetails['imagePath'][0];
    ;

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
                image: AssetImage(imagePath),
                fit: BoxFit.fitWidth,
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
                  text: "50-70% OFF",
                  fontSize: 20,
                  fontColor: kMainThemeColor.withOpacity(0.6),
                  fontweight: FontWeight.w700,
                ),
                CustomTextWidget(
                  text: "Now in different",
                  fontSize: 12,
                  fontColor: kMainThemeColor.withOpacity(0.6),
                  fontweight: FontWeight.w500,
                ),
                CustomTextWidget(
                  text: "quantities",
                  fontSize: 12,
                  fontColor: kMainThemeColor.withOpacity(0.6),
                  fontweight: FontWeight.w500,
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: kMainThemeColor.withOpacity(0.6),
                    side: BorderSide(
                        width: 1, color: kMainThemeColor.withOpacity(0.6)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      // controller.productDetails.value = await productDetails;
                      previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                      bottomNavbarIndexNotifier.value = 4;
                    },
                    child: Container(
                      width: 90,
                      child: Row(
                        children: [
                          CustomTextWidget(
                            text: "Shop Now",
                            fontSize: 12,
                            fontColor: kMainThemeColor.withOpacity(0.6),
                            fontweight: FontWeight.w600,
                          ),
                          Icon(
                            Icons.arrow_forward_outlined,
                            color: kMainThemeColor.withOpacity(0.6),
                          )
                        ],
                      ),
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
