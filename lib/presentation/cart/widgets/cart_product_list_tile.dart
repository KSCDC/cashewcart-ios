import 'package:flutter/material.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constatns.dart';
import 'package:internship_sample/presentation/widgets/custom_star_rating_tile.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class CartProductsListTile extends StatelessWidget {
  const CartProductsListTile({
    super.key,
    required this.imagePath,
    required this.heading,
    required this.price,
    required this.originalPrice,
    required this.offerPercentage,
    required this.rating,
  });
  final String imagePath;
  final String heading;
  final String price;
  final String originalPrice;
  final String offerPercentage;
  final String rating;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width * 0.9,
      height: 210,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 125,
                  width: 130,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidget(
                        text: heading,
                        fontweight: FontWeight.w600,
                      ),
                      const SizedBox(height: 5),
                      const Row(
                        children: [
                          CustomTextWidget(
                            text: "Variations :",
                            fontSize: 12,
                            fontweight: FontWeight.w500,
                          ),
                          kWidth,
                          CartProductListTileButton(
                            buttonHeight: 20,
                            buttonWidth: 40,
                            label: "Black",
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                          kWidth,
                          CartProductListTileButton(
                            buttonHeight: 20,
                            buttonWidth: 40,
                            label: "Red",
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      kHeight,
                      Row(
                        children: [
                          CustomTextWidget(
                            text: rating,
                            // fontColor: ,
                            fontSize: 12,
                          ),
                          for (int i = 0; i < 4; i++)
                            const Icon(
                              Icons.star,
                              color: Color(0xFFF7B305),
                              size: 15,
                            ),
                          const Icon(
                            Icons.star_half,
                            color: Color(0xFFBBBBBB),
                            size: 15,
                          ),
                          kWidth,
                        ],
                      ),
                      kHeight,
                      Row(
                        children: [
                          CartProductListTileButton(
                            buttonHeight: 30,
                            buttonWidth: 85,
                            label: "₹ ${price}",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          kWidth,
                          Column(
                            children: [
                              CustomTextWidget(
                                text: offerPercentage,
                                fontColor: Color(0xFFFE735C),
                                fontSize: 10,
                                fontweight: FontWeight.w400,
                              ),
                              SizedBox(width: 10),
                              Text(
                                originalPrice,
                                style: const TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 15,
                                  color: Color(0xFF808488),
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Color(0xFF808488),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            kHeight,
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               const  CustomTextWidget(
                  text: "Total Order (1) :",
                  fontSize: 12,
                  fontweight: FontWeight.w500,
                ),
                CustomTextWidget(
                  text: "₹ ${price}",
                  fontSize: 12,
                  fontweight: FontWeight.w600,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CartProductListTileButton extends StatelessWidget {
  const CartProductListTileButton({
    super.key,
    required this.buttonHeight,
    required this.buttonWidth,
    required this.label,
    required this.fontSize,
    required this.fontWeight,
  });

  final double buttonHeight;
  final double buttonWidth;
  final String label;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: buttonHeight,
      width: buttonWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        border: Border.all(),
      ),
      child: Center(
        child: CustomTextWidget(
          text: label,
          fontSize: fontSize,
          fontweight: fontWeight,
        ),
      ),
    );
  }
}
