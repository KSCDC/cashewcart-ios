import 'package:flutter/material.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/presentation/widgets/custom_star_rating_tile.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class MyOrdersListTile extends StatelessWidget {
  const MyOrdersListTile({
    super.key,
    required this.imagePath,
    required this.name,
    required this.price,
    required this.rating,
    required this.count,
    required this.weight,
    required this.paymentStatus,
  });
  final String imagePath;
  final String name;
  final String price;
  final String rating;
  final String weight;
  final int count;
  final String paymentStatus;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    Color paymentStatusColor = Colors.black;
    String status;
    if (paymentStatus == "SUCCESS") {
      paymentStatusColor = Colors.green;
      status = "SUCCESS";
    } else if (paymentStatus == "PAYMENT_NOT_STARTED") {
      paymentStatusColor = Colors.red;
      status = "NOT STARTED";
    } else {
      paymentStatusColor = Colors.red;
      status = "FAILED";
    }
    return Container(
      // width: screenSize.width * 0.95,
      width: double.infinity,
      // height: 250,
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
                      image: NetworkImage(imagePath),
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
                        width: screenSize.width * 0.52,
                        child: CustomTextWidget(
                          text: name,
                          fontSize: 13,
                          fontweight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const CustomTextWidget(
                            text: "Quantity :",
                            fontSize: 12,
                            fontweight: FontWeight.w500,
                          ),
                          kWidth,
                          CustomTextWidget(
                            text: weight.toString(),
                            fontSize: 12,
                          ),
                          kWidth,
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
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              children: [
                CustomTextWidget(text: "Payment status : "),
                CustomTextWidget(
                  text: status,
                  fontColor: paymentStatusColor,
                ),
              ],
            ),
            kHeight,
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextWidget(
                  text: "Total Order (${count}) :",
                  fontSize: 12,
                  fontweight: FontWeight.w500,
                ),
                CustomTextWidget(
                  text: "₹ ${double.parse(price) * count}",
                  fontSize: 12,
                  fontweight: FontWeight.w600,
                )
              ],
            ),
            SizedBox(height: 5),
            if (paymentStatusColor == Colors.green)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomTextWidget(
                    text: "Delivery Expected By :",
                    fontSize: 12,
                    fontweight: FontWeight.w500,
                  ),
                  CustomTextWidget(
                    text: "28/03/2024",
                    fontSize: 12,
                    fontweight: FontWeight.w600,
                  )
                ],
              ),
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
