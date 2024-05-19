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
import 'package:internship_sample/presentation/cart/cart_screen.dart';
import 'package:internship_sample/presentation/checkout/checkout_screen.dart';
import 'package:internship_sample/presentation/cart/widgets/cart_product_list_tile.dart';
import 'package:internship_sample/presentation/main_page/main_page_screen.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/my_orders/my_orders_screen.dart';
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

class MultipleItemPlaceOrderScreen extends StatefulWidget {
  MultipleItemPlaceOrderScreen({super.key, required this.productList, required this.grandTotal});
  final List<Result> productList;
  final double grandTotal;
  @override
  State<MultipleItemPlaceOrderScreen> createState() => _MultipleItemPlaceOrderScreenState();
}

class _MultipleItemPlaceOrderScreenState extends State<MultipleItemPlaceOrderScreen> {
  AppController controller = Get.put(AppController());
  late Razorpay _razorpay;
  ValueNotifier<bool> useSameAddressNotifier = ValueNotifier(true);
  ValueNotifier<int> deliveryAddressRadioNotifier = ValueNotifier(0);
  ValueNotifier<int> billingAddressRadioNotifier = ValueNotifier(0);
  @override
  void initState() {
    super.initState();
    // if (controller.addressList.isNotEmpty) {
    //   controller.createOrder(controller.addressList[0].id.toString());
    // }
    // Initialize Razorpay instance
    // context.loaderOverlay.hide();
    _razorpay = Razorpay();

    // Define event listeners
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Payment Successful: ${response.paymentId}');
    Fluttertoast.showToast(msg: "Payment success");

    // log(response.data.toString());
    String _signature = response.data!['razorpay_signature'];
    String _orderId = response.data!['razorpay_order_id'];
    String _paymentId = response.data!['razorpay_payment_id'];
    ApiServices().verifyPayment(_signature, _orderId, _paymentId);
    showSuccessPopup(context);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    log('Payment Error: ${response.code} - ${response.message}');
    showFailurePopup();
    // Fluttertoast.showToast(msg: "Payment error: ${response.code} - ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External Wallet: ${response.walletName}');
    // Handle external wallet
  }

  @override
  void dispose() {
    // Clear event listeners and dispose Razorpay instance
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double totalProductPrice = 0;

    double cgstTotal = 0;
    double sgstTotal = 0;
    double totalPriceWithoutGst = 0;

    final screenSize = MediaQuery.of(context).size;
    for (int i = 0; i < widget.productList.length; i++) {
      double sellingPrice = double.parse(widget.productList[i].product.sellingPrice);
      double cgstPercentage = double.parse(widget.productList[i].product.cgstRate);
      double sgstPercentage = double.parse(widget.productList[i].product.sgstRate);
      double cgstPrice = sellingPrice - sellingPrice / (1 + (cgstPercentage / 100));
      double sgstPrice = sellingPrice - sellingPrice / (1 + (sgstPercentage / 100));
      double originalProductPriceWithoutGst = (sellingPrice - cgstPrice - sgstPrice) * widget.productList[i].purchaseCount;
      cgstTotal += cgstPrice * widget.productList[i].purchaseCount;
      sgstTotal += sgstPrice * widget.productList[i].purchaseCount;
      totalPriceWithoutGst += originalProductPriceWithoutGst;
      totalProductPrice += sellingPrice * widget.productList[i].purchaseCount;
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

                          final int count = widget.productList[index].purchaseCount;

                          return Column(
                            children: [
                              kHeight,
                              if (count != 0)
                                PlaceOrderItemWidget(
                                  imagePath: widget.productList[index].product.product.productImages.isNotEmpty ? widget.productList[index].product.product.productImages[0].productImage : '',
                                  productName: widget.productList[index].product.product.name,
                                  productDescription: widget.productList[index].product.product.description,
                                  count: count,
                                ),
                              Divider(
                                thickness: 0.3,
                              )
                            ],
                          );
                        },
                        itemCount: widget.productList.length,
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
                              setState(() {
                                useSameAddressNotifier.value = value ?? true; // Update the isChecked variable
                              });
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
                        await Services().showAddressEditPopup(
                          true,
                          context,
                          "",
                          "ADD ADDRESS",
                          "ADD",
                          _nameContrller,
                          _streetAddressContrller,
                          _regionController,
                          _districtController,
                          _stateController,
                          _postalcodeController,
                          _phoneNumberController,
                        );
                        controller.getUserAddresses();
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
                      fontweight: FontWeight.w600,
                    ),
                    Container(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          // final int selectedCategory = productList[index]['category'];
                          final String price = widget.productList[index].product.sellingPrice.toString();
                          final int count = widget.productList[index].purchaseCount;
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
                                        text: widget.productList[index].product.product.name,
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
                        itemCount: widget.productList.length,
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
                                text: "₹ ${totalPriceWithoutGst.toStringAsFixed(2)}",
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
                          text: "₹ ${totalProductPrice.toStringAsFixed(2)}",
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
                    text: "₹ ${totalProductPrice.toStringAsFixed(2)} +",
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
                    context.loaderOverlay.show();
                    proceedToPayment();
                  }
                },
                child: CustomElevatedButton(
                  label: "Proceed to Payment",
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
    await controller.getProfileDetails();
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final String phoneNo = sharedPref.getString(PHONE)!;
    print("List length = ${widget.productList}");
    for (var product in widget.productList) {
      print("Working loop");
      // final product = item['product'];
      orderingProductsList.add(product);
    }
    print("delivery ${controller.addressList[deliveryAddressRadioNotifier.value].id}");
    print("bill ${controller.addressList[billingAddressRadioNotifier.value].id}");
    final response = await ApiServices().placeOrder(controller.addressList[deliveryAddressRadioNotifier.value].id.toString(), controller.addressList[billingAddressRadioNotifier.value].id.toString());
    if (response != null) {
      String _orderId = response.data['order_id'].toString();
      print(_orderId);
      final newResponse = await ApiServices().payment(_orderId);
      String paymentOrderId = newResponse.data['response']['id'].toString();
      print("Order id = $paymentOrderId");
      final options = {
        'key': RAZORPAYKEY,
        'amount': newResponse.data['response']['amount'].toString(),
        'name': 'THE KERALA STATE CASHEW DEVELOPMENT CORPORATION LIMITED',
        'order_id': newResponse.data['response']['id'].toString(),
        'description': newResponse.data['response']['items'].toString(),
        'prefill': {
          'contact': phoneNo,
          'email': newResponse.data['response']['notes']['email'],
        }
      };
      context.loaderOverlay.hide();

      try {
        _razorpay.open(options);
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  showSuccessPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final screenSize = MediaQuery.of(context).size;
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
    ).then((value) {
      bottomNavbarIndexNotifier.value = 6;
      Get.offAll(() => MainPageScreen());
    });
  }

  showFailurePopup() {
    Alert(
      context: context,
      type: AlertType.error,
      title: "PAYMENT FAILED",
      desc: "Your payment is failed. You can retry payment from My Orders section.",
      buttons: [
        DialogButton(
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
      ],
    ).show().then((value) {
      // bottomNavbarIndexNotifier.value = 6;
      Get.to(() => MyOrdersScreen());
    });
  }
}
