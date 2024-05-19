import 'package:flutter/material.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/presentation/cart/widgets/cart_product_list_tile.dart';
import 'package:internship_sample/presentation/shop/widgets/custom_text_icon_button.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartItemSkeleton extends StatelessWidget {
  const CartItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Skeletonizer(
      enabled: true,
      child: Column(
        children: [
          kHeight,
          Container(
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
                            image: NetworkImage(""),
                            fit: BoxFit.fitHeight,
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
                                text: "productName",
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
                                  label: "weight",
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            kHeight,
                            Row(
                              children: [
                                CustomTextWidget(
                                  text: "5",
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
                                  label: "₹ 100",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                kWidth,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextWidget(
                                      text: "123%",
                                      fontColor: Color(0xFFFE735C),
                                      fontSize: 10,
                                      fontweight: FontWeight.w400,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "price",
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
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextWidget(
                        text: "Total Order 3) :",
                        fontSize: 12,
                        fontweight: FontWeight.w500,
                      ),
                      kWidth,
                      GestureDetector(
                        onTap: () {},
                        child: Icon(Icons.remove),
                      ),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(Icons.add),
                      ),
                      Spacer(),
                      Container(
                        child: CustomTextIconButton(
                          onPressed: () {},
                          icon: Icons.delete_outline,
                          label: "Remove",
                          textAndIconColor: Colors.red,
                          textAndIconSize: 14,
                        ),
                      ),
                      Spacer(),
                      CustomTextWidget(
                        text: "₹ price",
                        fontSize: 12,
                        fontweight: FontWeight.w600,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
