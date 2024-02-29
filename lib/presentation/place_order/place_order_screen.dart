import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/presentation/cart/cart_screen.dart';
import 'package:internship_sample/presentation/checkout/checkout_screen.dart';
import 'package:internship_sample/presentation/cart/widgets/cart_product_list_tile.dart';
import 'package:internship_sample/presentation/home/home_screen.dart';
import 'package:internship_sample/presentation/place_order/place_order_dropdown.dart';
import 'package:internship_sample/presentation/place_order/widgets/address_section.dart';
import 'package:internship_sample/presentation/place_order/widgets/address_tile.dart';
import 'package:internship_sample/presentation/shop/widgets/custom_text_icon_button.dart';
import 'package:internship_sample/presentation/widgets/custom_appbar.dart';
import 'package:internship_sample/presentation/widgets/custom_elevated_button.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

// int selectedAddressIndex = -1;
var _oneValue = '';

var _twoValue = '';

var _threeValue = '';
final List<String> three = ["1", "2", "3", "4", "5"];

class PlaceOrderScreen extends StatelessWidget {
  PlaceOrderScreen({
    super.key,
    required this.productDetails,
  });
  final productDetails;
  TextEditingController _textEditingController = TextEditingController(
      text: "216 St Paul's Rd, London N1 2LL, UK, \nContact :  +44-784232 ");
  @override
  Widget build(BuildContext context) {
    final int category = productDetails['category'];
    final String imagePath = productDetails['product']['imagePath'][0];
    final String name = productDetails['product']['name'];
    final String description =
        productDetails['product']['category'][category]['description'];
    final String price =
        productDetails['product']['category'][category]['offerPrice'];
    // final String rating = productDetails['product']['category'][category]['rating'];
    // final String weight = productDetails['product']['category'][category]['weight'];

    final int count = productDetails['count'];

    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Place Order",
      ),
      backgroundColor: appBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          height: 100,
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
                                text: name,
                                fontweight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: screenSize.width * 0.6,
                              child: CustomTextWidget(
                                text: description,
                                fontSize: 14,
                                fontweight: FontWeight.w400,
                              ),
                            ),
                            kHeight,
                            Row(
                              children: [
                                ValueListenableBuilder(
                                  valueListenable: productCountNotifier,
                                  builder: (context, newCount, _) {
                                    productDetails['count'] = newCount;
                                    return CustomTextWidget(
                                        text: "Nos : ${newCount}");
                                  },
                                ),
                                SizedBox(width: 20),
                                GestureDetector(
                                  onTap: () {
                                    if (productCountNotifier.value != 1)
                                      productCountNotifier.value--;
                                  },
                                  child: Icon(Icons.remove),
                                ),
                                SizedBox(width: 5),
                                GestureDetector(
                                  onTap: () {
                                    productCountNotifier.value++;
                                  },
                                  child: Icon(Icons.add),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  kHeight,

                  //delivery addresses

                  if (deliveryAddressControllers.isEmpty)
                    CustomTextWidget(text: "No saved addresses!")
                  else
                    AddressSection(screenSize: screenSize),

                  SizedBox(height: 5),

                  // add new address button
                  CustomTextIconButton(
                    onPressed: () async {
                      TextEditingController _newAddressController =
                          TextEditingController();

                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            insetAnimationDuration:
                                Duration(milliseconds: 1000),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              width: screenSize.width * 0.9,
                              height: screenSize.width * 0.8,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    kHeight,
                                    CustomTextWidget(
                                        text: "Enter new address here"),
                                    SizedBox(height: 5),
                                    TextField(
                                      controller: _newAddressController,
                                      maxLines:
                                          4, // Set to null for an unlimited number of lines
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    GestureDetector(
                                      onTap: () {
                                        deliveryAddressControllers
                                            .add(_newAddressController);
                                        Navigator.of(context).pop();
                                      },
                                      child: CustomElevatedButton(
                                        label: "Submit",
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    icon: Icons.add,
                    label: "Add address",
                    textAndIconColor: Colors.black,
                    textAndIconSize: 12,
                  ),

                  SizedBox(height: 20),

                  const Row(
                    children: [
                      Icon(CupertinoIcons.ticket),
                      kWidth,
                      CustomTextWidget(
                        text: "Apply Coupons",
                        fontSize: 14,
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
                  ValueListenableBuilder(
                      valueListenable: productCountNotifier,
                      builder: (context, newCount, _) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextWidget(
                              text: "Order Amounts",
                              fontSize: 14,
                              fontweight: FontWeight.w400,
                            ),
                            CustomTextWidget(
                              text: "${double.parse(price)} * ${newCount}",
                              fontSize: 14,
                              fontweight: FontWeight.w600,
                            ),
                            CustomTextWidget(
                              text: "₹ ${double.parse(price) * newCount}",
                              fontSize: 14,
                              fontweight: FontWeight.w600,
                            )
                          ],
                        );
                      }),
                  kHeight,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextWidget(
                        text: "Convenience",
                        fontSize: 14,
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
                        fontSize: 14,
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
                      ValueListenableBuilder(
                        valueListenable: productCountNotifier,
                        builder: (context, newCount, _) {
                          return CustomTextWidget(
                            text: "₹ ${double.parse(price) * newCount}",
                            fontSize: 14,
                            fontweight: FontWeight.w600,
                          );
                        },
                      )
                    ],
                  ),
                  kHeight,
                  SizedBox(height: 50),
                ],
              ),
            )
          ],
        ),
      ),
      bottomSheet: Container(
        margin: EdgeInsets.all(20),
        height: 55,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ValueListenableBuilder(
              valueListenable: productCountNotifier,
              builder: (context, newCount, _) {
                return CustomTextWidget(
                  text: "₹ ${double.parse(price) * newCount}",
                  fontSize: 14,
                  fontweight: FontWeight.w600,
                );
              },
            ),
            Container(
              height: 55,
              width: 250,
              child: GestureDetector(
                onTap: () {
                  final double total =
                      double.parse(price) * productCountNotifier.value;
                  if (total <= 500) {
                    const snackBar = SnackBar(
                      content: Text('Minimum order amount is Rs 500 and above'),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(20),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CheckoutScreen(
                          price: total,
                          shippingCost: 30,
                          orderingProductsList: [productDetails],
                        ),
                      ),
                    );
                  }
                },
                child: CustomElevatedButton(label: "Proceed to Payment"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
