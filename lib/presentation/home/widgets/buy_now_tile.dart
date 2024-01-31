import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/main.dart';
import 'package:internship_sample/presentation/home/home_screen.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/shop/shop_screen.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class BuyNowTile extends StatelessWidget {
  const BuyNowTile({
    super.key,
    required this.productDetails,
  });
  final productDetails;

  @override
  Widget build(BuildContext context) {
    final String imagePath = "lib/core/assets/images/product_images/Plain Cashew/Plain Cashew (F) nobg.png";
    final String productName = productDetails['name'];
    final String productDescription = productDetails['category'][0]['description'];

    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 20,
            height: 180,
            // color: Colors.black,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/core/assets/images/home/yellow_bar.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                width: 78,
                height: 180,
                // color: Colors.black,

                child: SvgPicture.asset("lib/core/assets/images/home/star_bg.svg"),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: 130,
                  height: 150,
                  // color: Colors.black,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 210,
                child: CustomTextWidget(
                  text: productName,
                  fontSize: 16,
                  fontweight: FontWeight.w500,
                ),
              ),
              kHeight,
              SizedBox(
                width: 200,
                child: CustomTextWidget(
                  text: productDescription,
                  fontSize: 10,
                  fontweight: FontWeight.w400,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextButton(
                  onPressed: () async {
                    selectedProductDetails = await productDetails;
                    previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                    bottomNavbarIndexNotifier.value = 4;
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: kMainThemeColor,
                    side: BorderSide(width: 1, color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Container(
                    child: Row(
                      children: [
                        CustomTextWidget(
                          text: "Buy Now",
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
        ],
      ),
    );
  }
}
