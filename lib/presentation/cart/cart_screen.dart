import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cashew_cart/controllers/app_controller.dart';
import 'package:cashew_cart/controllers/cart_controller.dart';
import 'package:cashew_cart/controllers/profile_controller.dart';
import 'package:cashew_cart/core/colors.dart';
import 'package:cashew_cart/core/constants.dart';
import 'package:cashew_cart/main.dart';
import 'package:cashew_cart/presentation/cart/widgets/cart_item_skeleton.dart';
import 'package:cashew_cart/presentation/cart/widgets/cart_product_list_tile.dart';
import 'package:cashew_cart/presentation/widgets/no_access_tile.dart';
import 'package:cashew_cart/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:cashew_cart/presentation/place_order/multiple_item_place_order_screen.dart';
import 'package:cashew_cart/presentation/shop/widgets/custom_text_icon_button.dart';
import 'package:cashew_cart/presentation/splash/splash_screen.dart';
import 'package:cashew_cart/presentation/widgets/custom_appbar.dart';
import 'package:cashew_cart/presentation/widgets/custom_elevated_button.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';
import 'package:cashew_cart/services/api_services.dart';
import 'package:cashew_cart/services/services.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';

List cartProductsList = [];
ValueNotifier<double> grantTotalNotifier = ValueNotifier(0);

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);
  AppController controller = Get.put(AppController());
  CartController cartController = Get.put(CartController());
  ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    grantTotalNotifier.value = 0;

    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: CustomTextWidget(
          text: "Cart",
          fontSize: 18,
          fontweight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kHeight,
              Obx(() {
                getGrandTotal();
                print("cart count ${cartController.cartProducts.value.count}");
                if (!controller.isLoggedIn.value) {
                  log("Not logged in");
                  return NoAccessTile();
                } else if (cartController.isLoading.value) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return CartItemSkeleton();
                    },
                    itemCount: 3,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  );
                } else {
                  return cartController.cartProducts.value.count == 0
                      ? Column(
                          children: [
                            CustomTextWidget(
                              text: "Your cart is empty. Please add items to continue purchase.",
                              fontSize: 14.sp,
                              fontweight: FontWeight.w600,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: screenSize.height * 0.25),
                            SizedBox(
                              child: Lottie.asset("lib/core/assets/lottie/cart_empty.json"),
                            ),
                          ],
                        )
                      : cartController.cartProducts.value.count != 0
                          ? Column(
                              children: [
                                Container(
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          kHeight,
                                          CartProductsListTile(
                                            productDetails: cartController.cartProducts.value.results[index],
                                            index: index,
                                          ),
                                        ],
                                      );
                                    },
                                    itemCount: cartController.cartProducts.value.count,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CustomTextWidget(
                                      text: "Total : ₹ ",
                                      fontSize: 15.sp,
                                      fontweight: FontWeight.w600,
                                    ),
                                    ValueListenableBuilder(
                                        valueListenable: grantTotalNotifier,
                                        builder: (context, grandTotal, _) {
                                          return CustomTextWidget(
                                            text: grandTotal.toStringAsFixed(2),
                                            fontSize: 15.sp,
                                            fontweight: FontWeight.w600,
                                          );
                                        })
                                  ],
                                ),
                                kHeight,
                                GestureDetector(
                                  onTap: () async {
                                    if (grantTotalNotifier.value <= 500) {
                                      const snackBar = SnackBar(
                                        content: Text('Minimum order amount is Rs 500 and above'),
                                        // behavior: SnackBarBehavior.floating,
                                        // margin: EdgeInsets.all(10),
                                        padding: EdgeInsets.all(20),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    } else {
                                      await profileController.getUserAddresses();
                                      await cartController.getCartList();
                                      Get.to(
                                        () => MultipleItemPlaceOrderScreen(
                                          productList: cartController.cartProducts.value.results,
                                          grandTotal: grantTotalNotifier.value,
                                        ),
                                      );
                                    }
                                  },
                                  child: CustomElevatedButton(
                                    label: "Place Order",
                                    fontSize: 16.sp,
                                  ),
                                )
                              ],
                            )
                          : SizedBox();
                }
              }),
              SizedBox(
                height: 60.w,
              )
            ],
          ),
        ),
      ),
    );
  }

  getGrandTotal() {
    double grandTotal = 0;
    print("grand total fn");
    print(cartController.cartProducts.value);
    for (int i = 0; i < cartController.cartProducts.value.count; i++) {
      final String price = cartController.cartProducts.value.results[i].mrp.toString();
      final int count = cartController.cartProducts.value.results[i].purchaseCount;
      final double total = double.parse(price) * count;
      grandTotal += total;
    }
    grantTotalNotifier.value = grandTotal;
    return grandTotal;
  }
}
