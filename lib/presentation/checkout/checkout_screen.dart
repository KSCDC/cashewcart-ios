import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constatns.dart';
import 'package:internship_sample/main.dart';
import 'package:internship_sample/presentation/checkout/widgets/checkout_price_display_row.dart';
import 'package:internship_sample/presentation/checkout/widgets/custom_image_textfield.dart';
import 'package:internship_sample/presentation/main_page/main_page_screen.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/my_orders/my_orders_screen.dart';
import 'package:internship_sample/presentation/widgets/custom_appbar.dart';
import 'package:internship_sample/presentation/widgets/custom_elevated_button.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({
    super.key,
    required this.price,
    required this.shippingCost,
    required this.orderingProductsList,
  });
  final double price;
  final int shippingCost;
  final List orderingProductsList;

  // final ValueListenableBuilder popupHeightNotifier

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: CustomAppBar(title: "Checkout"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CheckoutScreenPriceDisplayRow(
                lable: "Order",
                price: price.toString(),
                color: Color(0xFFA8A8A9),
              ),
              kHeight,
              CheckoutScreenPriceDisplayRow(
                lable: "Shipping",
                price: "30",
                color: Color(0xFFA8A8A9),
              ),
              kHeight,
              CheckoutScreenPriceDisplayRow(
                lable: "Total",
                price: (price + shippingCost).toString(),
                color: Colors.black,
              ),
              kHeight,
              Divider(),
              SizedBox(height: 20),

              //Payment options

              CustomTextWidget(
                text: "Payment",
                fontSize: 18,
                fontweight: FontWeight.w500,
              ),
              CustomImageTextField(
                imagePath: "lib/core/assets/images/logos/visa_logo.svg",
                hintText: "*********2109",
              ),
              CustomImageTextField(
                imagePath: "lib/core/assets/images/logos/paypal_logo.svg",
                hintText: "*********2109",
              ),

              CustomImageTextField(
                imagePath: "lib/core/assets/images/logos/maestro_logo.svg",
                hintText: "*********2109",
              ),
              CustomImageTextField(
                imagePath: "lib/core/assets/images/logos/apple_pay_logo.svg",
                hintText: "*********2109",
              ),
              kHeight,
              GestureDetector(
                onTap: () {
                  recentOrdersList.addAll(orderingProductsList);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        insetAnimationDuration: Duration(milliseconds: 1000),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          width: screenSize.width * 0.9,
                          height: screenSize.width * 0.65,
                          child: Column(
                            children: [
                              SvgPicture.asset("lib/core/assets/images/other/payment_success.svg"),
                              CustomTextWidget(
                                text: "Payment done successfully.",
                                fontweight: FontWeight.w600,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                  bottomNavbarIndexNotifier.value = 2;
                  // recentOrders.add(value)

                  bottomNavbarIndexNotifier.value = previousPageIndex;
                  Future.delayed(Duration(seconds: 2), () {
                    Navigator.of(
                      context,
                    ).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => MainPageScreen(),
                      ),
                      (route) => false,
                    );
                  });
                },
                child: CustomElevatedButton(
                  label: "Continue",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
