import 'dart:developer';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:cashew_cart/controllers/app_controller.dart';
import 'package:cashew_cart/controllers/cart_controller.dart';
import 'package:cashew_cart/core/colors.dart';
import 'package:cashew_cart/core/razorpay_key/razorpay_key.dart';
import 'package:cashew_cart/models/cart_product_model.dart';
import 'package:cashew_cart/models/orders_list_model.dart';
import 'package:cashew_cart/models/user_address_model.dart';
import 'package:cashew_cart/presentation/main_page/main_page_screen.dart';
import 'package:cashew_cart/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:cashew_cart/presentation/my_orders/my_orders_screen.dart';
import 'package:cashew_cart/presentation/widgets/custom_elevated_button.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';
import 'package:cashew_cart/services/api_services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PaymentStartingScreen extends StatefulWidget {
  const PaymentStartingScreen({
    super.key,
    required this.deliveryAddress,
    required this.billingAddress,
    required this.productsList,
    required this.deliveryCharge,
    required this.additionalAmount,
    // required this.orderDetails,
  });
  // final OrdersListModel orderDetails;
  final List<Result> productsList;
  final UserAddressModel deliveryAddress;
  final UserAddressModel billingAddress;
  final double deliveryCharge;
  final double additionalAmount;
  @override
  State<PaymentStartingScreen> createState() => _PaymentStartingScreenState();
}

class _PaymentStartingScreenState extends State<PaymentStartingScreen> {
  AppController controller = Get.put(AppController());
  CartController cartController = Get.put(CartController());
  late Razorpay _razorpay;

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

    // proceedToPay(context, _razorpay, widget.orderId, widget.phoneNumber);
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
    double subTotal = 0;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: CustomTextWidget(
          text: "Order Summary",
          fontSize: 18.sp,
          fontweight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: LoaderOverlay(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: "Shipping Details :",
                  fontSize: 15.w,
                  fontweight: FontWeight.w600,
                ),
                CustomTextWidget(
                  text: widget.deliveryAddress.name,
                  fontSize: 14.w,
                ),
                CustomTextWidget(
                  text: widget.deliveryAddress.phoneNumber,
                  fontSize: 14.w,
                ),
                CustomTextWidget(
                  text:
                      "${widget.deliveryAddress.region}, ${widget.deliveryAddress.district}, ${widget.deliveryAddress.state}, ${widget.deliveryAddress.postalCode}",
                  fontSize: 14.w,
                ),
                SizedBox(height: 10.w),
                CustomTextWidget(
                  text: "Billing Details :",
                  fontSize: 15.w,
                  fontweight: FontWeight.w600,
                ),
                CustomTextWidget(
                  text: widget.billingAddress.name,
                  fontSize: 14.w,
                ),
                CustomTextWidget(
                  text: widget.billingAddress.phoneNumber,
                  fontSize: 14.w,
                ),
                CustomTextWidget(
                  text:
                      "${widget.billingAddress.region}, ${widget.billingAddress.district}, ${widget.billingAddress.state}, ${widget.billingAddress.postalCode}",
                  fontSize: 14.w,
                ),
                SizedBox(height: 10.w),
                Divider(),
                SizedBox(height: 10),
                SizedBox(
                  height: 250.w,
                  child: DataTable2(
                    columnSpacing: 12,
                    horizontalMargin: 12,
                    minWidth: 1000.w,
                    // dataRowHeight: 60.w,
                    // fixedLeftColumns: 1,
                    dividerThickness: 2,

                    columns: [
                      DataColumn2(
                        label: CustomTextWidget(
                          text: 'Sl No',
                          fontSize: 14.sp,
                          fontweight: FontWeight.w600,
                        ),
                        size: ColumnSize.S,
                      ),
                      DataColumn2(
                        label: CustomTextWidget(
                          text: 'Product Name',
                          fontSize: 14.sp,
                          fontweight: FontWeight.w600,
                          maxLines: 3,
                        ),
                        size: ColumnSize.L,
                      ),
                      DataColumn(
                        label: Center(
                          child: CustomTextWidget(
                            text: 'HSN/SAC',
                            fontSize: 14.sp,
                            fontweight: FontWeight.w600,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Center(
                          child: CustomTextWidget(
                            text: 'Qty',
                            fontSize: 14.sp,
                            fontweight: FontWeight.w600,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Center(
                          child: CustomTextWidget(
                            text: 'Unit Price',
                            fontSize: 14.sp,
                            fontweight: FontWeight.w600,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Center(
                          child: CustomTextWidget(
                            text: 'Taxable Amnt',
                            fontSize: 14.sp,
                            fontweight: FontWeight.w600,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Center(
                          child: CustomTextWidget(
                            text: 'CGST %',
                            fontSize: 14.sp,
                            fontweight: FontWeight.w600,
                          ),
                        ),
                        numeric: true,
                      ),
                      DataColumn(
                        label: Center(
                          child: CustomTextWidget(
                            text: 'CGST Amnt',
                            fontSize: 14.sp,
                            fontweight: FontWeight.w600,
                          ),
                        ),
                        numeric: true,
                      ),
                      DataColumn(
                        label: Center(
                          child: CustomTextWidget(
                            text: 'SGST %',
                            fontSize: 14.sp,
                            fontweight: FontWeight.w600,
                          ),
                        ),
                        numeric: true,
                      ),
                      DataColumn(
                        label: Center(
                          child: CustomTextWidget(
                            text: 'SGST Amnt',
                            fontSize: 14.sp,
                            fontweight: FontWeight.w600,
                          ),
                        ),
                        numeric: true,
                      ),
                      DataColumn(
                        label: Center(
                          child: CustomTextWidget(
                            text: 'Total Payable',
                            fontSize: 14.sp,
                            fontweight: FontWeight.w600,
                          ),
                        ),
                        numeric: true,
                      ),
                    ],
                    rows: List<DataRow>.generate(
                      widget.productsList.length,
                      (index) {
                        subTotal +=
                            double.parse(widget.productsList[index].total);
                        return DataRow(
                          cells: [
                            DataCell(
                              Center(
                                  child:
                                      CustomTextWidget(text: "${index + 1}")),
                            ),
                            DataCell(
                              Center(
                                  child: CustomTextWidget(
                                      text: widget.productsList[index].product
                                          .product.name)),
                            ),
                            DataCell(
                              Center(
                                  child: CustomTextWidget(
                                      text: widget
                                          .productsList[index].product.hsn)),
                            ),
                            DataCell(
                              Center(
                                  child: CustomTextWidget(
                                      text: widget
                                          .productsList[index].purchaseCount
                                          .toString())),
                            ),
                            DataCell(
                              Center(
                                  child: CustomTextWidget(
                                      text: widget.productsList[index].product
                                          .sellingPrice)),
                            ),
                            DataCell(
                              Center(
                                  child: CustomTextWidget(
                                      text: (double.parse(widget
                                                  .productsList[index]
                                                  .product
                                                  .sellingPrice) *
                                              widget.productsList[index]
                                                  .purchaseCount)
                                          .toStringAsFixed(2))),
                            ),
                            DataCell(
                              Center(
                                  child: CustomTextWidget(
                                      text: widget.productsList[index].product
                                          .cgstRate)),
                            ),
                            DataCell(
                              Center(
                                  child: CustomTextWidget(
                                      text: widget
                                          .productsList[index].cgstPrice)),
                            ),
                            DataCell(
                              Center(
                                  child: CustomTextWidget(
                                      text: widget.productsList[index].product
                                          .sgstRate)),
                            ),
                            DataCell(
                              Center(
                                  child: CustomTextWidget(
                                      text: widget
                                          .productsList[index].sgstPrice)),
                            ),
                            DataCell(
                              Center(
                                  child: CustomTextWidget(
                                      text: widget.productsList[index].total)),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      SizedBox(width: double.infinity),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomTextWidget(
                            text: "Sub Total : ",
                            fontSize: 14.sp,
                            fontweight: FontWeight.w600,
                            height: 2,
                          ),
                          SizedBox(
                            width: 100.w,
                            child: CustomTextWidget(
                              text: "₹ ${subTotal.toStringAsFixed(2)}",
                              fontSize: 14.sp,
                              fontweight: FontWeight.w600,
                              height: 2,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomTextWidget(
                            text: "Shipping & other charges : ",
                            fontSize: 14.sp,
                            fontweight: FontWeight.w600,
                            height: 2,
                          ),
                          SizedBox(
                            width: 100.w,
                            child: CustomTextWidget(
                              text:
                                  "₹ ${(widget.deliveryCharge + widget.additionalAmount).toStringAsFixed(2)}",
                              fontSize: 14.sp,
                              fontweight: FontWeight.w600,
                              height: 2,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.w),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomTextWidget(
                            text: "Grand Total : ",
                            fontSize: 16.sp,
                            fontweight: FontWeight.w600,
                            height: 2,
                            fontColor: Colors.red,
                          ),
                          SizedBox(
                            width: 100.w,
                            child: CustomTextWidget(
                              text:
                                  "₹ ${(subTotal + widget.deliveryCharge).toStringAsFixed(2)}",
                              fontSize: 16.sp,
                              fontweight: FontWeight.w600,
                              height: 2,
                              fontColor: Colors.red,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: GestureDetector(
                    onTap: () {
                      context.loaderOverlay.show();
                      proceedToPay(
                          context,
                          _razorpay,
                          widget.deliveryAddress.id.toString(),
                          widget.billingAddress.id.toString());
                    },
                    child: CustomElevatedButton(label: "Proceed to Pay"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
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
                SvgPicture.asset(
                    "lib/core/assets/images/other/payment_success.svg"),
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
      desc:
          "Your payment is failed. You can retry payment from My Orders section.",
      buttons: [
        DialogButton(
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
      ],
    ).show().then((value) {
      // bottomNavbarIndexNotifier.value = 6;
      Get.offAll(() => MainPageScreen());
    });
  }
}

proceedToPay(BuildContext context, Razorpay razorpay, String deliveryAddressId,
    String billingAddressId) async {
  List orderingProductsList = [];
  final OrdersListModel order;

  final response =
      await ApiServices().placeOrder(deliveryAddressId, billingAddressId,context);
  log("order response $response");
  if (response == null) {
    //   // String phoneNumber = response.data['billing_phone_number'].toString();
    //   // String _orderId = response.data['order_id'].toString();
    order = OrdersListModel.fromJson(response.data);
    final newResponse = await ApiServices().payment(order.orderId.toString());
    String paymentOrderId = newResponse.data['response']['id'].toString();
    print("Order id = $paymentOrderId");
    final options = {
      'key': RAZORPAYKEY,
      'amount': newResponse.data['response']['amount'].toString(),
      'name': 'THE KERALA STATE CASHEW DEVELOPMENT CORPORATION LIMITED',
      'order_id': newResponse.data['response']['id'].toString(),
      'description': newResponse.data['response']['notes']['items'].toString(),
      'prefill': {
        'contact': order.billingPhoneNumber,
        'email': newResponse.data['response']['notes']['email'],
      }
    };
    context.loaderOverlay.hide();

    try {
      razorpay.open(options);
    } catch (e) {
      print('Error: $e');
    }
  }
}
