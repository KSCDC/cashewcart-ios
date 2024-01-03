import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constatns.dart';
import 'package:internship_sample/presentation/checkout/checkout_screen.dart';
import 'package:internship_sample/presentation/kart/widgets/cart_product_list_tile.dart';
import 'package:internship_sample/presentation/place_order/place_order_dropdown.dart';
import 'package:internship_sample/presentation/widgets/custom_appbar.dart';
import 'package:internship_sample/presentation/widgets/custom_elevated_button.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

List<String> sizeList = ["42", "44"];
List<String> quantityList = ["1", "2"];

class PlaceOrderScreen extends StatelessWidget {
  const PlaceOrderScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Place Order",
      ),
      backgroundColor: appBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 125,
                      width: 130,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("lib/core/assets/images/product_images/home/kurtha.jpg"),
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
                            text: "Women’s Casual Wear",
                            fontweight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: 200,
                            child: CustomTextWidget(
                              text: "Checked Single-Breasted Blazer",
                              fontSize: 13,
                              fontweight: FontWeight.w400,
                            ),
                          ),
                          kHeight,
                          kHeight,
                          Row(
                            children: [
                              Container(
                                color: Color(0xFFF2F2F2),
                                height: 35,
                                width: 90,
                                child: Row(
                                  children: [
                                    CustomTextWidget(text: "Size"),
                                    SizedBox(width: 5),
                                    PlaceOrderDropDown(itemsList: sizeList),
                                  ],
                                ),
                              ),
                              kWidth,
                              Container(
                                color: Color(0xFFF2F2F2),
                                height: 35,
                                width: 90,
                                child: Row(
                                  children: [CustomTextWidget(text: "Qty"), SizedBox(width: 5), PlaceOrderDropDown(itemsList: sizeList)],
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
                                text: "10 May 2XXX",
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
                Row(
                  children: [
                    Icon(CupertinoIcons.ticket),
                    kWidth,
                    CustomTextWidget(
                      text: "Apply Coupons",
                      fontSize: 16,
                      fontweight: FontWeight.w500,
                    ),
                    Spacer(),
                    CustomTextWidget(
                      text: "Select",
                      fontColor: kMainThemeColor,
                      fontweight: FontWeight.w600,
                    )
                  ],
                ),
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
                      text: "₹ 7,000",
                      fontSize: 16,
                      fontweight: FontWeight.w600,
                    )
                  ],
                ),
                kHeight,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextWidget(
                      text: "Convenience",
                      fontSize: 16,
                      fontweight: FontWeight.w400,
                    ),
                    SizedBox(width: 20),
                    CustomTextWidget(
                      text: "Know More",
                      fontColor: kMainThemeColor,
                      fontweight: FontWeight.w600,
                    ),
                    Spacer(),
                    CustomTextWidget(
                      text: "Apply Coupon",
                      fontColor: kMainThemeColor,
                      fontweight: FontWeight.w600,
                    ),
                  ],
                ),
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
                      text: "Order Total",
                      fontSize: 17,
                      fontweight: FontWeight.w600,
                    ),
                    CustomTextWidget(
                      text: "₹ 7,000",
                      fontSize: 16,
                      fontweight: FontWeight.w600,
                    )
                  ],
                ),
                kHeight,
                Row(
                  children: [
                    CustomTextWidget(
                      text: "EMI Available",
                      fontSize: 16,
                      fontweight: FontWeight.w400,
                    ),
                    SizedBox(width: 20),
                    CustomTextWidget(
                      text: "Details",
                      fontColor: kMainThemeColor,
                      fontweight: FontWeight.w600,
                    ),
                  ],
                ),
                SizedBox(height: 140),
                Container(
                  height: 55,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          CustomTextWidget(
                            text: "₹ 7,000.00",
                            fontSize: 16,
                            fontweight: FontWeight.w600,
                          ),
                          CustomTextWidget(
                            text: "View Details",
                            fontColor: kMainThemeColor,
                            fontweight: FontWeight.w600,
                          ),
                        ],
                      ),
                      Container(
                        height: 55,
                        width: 250,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CheckoutScreen(),
                            ),
                          ),
                          child: CustomElevatedButton(label: "Proceed to Payment"),
                        ),
                      )
                    ],
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
