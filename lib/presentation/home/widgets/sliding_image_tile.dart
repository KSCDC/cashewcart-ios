import 'package:flutter/material.dart';
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
                const CustomTextWidget(
                  text: "50-40% OFF",
                  fontSize: 20,
                  fontColor: Colors.white,
                  fontweight: FontWeight.w700,
                ),
                const CustomTextWidget(
                  text: "Now in (product)",
                  fontSize: 12,
                  fontColor: Colors.white,
                  fontweight: FontWeight.w500,
                ),
                const CustomTextWidget(
                  text: "Different flavours",
                  fontSize: 12,
                  fontColor: Colors.white,
                  fontweight: FontWeight.w500,
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
                  child: GestureDetector(
                    onTap: () async {
                      selectedProductDetails = await productDetails;
                      previousPageIndex = bottomNavbarIndexNotifier.value;
                      bottomNavbarIndexNotifier.value = 4;
                    },
                    child: Container(
                      width: 90,
                      child: const Row(
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
