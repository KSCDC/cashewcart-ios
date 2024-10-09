import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cashew_cart/core/base_url.dart';
import 'package:cashew_cart/core/colors.dart';
import 'package:cashew_cart/models/product_model.dart';
import 'package:cashew_cart/presentation/widgets/custom_star_rating_tile.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductsListItemTile extends StatelessWidget {
  ProductsListItemTile({
    super.key,
    required this.productDetails,
    this.imagePath = '',
  });

  final productDetails;
  String imagePath;

  @override
  Widget build(BuildContext context) {
    final String productName = productDetails.product.name;
    final String description = productDetails.product.description;
    String originalPrice;
    String offerPrice;
    double priceWithGST = 0;
    num numberOfRatings = productDetails.product.averageRating;
    try {
      if (imagePath == '') {
        imagePath = productDetails.product.productImages.isNotEmpty
            ? "$baseUrl${productDetails.product.productImages[0].productImage}"
            : "https://t3.ftcdn.net/jpg/05/04/28/96/240_F_504289605_zehJiK0tCuZLP2MdfFBpcJdOVxKLnXg1.jpg";
      }

      originalPrice = productDetails.actualPrice;
      offerPrice = productDetails.sellingPrice;
      double cgstPrice = double.parse(productDetails.sellingPrice) * (double.parse(productDetails.cgstRate) / 100);
      double sgstPrice = double.parse(productDetails.sellingPrice) * (double.parse(productDetails.cgstRate) / 100);
      double sellingPrice = double.parse(productDetails.sellingPrice);
      priceWithGST = sellingPrice + cgstPrice + sgstPrice;
    } catch (e) {
      print("err :$e");
      // trending product model dont have getter actual price selling price etc. so the exception will occur
      // so giving empty value at that time
      // productName = productDetails.product.name;
      // description = productDetails.description;
      originalPrice = "";
      offerPrice = "";
    }

    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: 10.w),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 5,
        ),
        width: screenSize.width * 0.4,
        // height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          // border: Border.all(
          //   width: 0.1,
          //   color: Colors.grey,
          // ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: screenSize.width * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imagePath),
                      fit: BoxFit.fitHeight,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.w),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidget(
                        text: productName,
                        fontSize: 12.sp,
                        fontweight: FontWeight.w500,
                      ),
                      SizedBox(height: 5.w),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (offerPrice != "" || originalPrice != "")
                        CustomTextWidget(
                          text: "₹ ${priceWithGST!.toStringAsFixed(2)}",
                          fontSize: 12.sp,
                          fontweight: FontWeight.w600,
                          fontColor: Colors.red,
                        ),

                      //here from the api, if actual price and selling price are same, the discount percentage is coming as 100 (But actually it is zero)
                      //so if there is no offer, the discount percentage is coming as 100. at that time dont need to display the offer percentage
                      if (offerPrice != "" || originalPrice != "")
                        if (((double.parse(offerPrice) * 100 / double.parse(originalPrice))) != 100)
                          Row(
                            children: [
                              Text(
                                "₹${originalPrice}",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 15.sp,
                                  color: Color(0xFF808488),
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Color(0xFF808488),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              CustomTextWidget(
                                text: offerPrice == "" || originalPrice == "" ? "" : "${((double.parse(offerPrice) * 100 / double.parse(originalPrice))).toStringAsFixed(2)}%",
                                fontColor: Color(0xFFFE735C),
                                fontSize: 10.w,
                                fontweight: FontWeight.w400,
                              )
                            ],
                          ),
                      CustomStarRatingTile(
                        numberOfRatings: numberOfRatings.toDouble(),
                        iconAndTextSize: 10.sp,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
