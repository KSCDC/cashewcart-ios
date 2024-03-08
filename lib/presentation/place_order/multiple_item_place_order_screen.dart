import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/models/cart_product_model.dart';
import 'package:internship_sample/presentation/cart/cart_screen.dart';
import 'package:internship_sample/presentation/checkout/checkout_screen.dart';
import 'package:internship_sample/presentation/cart/widgets/cart_product_list_tile.dart';
import 'package:internship_sample/presentation/place_order/place_order_dropdown.dart';
import 'package:internship_sample/presentation/place_order/widgets/address_section.dart';
import 'package:internship_sample/presentation/place_order/widgets/place_order_item_widget.dart';
import 'package:internship_sample/presentation/shop/widgets/custom_text_icon_button.dart';
import 'package:internship_sample/presentation/widgets/custom_appbar.dart';
import 'package:internship_sample/presentation/widgets/custom_elevated_button.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/services/api_services.dart';
import 'package:internship_sample/services/services.dart';

class MultipleItemPlaceOrderScreen extends StatelessWidget {
  MultipleItemPlaceOrderScreen({super.key, required this.productList});
  final List<Result> productList;
  AppController controller = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    double grandTotal = getGrandTotal();
    controller.getUserAddresses();
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

                  kHeight,

                  Obx(() {
                    return controller.addressList.isEmpty ? CustomTextWidget(text: "No saved addresses!") : AddressSection(screenSize: screenSize);
                  }),

                  SizedBox(height: 5),

                  // add new address button
                  CustomTextIconButton(
                    onPressed: () async {
                      TextEditingController _streetAddressConrller = TextEditingController();
                      TextEditingController _cityController = TextEditingController();
                      TextEditingController _postalcodeController = TextEditingController();
                      TextEditingController _stateController = TextEditingController();
                      Services().showAddressEditPopup(true, context, "", "ADD ADDRESS", "ADD", _streetAddressConrller, _cityController, _postalcodeController, _stateController);
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
                  Container(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        // final int selectedCategory = productList[index]['category'];
                        final String price = productList[index].product.sellingPrice;
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
                                  CustomTextWidget(
                                    text: productList[index].product.product.name,
                                    fontSize: 11,
                                    fontweight: FontWeight.w400,
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
                      CustomTextWidget(
                        text: "₹ ${grandTotal.toStringAsFixed(2)}",
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
                        text: "₹ ${grandTotal.toStringAsFixed(2)}",
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
            Center(
              child: CustomTextWidget(
                text: "₹ ${grandTotal.toStringAsFixed(2)}",
                fontSize: 16,
                fontweight: FontWeight.w600,
              ),
            ),
            Container(
              height: 55,
              width: 250,
              child: GestureDetector(
                onTap: () {
                  List orderingProductsList = [];
                  for (var product in productList) {
                    // final product = item['product'];
                    orderingProductsList.add(product);
                  }
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CheckoutScreen(
                        price: grandTotal,
                        shippingCost: 30,
                        orderingProductsList: productList,
                      ),
                    ),
                  );
                },
                child: CustomElevatedButton(label: "Proceed to Payment"),
              ),
            )
          ],
        ),
      ),
    );
  }

  getGrandTotal() {
    // grantTotalNotifier.value = 0;
    log("grand total fn");
    for (int i = 0; i < cartProductsList.length; i++) {
      final int selectedCategory = cartProductsList[i]['category'];
      final String price = cartProductsList[i]['product']['category'][selectedCategory]['offerPrice'];
      final int count = cartProductsList[i]['count'];
      final double total = double.parse(price) * count;
      print("prices are ${price} * ${count}== ${total}");
      grantTotalNotifier.value = grantTotalNotifier.value + total;
    }
    log("GTOT:${grantTotalNotifier.value}");
    return grantTotalNotifier.value;
  }
}
