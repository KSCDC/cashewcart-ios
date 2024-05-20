import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
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

  ValueNotifier<bool> useSameAddressNotifier = ValueNotifier(true);

  ValueNotifier<int> deliveryAddressRadioNotifier = ValueNotifier(0);

  ValueNotifier<int> billingAddressRadioNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    double totalProductPrice = 0;

    double cgstTotal = 0;
    double sgstTotal = 0;
    // double totalPriceWithoutGst = 0;

    final screenSize = MediaQuery.of(context).size;
    for (int i = 0; i < productList.length; i++) {
      double sellingPrice = double.parse(productList[i].product.sellingPrice);
      // double cgstPercentage = double.parse(productList[i].product.cgstRate);
      // double sgstPercentage = double.parse(productList[i].product.sgstRate);
      double cgstPrice = double.parse(productList[i].cgstPrice);
      double sgstPrice = double.parse(productList[i].sgstPrice);
      // double originalProductPriceWithoutGst = (sellingPrice - cgstPrice - sgstPrice) * productList[i].purchaseCount;
      cgstTotal += cgstPrice * productList[i].purchaseCount;
      sgstTotal += sgstPrice * productList[i].purchaseCount;
      // totalPriceWithoutGst += originalProductPriceWithoutGst;
      totalProductPrice += sellingPrice * productList[i].purchaseCount;
    }

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
                    if (controller.addressList.isNotEmpty)
                      Row(
                        children: [
                          SizedBox(
                            width: screenSize.width * 0.8,
                            child: CustomTextWidget(
                              text: "Use Delivery Address as Billing Address :",
                              fontweight: FontWeight.w600,
                            ),
                          ),
                          // Default value
                          Spacer(),

                          Checkbox(
                            value: useSameAddressNotifier.value,
                            onChanged: (bool? value) {
                              useSameAddressNotifier.value = value ?? true; // Update the isChecked variable
                            },
                          )
                        ],
                      ),

                    Obx(() {
                      if (controller.addressList.isEmpty) {
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
                        TextEditingController _districtController = TextEditingController();
                        TextEditingController _stateController = TextEditingController();
                        TextEditingController _postalcodeController = TextEditingController();
                        TextEditingController _phoneNumberController = TextEditingController();
                        controller.getUserAddresses();
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
                    // SizedBox(height: 20),
                    // Row(
                    //   children: [
                    //     Icon(CupertinoIcons.ticket),
                    //     kWidth,
                    //     CustomTextWidget(
                    //       text: "Apply Coupons",
                    //       fontSize: 16,
                    //       fontweight: FontWeight.w500,
                    //     ),
                    //     Spacer(),
                    //     CustomTextWidget(
                    //       text: "Select",
                    //       fontColor: kMainThemeColor,
                    //       fontweight: FontWeight.w600,
                    //     )
                    //   ],
                    // ),
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
                          final double total = double.parse(price) * count;
                          // grantTotalNotifier.value = grantTotalNotifier.value + total;
                          return Column(
                            children: [
                              kHeight,
                              if (count != 0)
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: screenSize.width * 0.56,
                                      child: CustomTextWidget(
                                        text: productList[index].product.product.name,
                                        fontSize: 16,
                                        fontweight: FontWeight.w400,
                                      ),
                                    ),
                                    Spacer(),
                                    CustomTextWidget(
                                      text: price,
                                      // fontColor: kMainThemeColor,
                                      fontweight: FontWeight.w600,
                                    ),
                                    CustomTextWidget(text: " * "),
                                    CustomTextWidget(
                                      text: "${count}  : ",
                                      // fontColor: kMainThemeColor,
                                      fontweight: FontWeight.w600,
                                    ),
                                    // Spacer(),
                                    CustomTextWidget(
                                      text: total.toString(),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextWidget(
                          text: "Order Amounts",
                          fontSize: 16,
                          fontweight: FontWeight.w400,
                        ),
                        ValueListenableBuilder(
                            valueListenable: grantTotalNotifier,
                            builder: (context, total, _) {
                              return CustomTextWidget(
                                text: "₹ $totalProductPrice",
                                fontSize: 16,
                                fontweight: FontWeight.w600,
                              );
                            })
                      ],
                    ),
                    kHeight,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextWidget(
                          text: "Total CGST",
                          fontSize: 16,
                          fontweight: FontWeight.w400,
                        ),
                        Spacer(),
                        Column(
                          children: [
                            CustomTextWidget(
                              text: "₹ ${cgstTotal.toStringAsFixed(2)}",
                              fontweight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ],
                    ),
                    kHeight,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextWidget(
                          text: "Total SGST",
                          fontSize: 16,
                          fontweight: FontWeight.w400,
                        ),
                        CustomTextWidget(
                          text: "₹ ${sgstTotal.toStringAsFixed(2)}",
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
                          text: "₹ ${(totalProductPrice + cgstTotal + sgstTotal).toStringAsFixed(2)}",
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
        margin: EdgeInsets.all(20),
        height: 55,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Center(
                  child: CustomTextWidget(
                    text: "₹ ${(totalProductPrice + cgstTotal + sgstTotal).toStringAsFixed(2)} +",
                    fontSize: 16,
                    fontweight: FontWeight.w600,
                  ),
                ),
                CustomTextWidget(text: "Delivery charges")
              ],
            ),
            Container(
              height: 55,
              width: screenSize.width * 0.5,
              child: GestureDetector(
                onTap: () async {
                  if (controller.addressList.isEmpty) {
                    Services().showCustomSnackBar(context, "No address found. Add an address to continue");
                  } else {
                    // context.loaderOverlay.show();
                    proceedToPayment();
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

  proceedToPayment() async {
    List orderingProductsList = [];
    // await controller.getProfileDetails();
    // SharedPreferences sharedPref = await SharedPreferences.getInstance();
    // final String phoneNo = sharedPref.getString(PHONE)!;
    print("List length = $productList");
    for (var product in productList) {
      print("Working loop");
      // final product = item['product'];
      orderingProductsList.add(product);
    }
    print("delivery ${controller.addressList[deliveryAddressRadioNotifier.value].id}");
    print("bill ${controller.addressList[billingAddressRadioNotifier.value].id}");
    final response = await ApiServices().placeOrder(controller.addressList[deliveryAddressRadioNotifier.value].id.toString(), controller.addressList[billingAddressRadioNotifier.value].id.toString());
    if (response != null) {
      // String phoneNumber = response.data['billing_phone_number'].toString();
      // String _orderId = response.data['order_id'].toString();
      final OrdersListModel order = OrdersListModel.fromJson(response.data);

      // print(_orderId);
      Get.off(() => PaymentStartingScreen(orderDetails: order));
    }
  }
}
