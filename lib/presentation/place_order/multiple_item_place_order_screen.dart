import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/controllers/profile_controller.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/core/razorpay_key/razorpay_key.dart';
import 'package:internship_sample/models/cart_product_model.dart';
import 'package:internship_sample/models/orders_list_model.dart';
import 'package:internship_sample/presentation/cart/cart_screen.dart';
import 'package:internship_sample/presentation/checkout/checkout_screen.dart';
import 'package:internship_sample/presentation/cart/widgets/cart_product_list_tile.dart';
import 'package:internship_sample/presentation/main_page/main_page_screen.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/my_orders/my_orders_screen.dart';
import 'package:internship_sample/presentation/payment_starting/payment_starting_screen.dart';
import 'package:internship_sample/presentation/place_order/place_order_dropdown.dart';
import 'package:internship_sample/presentation/place_order/widgets/address_section.dart';
import 'package:internship_sample/presentation/place_order/widgets/place_order_item_widget.dart';
import 'package:internship_sample/presentation/shop/widgets/custom_text_icon_button.dart';
import 'package:internship_sample/presentation/widgets/custom_appbar.dart';
import 'package:internship_sample/presentation/widgets/custom_elevated_button.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/services/api_services.dart';
import 'package:internship_sample/services/services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MultipleItemPlaceOrderScreen extends StatelessWidget {
  MultipleItemPlaceOrderScreen({super.key, required this.productList, required this.grandTotal});
  final List<Result> productList;
  final double grandTotal;
  AppController controller = Get.put(AppController());
  ProfileController profileController = Get.put(ProfileController());

  ValueNotifier<bool> useSameAddressNotifier = ValueNotifier(true);

  ValueNotifier<int> deliveryAddressRadioNotifier = ValueNotifier(0);

  ValueNotifier<int> billingAddressRadioNotifier = ValueNotifier(0);
  double deliveryCharge = 0;
  double additionalCharges = 0;

  @override
  Widget build(BuildContext context) {
    
    double totalProductPrice = 0;

    double cgstTotal = 0;
    double sgstTotal = 0;
    double priceWithGST = 0;

    // double totalPriceWithoutGst = 0;

    final screenSize = MediaQuery.of(context).size;
    for (int i = 0; i < productList.length; i++) {
      // double sellingPrice = double.parse(productList[i].product.sellingPrice);
      double cgstPrice = double.parse(productList[i].product.sellingPrice) * (double.parse(productList[i].product.cgstRate) / 100);
      double sgstPrice = double.parse(productList[i].product.sellingPrice) * (double.parse(productList[i].product.cgstRate) / 100);
      double sellingPrice = double.parse(productList[i].product.sellingPrice);
      cgstTotal += cgstPrice * productList[i].purchaseCount;
      sgstTotal += sgstPrice * productList[i].purchaseCount;
      // totalPriceWithoutGst += originalProductPriceWithoutGst;
      totalProductPrice += ((sellingPrice + cgstPrice + sgstPrice) * productList[i].purchaseCount).roundToDouble();
      deliveryCharge = ((double.parse(profileController.addressList[deliveryAddressRadioNotifier.value].deliveryChargePercentage) / 100) * totalProductPrice).roundToDouble();
      additionalCharges = ((double.parse(profileController.addressList[deliveryAddressRadioNotifier.value].additionalChargePercentage) / 100) * totalProductPrice).roundToDouble();
    }
    log(deliveryCharge.toString());

    return Scaffold(
      appBar: CustomAppBar(
        title: "Place Order",
      ),
      backgroundColor: appBackgroundColor,
      body: LoaderOverlay(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          // final int selectedCategory = productList[index]['category'];

                          // final int count = productList[index].purchaseCount;
                          final int count = productList[index].purchaseCount;

                          return Column(
                            children: [
                              kHeight,
                              if (count != 0)
                                PlaceOrderItemWidget(
                                  imagePath: productList[index].product.product.productImages.isNotEmpty ? productList[index].product.product.productImages[0].productImage : '',
                                  productName: productList[index].product.product.name,
                                  productDescription: productList[index].product.product.description,
                                  count: count,
                                ),
                              Divider(
                                thickness: 0.3,
                              )
                            ],
                          );
                        },
                        itemCount: productList.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                      ),
                    ),
                    kHeight,
                    //delivery addresses
                    if (profileController.addressList.isNotEmpty)
                      ValueListenableBuilder(
                          valueListenable: useSameAddressNotifier,
                          builder: (context, newValue, _) {
                            return Row(
                              children: [
                                SizedBox(
                                  // width: screenSize.width * 0.8,
                                  child: CustomTextWidget(
                                    text: "Use same Delivery Address\nand Billing Address :",
                                    fontweight: FontWeight.w600,
                                  ),
                                ),
                                // Default value
                                Spacer(),

                                Checkbox(
                                  value: newValue,
                                  onChanged: (bool? value) {
                                    useSameAddressNotifier.value = value ?? true; // Update the isChecked variable
                                  },
                                )
                              ],
                            );
                          }),
                    kHeight,

                    Obx(() {
                      if (profileController.addressList.isEmpty) {
                        useSameAddressNotifier.value = false;
                        return CustomTextWidget(text: "No saved addresses!");
                      } else {
                        return AddressSection(
                          screenSize: screenSize,
                          heading: "Delivery Address",
                          selectedRadioNotifier: deliveryAddressRadioNotifier,
                        );
                      }
                    }),
                    kHeight,
                    ValueListenableBuilder(
                        valueListenable: useSameAddressNotifier,
                        builder: (context, hide, _) {
                          if (hide) {
                            billingAddressRadioNotifier.value = deliveryAddressRadioNotifier.value;
                            return SizedBox();
                          } else {
                            return AddressSection(
                              screenSize: screenSize,
                              heading: "Billing Address",
                              selectedRadioNotifier: billingAddressRadioNotifier,
                            );
                          }
                        }),
                    SizedBox(height: 5),

                    // add new address button
                    CustomTextIconButton(
                      onPressed: () async {
                        TextEditingController _nameContrller = TextEditingController();
                        TextEditingController _streetAddressContrller = TextEditingController();
                        TextEditingController _regionController = TextEditingController();
                        TextEditingController _postalcodeController = TextEditingController();
                        TextEditingController _phoneNumberController = TextEditingController();
                        profileController.getUserAddresses();
                        await Services().showAddressEditPopup(
                          true,
                          context,
                          "",
                          "ADD ADDRESS",
                          "ADD",
                          _nameContrller,
                          _streetAddressContrller,
                          _regionController,
                          _postalcodeController,
                          _phoneNumberController,
                        );
                      },
                      icon: Icons.add,
                      label: "Add address",
                      textAndIconColor: Colors.black,
                      textAndIconSize: 12,
                    ),

                    kHeight,
                    Divider(),
                    SizedBox(height: 20),
                    CustomTextWidget(
                      text: "Order Payment Details",
                      fontSize: 17,
                      fontweight: FontWeight.w600,
                    ),
                    Container(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          // final int selectedCategory = productList[index]['category'];
                          final String price = productList[index].product.sellingPrice.toString();
                          final int count = productList[index].purchaseCount;

                          double cgstPrice = double.parse(productList[index].product.sellingPrice) * (double.parse(productList[index].product.cgstRate) / 100);
                          double sgstPrice = double.parse(productList[index].product.sellingPrice) * (double.parse(productList[index].product.cgstRate) / 100);
                          double sellingPrice = double.parse(productList[index].product.sellingPrice);
                          priceWithGST = sellingPrice + cgstPrice + sgstPrice;
                          final double total = priceWithGST * count;
                          // grantTotalNotifier.value = grantTotalNotifier.value + total;
                          return Column(
                            children: [
                              kHeight,
                              if (count != 0)
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: screenSize.width * 0.62,
                                      child: CustomTextWidget(
                                        text: productList[index].product.product.name + " - ( ${priceWithGST.toStringAsFixed(2)} * ${count} )",
                                        fontSize: 13.sp,
                                        fontweight: FontWeight.w500,
                                      ),
                                    ),
                                    Spacer(),
                                    CustomTextWidget(
                                      text: "₹ ${(total.round()).toStringAsFixed(2)}",
                                      // fontColor: kMainThemeColor,
                                      fontweight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                            ],
                          );
                        },
                        itemCount: productList.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                      ),
                    ),
                    SizedBox(height: 20),

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
                          text: "₹ ${(totalProductPrice).toStringAsFixed(2)}",
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
                          text: "Delivery Charge",
                          fontSize: 17,
                          fontweight: FontWeight.w600,
                        ),
                        CustomTextWidget(
                          text: "₹ ${(deliveryCharge).toStringAsFixed(2)}",
                          fontSize: 16,
                          fontweight: FontWeight.w600,
                        )
                      ],
                    ),
                    kHeight,
                    // Row(
                    //   children: [
                    //     CustomTextWidget(
                    //       text: "EMI Available",
                    //       fontSize: 16,
                    //       fontweight: FontWeight.w400,
                    //     ),
                    //     SizedBox(width: 20),
                    //     CustomTextWidget(
                    //       text: "Details",
                    //       fontColor: kMainThemeColor,
                    //       fontweight: FontWeight.w600,
                    //     ),
                    //   ],
                    // ),
                    SizedBox(height: 100),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        margin: EdgeInsets.all(20.r),
        height: 55.w,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextWidget(
                  text: "Grand Total",
                  fontSize: 18.sp,
                  fontweight: FontWeight.w600,
                ),
                CustomTextWidget(
                  text: "₹ ${(totalProductPrice + deliveryCharge + additionalCharges).toStringAsFixed(2)}",
                  fontSize: 18.sp,
                  fontweight: FontWeight.w600,
                ),
              ],
            ),
            SizedBox(width: 10),
            Container(
              height: 55,
              width: screenSize.width * 0.5,
              child: GestureDetector(
                onTap: () async {
                  if (profileController.addressList.isEmpty) {
                    Services().showCustomSnackBar(context, "No address found. Add an address to continue");
                  } else {
                    Get.to(
                      () => PaymentStartingScreen(
                        productsList: productList,
                        deliveryAddress: profileController.addressList[deliveryAddressRadioNotifier.value],
                        billingAddress: profileController.addressList[billingAddressRadioNotifier.value],
                        deliveryCharge: deliveryCharge,
                        additionalAmount: additionalCharges,
                      ),
                    );
                  }
                },
                child: CustomElevatedButton(
                  label: "Next",
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
