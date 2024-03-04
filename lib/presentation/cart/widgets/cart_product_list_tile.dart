import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/core/base_url.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/presentation/cart/cart_screen.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/shop/widgets/custom_text_icon_button.dart';
import 'package:internship_sample/presentation/widgets/custom_star_rating_tile.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/services/api_services.dart';

class CartProductsListTile extends StatelessWidget {
  CartProductsListTile({
    super.key,
    required this.productDetails,
  });
  final productDetails;
  AppController controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    final String imagePath = productDetails.product.product.productImages.isNotEmpty ? productDetails.product.product.productImages[0].productImage : "";
    final String productName = productDetails.product.product.name;
    // final int selectedCategory = 1;
    ValueNotifier<int> currentProductCountNotifier = ValueNotifier(productDetails.purchaseCount);
    print("purchase count:${productDetails.purchaseCount}");
    final String originalPrice = productDetails.product.actualPrice;
    final String offerPrice = productDetails.product.sellingPrice;
    final String numberOfRatings = "20";
    final String weight = productDetails.product.weightInGrams;
    final screenSize = MediaQuery.of(context).size;

    print("Product name:$productName");
    return Container(
      width: screenSize.width * 0.9,
      // height: 210,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
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
                      image: NetworkImage("$baseUrl$imagePath"),
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
                      SizedBox(
                        width: screenSize.width * 0.5,
                        child: CustomTextWidget(
                          text: productName,
                          fontSize: 12,
                          fontweight: FontWeight.w600,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          CustomTextWidget(
                            text: "Net Weight :",
                            fontSize: 12,
                            fontweight: FontWeight.w500,
                          ),
                          kWidth,
                          CartProductListTileButton(
                            buttonHeight: 20,
                            buttonWidth: 40,
                            label: weight,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      kHeight,
                      Row(
                        children: [
                          CustomTextWidget(
                            text: numberOfRatings,
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
                            label: "₹ ${offerPrice}",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          kWidth,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextWidget(
                                text: "${(double.parse(offerPrice) * 100 / double.parse(originalPrice)).toStringAsFixed(2)}%",
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
            ValueListenableBuilder(
                valueListenable: currentProductCountNotifier,
                builder: (context, newCount, _) {
                  return Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextWidget(
                        text: "Total Order (${newCount}) :",
                        fontSize: 12,
                        fontweight: FontWeight.w500,
                      ),
                      kWidth,
                      GestureDetector(
                        onTap: () {
                          if (newCount != 0) {
                            cartCountNotifier.value--;
                            currentProductCountNotifier.value--;
                            ApiServices().updateCartCount(productDetails.id.toString(), currentProductCountNotifier.value);
                            CartScreen().getGrandTotal();
                          }
                        },
                        child: Icon(Icons.remove),
                      ),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          cartCountNotifier.value++;
                          currentProductCountNotifier.value++;
                          ApiServices().updateCartCount(productDetails.id.toString(), currentProductCountNotifier.value);
                          CartScreen().getGrandTotal();
                        },
                        child: Icon(Icons.add),
                      ),
                      Spacer(),
                      Container(
                        child: CustomTextIconButton(
                          onPressed: () {
                            cartCountNotifier.value = (cartCountNotifier.value - newCount).toInt();
                            cartProductsList.remove(productDetails);
                            controller.removeProductFromCart(context, productDetails.product.id.toString());
                            CartScreen().getGrandTotal();
                          },
                          icon: Icons.delete_outline,
                          label: "Remove",
                          textAndIconColor: Colors.red,
                          textAndIconSize: 14,
                        ),
                      ),
                      Spacer(),
                      CustomTextWidget(
                        text: "₹ ${newCount * double.parse(offerPrice)}",
                        fontSize: 12,
                        fontweight: FontWeight.w600,
                      ),
                    ],
                  );
                })
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
