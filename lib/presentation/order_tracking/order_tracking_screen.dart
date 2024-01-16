import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constatns.dart';
import 'package:internship_sample/presentation/checkout/checkout_screen.dart';
import 'package:internship_sample/presentation/cart/widgets/cart_product_list_tile.dart';
import 'package:internship_sample/presentation/order_tracking/widgets/custom_timeline_tile.dart';
import 'package:internship_sample/presentation/place_order/place_order_dropdown.dart';
import 'package:internship_sample/presentation/widgets/custom_appbar.dart';
import 'package:internship_sample/presentation/widgets/custom_elevated_button.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({
    super.key,
    required this.imagePath,
    required this.productName,
    required this.productDescription,
    required this.price,
  });
  final String imagePath;
  final String productName;
  final String productDescription;
  final String price;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Product Details",
      ),
      backgroundColor: appBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          height: 125,
                          width: screenSize.width * 0.25,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(imagePath),
                              fit: BoxFit.fitWidth,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 250,
                              child: CustomTextWidget(
                                text: productName,
                                fontweight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: screenSize.width * 0.6,
                              child: CustomTextWidget(
                                text: productDescription,
                                fontSize: 13,
                                fontweight: FontWeight.w400,
                              ),
                            ),
                            kHeight,
                            kHeight,
                            Row(
                              children: [
                                Container(
                                  height: 35,
                                  child: Row(
                                    children: [
                                      CustomTextWidget(
                                        text: "Wt:",
                                        fontweight: FontWeight.w600,
                                      ),
                                      SizedBox(width: 5),
                                      CustomTextWidget(text: "250GM"),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 20),
                                Container(
                                  height: 35,
                                  child: Row(
                                    children: [
                                      CustomTextWidget(
                                        text: "Qty: ",
                                        fontweight: FontWeight.w600,
                                      ),
                                      SizedBox(width: 5),
                                      CustomTextWidget(text: "1"),
                                    ],
                                  ),
                                ),
                                kWidth,
                              ],
                            ),
                            kHeight,
                            Row(
                              children: [
                                CustomTextWidget(
                                  text: "Delivery by",
                                  fontSize: 13,
                                  fontweight: FontWeight.w400,
                                ),
                                kWidth,
                                CustomTextWidget(
                                  text: "18 Jan 2024",
                                  fontSize: 13,
                                  fontweight: FontWeight.w600,
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  kHeight,
                  SizedBox(height: 20),
                  kHeight,
                  Divider(),
                  SizedBox(height: 20),
                  CustomTextWidget(
                    text: "Order Payment Details",
                    fontSize: 17,
                    fontweight: FontWeight.w500,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextWidget(
                        text: "Order Amounts",
                        fontSize: 16,
                        fontweight: FontWeight.w400,
                      ),
                      CustomTextWidget(
                        text: "₹ $price",
                        fontSize: 16,
                        fontweight: FontWeight.w600,
                      )
                    ],
                  ),
                  kHeight,
                  kHeight,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextWidget(
                        text: "Delivery Fee",
                        fontSize: 16,
                        fontweight: FontWeight.w400,
                      ),
                      CustomTextWidget(
                        text: "Free",
                        fontColor: kMainThemeColor,
                        fontweight: FontWeight.w600,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Divider(),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextWidget(
                        text: "Total Paid",
                        fontSize: 17,
                        fontweight: FontWeight.w600,
                      ),
                      CustomTextWidget(
                        text: "₹ $price",
                        fontSize: 16,
                        fontweight: FontWeight.w600,
                      )
                    ],
                  ),
                  kHeight,
                  CustomTimelineTile(
                    isFirst: true,
                    isCompleted: true,
                    cardTitle: "Order Placed",
                    dateAndTime: "Completed on 15/01/2024 - 10AM",
                  ),
                  CustomTimelineTile(
                    isCompleted: true,
                    cardTitle: "Product Shipped",
                    dateAndTime: "Completed on 16/01/2024 - 2PM",
                  ),
                  CustomTimelineTile(
                    cardTitle: "Arrival at Nearest Hub",
                    dateAndTime: "Expected on 18/01/2024 - 11AM",
                  ),
                  CustomTimelineTile(
                    isLast: true,
                    cardTitle: "Out of Delivery",
                    dateAndTime: "Expected on 18/01/2024 - 5PM",
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
