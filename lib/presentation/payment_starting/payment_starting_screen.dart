import 'dart:developer';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/razorpay_key/razorpay_key.dart';
import 'package:internship_sample/models/orders_list_model.dart';
import 'package:internship_sample/presentation/main_page/main_page_screen.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/my_orders/my_orders_screen.dart';
import 'package:internship_sample/presentation/widgets/custom_elevated_button.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/services/api_services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PaymentStartingScreen extends StatefulWidget {
  const PaymentStartingScreen({
    super.key,
    required this.orderDetails,
  });
  final OrdersListModel orderDetails;
  @override
  State<PaymentStartingScreen> createState() => _PaymentStartingScreenState();
}

class _PaymentStartingScreenState extends State<PaymentStartingScreen> {
  AppController controller = Get.put(AppController());
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
            Get.off(() => MyOrdersScreen());
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
      body: LoaderOverlay(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              SizedBox(height: 30.w),
              SizedBox(
                height: 300.w,
                child: DataTable2(
                  columnSpacing: 12,
                  horizontalMargin: 12,
                  minWidth: 1000.w,
                  dataRowHeight: 60.w,
                  // fixedLeftColumns: 1,
                  dividerThickness: 2,

                  columns: [
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
                    widget.orderDetails.items.length,
                    (index) {
                      subTotal += double.parse(widget.orderDetails.items[index].total);
                      return DataRow(
                        cells: [
                          DataCell(
                            Center(child: CustomTextWidget(text: widget.orderDetails.items[index].product.product.name)),
                          ),
                          DataCell(
                            Center(child: CustomTextWidget(text: widget.orderDetails.items[index].product.hsn)),
                          ),
                          DataCell(
                            Center(child: CustomTextWidget(text: widget.orderDetails.items[index].purchaseCount.toString())),
                          ),
                          DataCell(
                            Center(child: CustomTextWidget(text: widget.orderDetails.items[index].product.sellingPrice)),
                          ),
                          DataCell(
                            Center(child: CustomTextWidget(text: widget.orderDetails.items[index].product.sellingPrice)),
                          ),
                          DataCell(
                            Center(child: CustomTextWidget(text: widget.orderDetails.items[index].product.cgstRate)),
                          ),
                          DataCell(
                            Center(child: CustomTextWidget(text: widget.orderDetails.items[index].cgstPrice)),
                          ),
                          DataCell(
                            Center(child: CustomTextWidget(text: widget.orderDetails.items[index].product.sgstRate)),
                          ),
                          DataCell(
                            Center(child: CustomTextWidget(text: widget.orderDetails.items[index].sgstPrice)),
                          ),
                          DataCell(
                            Center(child: CustomTextWidget(text: widget.orderDetails.items[index].total)),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
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
                            child: Center(
                              child: CustomTextWidget(
                                text: "₹ ${subTotal.toStringAsFixed(2)}",
                                fontSize: 14.sp,
                                fontweight: FontWeight.w600,
                                height: 2,
                              ),
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
                            child: Center(
                              child: CustomTextWidget(
                                text: "₹ ${widget.orderDetails.deliveryAdditionalAmount.toStringAsFixed(2)}",
                                fontSize: 14.sp,
                                fontweight: FontWeight.w600,
                                height: 2,
                              ),
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
                            child: Center(
                              child: CustomTextWidget(
                                text: "₹ ${(subTotal + widget.orderDetails.deliveryAdditionalAmount).toStringAsFixed(2)}",
                                fontSize: 16.sp,
                                fontweight: FontWeight.w600,
                                height: 2,
                                fontColor: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.w),
                child: GestureDetector(
                  onTap: () {
                    context.loaderOverlay.show();
                    proceedToPay(context, _razorpay, widget.orderDetails.orderId.toString(), widget.orderDetails.billingPhoneNumber);
                  },
                  child: CustomElevatedButton(label: "Proceed to Pay"),
                ),
              )
            ],
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

proceedToPay(BuildContext context, Razorpay razorpay, String orderId, String phoneNumber) async {
  final newResponse = await ApiServices().payment(orderId);
  String paymentOrderId = newResponse.data['response']['id'].toString();
  print("Order id = $paymentOrderId");
  final options = {
    'key': RAZORPAYKEY,
    'amount': newResponse.data['response']['amount'].toString(),
    'name': 'THE KERALA STATE CASHEW DEVELOPMENT CORPORATION LIMITED',
    'order_id': newResponse.data['response']['id'].toString(),
    'description': newResponse.data['response']['items'].toString(),
    'prefill': {
      'contact': phoneNumber,
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
