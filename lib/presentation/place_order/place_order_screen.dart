import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cashew_cart/controllers/app_controller.dart';
import 'package:cashew_cart/controllers/profile_controller.dart';
import 'package:cashew_cart/core/base_url.dart';
import 'package:cashew_cart/core/colors.dart';
import 'package:cashew_cart/core/constants.dart';
import 'package:cashew_cart/models/product_details_model.dart';
import 'package:cashew_cart/presentation/cart/cart_screen.dart';
import 'package:cashew_cart/presentation/checkout/checkout_screen.dart';

import 'package:cashew_cart/presentation/place_order/widgets/address_section.dart';
import 'package:cashew_cart/presentation/place_order/widgets/address_tile.dart';
import 'package:cashew_cart/presentation/shop/widgets/custom_text_icon_button.dart';
import 'package:cashew_cart/presentation/shop/widgets/shop_product_details_tile.dart';
import 'package:cashew_cart/presentation/widgets/custom_appbar.dart';
import 'package:cashew_cart/presentation/widgets/custom_elevated_button.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';
import 'package:cashew_cart/services/services.dart';

// int selectedAddressIndex = -1;

ValueNotifier<int> productCountNotifier = ValueNotifier(1);

class PlaceOrderScreen extends StatelessWidget {
  PlaceOrderScreen({
    super.key,
    required this.productDetails,
  });
  final ProductDetailsModel productDetails;
  // TextEditingController _textEditingController = TextEditingController(text: "216 St Paul's Rd, London N1 2LL, UK, \nContact :  +44-784232 ");
  AppController controller = Get.put(AppController());
  ProfileController profileController = Get.put(ProfileController());
  TextEditingController _streetAddressConrller = TextEditingController();
  TextEditingController _regionController = TextEditingController();
  TextEditingController _districtController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _postalcodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final int category = productDetails['category'];
    final String imagePath = productDetails.productImages.isNotEmpty ? "$baseUrl${productDetails.productImages[0].productImage}" : "";
    final String name = productDetails.name;
    final String description = productDetails.description;
    final String price = productDetails.productVariants[sizeSelectNotifier.value].sellingPrice;

    final screenSize = MediaQuery.of(context).size;

    // !This page was designed to buy a product directly from product details screen without adding to the cart. But according
    // !to the backend user can place order only after adding it into the cart. So this screen is not used.
    return Scaffold(
      appBar: CustomAppBar(
        title: "Place Orderr",
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
                                    return CustomTextWidget(text: "Nos : ${newCount}");
                                  },
                                ),
                                SizedBox(width: 20),
                                GestureDetector(
                                  onTap: () {
                                    if (productCountNotifier.value != 1) productCountNotifier.value--;
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

                  // Obx(() {
                  //   // return controller.addressList.isEmpty ? CustomTextWidget(text: "No saved addresses!") : AddressSection(screenSize: screenSize,heading: "Delivery Address");
                  // }),

                  SizedBox(height: 5),

                  // add new address button
                  CustomTextIconButton(
                    onPressed: () async {
                      // TextEditingController _newAddressController = TextEditingController();

                      // Services().showAddressEditPopup(
                      //   true,
                      //   context,
                      //   "",
                      //   "ADD ADDRESS",
                      //   "ADD",
                      //   _streetAddressConrller,
                      //   _regionController,
                      //   _districtController,
                      //   _stateController,
                      //   _postalcodeController,
                      // );
                    },
                    icon: Icons.add,
                    label: "Add address",
                    textAndIconColor: Colors.black,
                    textAndIconSize: 12,
                  ),

                  SizedBox(height: 20),

                  Row(
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
                  final double total = double.parse(price) * productCountNotifier.value;
                  if (total <= 500) {
                    Services().showCustomSnackBar(context, "Minimum order amount is Rs 500 and above");
                  } else if (profileController.addressList.isEmpty) {
                    Services().showCustomSnackBar(context, "No address found. Add an address to continue");
                  } else {
                    Get.to(
                      () => CheckoutScreen(
                        price: total,
                        shippingCost: 30,
                        orderingProductsList: [productDetails],
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
