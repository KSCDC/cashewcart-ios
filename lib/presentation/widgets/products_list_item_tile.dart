import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:internship_sample/core/base_url.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/models/product_model.dart';
import 'package:internship_sample/presentation/widgets/custom_star_rating_tile.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

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
    if (imagePath == '') {
      imagePath = productDetails.product.productImages.isNotEmpty ? "$baseUrl${productDetails.product.productImages[0]['product_image']}" : "";
    }

    final String productName = productDetails.product.name;
    final String description = productDetails.product.description;
    final String originalPrice = productDetails.actualPrice;
    final String offerPrice = productDetails.sellingPrice;
    final double numberOfRatings = 4.5;

    final screenSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ),
      width: screenSize.width * 0.4,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.1,
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
              padding: const EdgeInsets.all(5),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      text: productName,
                      fontSize: 12,
                      fontweight: FontWeight.w500,
                    ),
                    SizedBox(height: 5),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    CustomTextWidget(
                      text: "₹${offerPrice}",
                      fontSize: 12,
                      fontweight: FontWeight.w500,
                    ),
                    Row(
                      children: [
                        Text(
                          "₹${originalPrice}",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 15,
                            color: Color(0xFF808488),
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Color(0xFF808488),
                          ),
                        ),
                        SizedBox(width: 10),
                        CustomTextWidget(
                          text: "${((double.parse(offerPrice) * 100 / double.parse(originalPrice))).toStringAsFixed(2)}%",
                          fontColor: Color(0xFFFE735C),
                          fontSize: 10,
                          fontweight: FontWeight.w400,
                        )
                      ],
                    ),
                    CustomStarRatingTile(
                      numberOfRatings: numberOfRatings,
                      iconAndTextSize: 10,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
