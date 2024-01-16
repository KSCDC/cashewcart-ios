import 'package:flutter/material.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constatns.dart';
import 'package:internship_sample/presentation/product_list/product_listing_screen.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class ValueAddedProductsTile extends StatelessWidget {
  const ValueAddedProductsTile({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: screenSize.width * 0.95,
            height: screenSize.width * 0.6,
            // color: Colors.black,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/core/assets/images/product_images/Cashew Powder/Cashew Powder 1.jpg"),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidget(
                    text: "Value Added Products",
                    fontSize: 20,
                    fontweight: FontWeight.w500,
                  ),
                  CustomTextWidget(
                    text: "${valueAddedProducts.length}",
                    fontSize: 16,
                    fontweight: FontWeight.w400,
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductListingScreen(productDetailsList: valueAddedProducts),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: kMainThemeColor,
                  side: BorderSide(width: 1, color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Container(
                  width: 80,
                  child: Row(
                    children: [
                      CustomTextWidget(
                        text: "View All",
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
            ],
          )
        ],
      ),
    );
  }
}
