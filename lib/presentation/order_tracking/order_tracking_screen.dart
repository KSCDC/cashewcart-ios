import 'dart:developer';

import 'package:cashew_cart/controllers/download_controller.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:cashew_cart/core/colors.dart';
// import 'package:cashew_cart/core/razorpay_key/razorpay_key.dart';
import 'package:cashew_cart/models/orders_list_model.dart';
import 'package:cashew_cart/presentation/main_page/main_page_screen.dart';
import 'package:cashew_cart/presentation/widgets/custom_appbar.dart';
import 'package:cashew_cart/presentation/widgets/custom_elevated_button.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';
import 'package:cashew_cart/services/api_services.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({
    super.key,
    required this.orderDetails,
  });
  final OrdersListModel orderDetails;

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  late Razorpay _razorpay;
  final downloadController = Get.put(DownloadController());
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
    final bool isPaymentSuccess =
        widget.orderDetails.paymentStatus == "SUCCESS" ? true : false;
    double subTotal = 0;

    return Scaffold(
      appBar: CustomAppBar(
        title: "Product Details",
      ),
      backgroundColor: appBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // kHeight,
              CustomTextWidget(
                text: "Shipping Details :",
                fontSize: 15.w,
                fontweight: FontWeight.w600,
              ),
              CustomTextWidget(
                text: widget.orderDetails.shippingName,
                fontSize: 14.w,
              ),
              CustomTextWidget(
                text: widget.orderDetails.shippingPhoneNumber,
                fontSize: 14.w,
              ),
              CustomTextWidget(
                text:
                    "${widget.orderDetails.shippingRegion}, ${widget.orderDetails.shippingDistrict}, ${widget.orderDetails.shippingState}, ${widget.orderDetails.shippingPostalCode}",
                fontSize: 14.w,
              ),
              SizedBox(height: 10.w),
              CustomTextWidget(
                text: "Billing Details :",
                fontSize: 15.w,
                fontweight: FontWeight.w600,
              ),
              CustomTextWidget(
                text: widget.orderDetails.billingName,
                fontSize: 14.w,
              ),
              CustomTextWidget(
                text: widget.orderDetails.billingPhoneNumber,
                fontSize: 14.w,
              ),
              CustomTextWidget(
                text:
                    "${widget.orderDetails.billingRegion}, ${widget.orderDetails.billingDistrict}, ${widget.orderDetails.billingState}, ${widget.orderDetails.billingPostalCode}",
                fontSize: 14.w,
              ),
              SizedBox(height: 10.w),
              Divider(),
              SizedBox(height: 20),
              CustomTextWidget(
                text: "Order Payment Details",
                fontSize: 16.sp,
                fontweight: FontWeight.w600,
              ),
              // SizedBox(height: 20),
              SizedBox(
                height: 200.w,
                child: DataTable2(
                  columnSpacing: 12,
                  horizontalMargin: 12,
                  minWidth: 1000.w,
                  isHorizontalScrollBarVisible: false,
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
                    widget.orderDetails.items.length,
                    (index) {
                      subTotal +=
                          double.parse(widget.orderDetails.items[index].total);
                      return DataRow(
                        cells: [
                          DataCell(
                            Center(
                                child: CustomTextWidget(text: "${index + 1}")),
                          ),
                          DataCell(
                            Center(
                                child: CustomTextWidget(
                                    text: widget.orderDetails.items[index]
                                        .product.product.name)),
                          ),
                          DataCell(
                            Center(
                                child: CustomTextWidget(
                                    text: widget.orderDetails.items[index]
                                        .product.hsn)),
                          ),
                          DataCell(
                            Center(
                                child: CustomTextWidget(
                                    text: widget
                                        .orderDetails.items[index].purchaseCount
                                        .toString())),
                          ),
                          DataCell(
                            Center(
                                child: CustomTextWidget(
                                    text: widget.orderDetails.items[index]
                                        .product.sellingPrice)),
                          ),
                          DataCell(
                            Center(
                                child: CustomTextWidget(
                                    text: (double.parse(widget
                                                .orderDetails
                                                .items[index]
                                                .product
                                                .sellingPrice) *
                                            widget.orderDetails.items[index]
                                                .purchaseCount)
                                        .toString())),
                          ),
                          DataCell(
                            Center(
                                child: CustomTextWidget(
                                    text: widget.orderDetails.items[index]
                                        .product.cgstRate)),
                          ),
                          DataCell(
                            Center(
                                child: CustomTextWidget(
                                    text: widget
                                        .orderDetails.items[index].cgstPrice)),
                          ),
                          DataCell(
                            Center(
                                child: CustomTextWidget(
                                    text: widget.orderDetails.items[index]
                                        .product.sgstRate)),
                          ),
                          DataCell(
                            Center(
                                child: CustomTextWidget(
                                    text: widget
                                        .orderDetails.items[index].sgstPrice)),
                          ),
                          DataCell(
                            Center(
                                child: CustomTextWidget(
                                    text: widget
                                        .orderDetails.items[index].total)),
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
                        // Spacer(),
                        SizedBox(
                          width: 100.w,
                          child: CustomTextWidget(
                            text:
                                "₹ ${widget.orderDetails.deliveryAdditionalAmount.toStringAsFixed(2)}",
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
                                "₹ ${(subTotal + widget.orderDetails.deliveryAdditionalAmount).toStringAsFixed(2)}",
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
              Divider(),
              SizedBox(height: 10),
              if (!isPaymentSuccess)
                Column(
                  children: [
                    CustomTextWidget(
                      text:
                          "Your payment was not success. Please retry payment for continuing purchase.",
                      fontSize: 14.sp,
                      fontweight: FontWeight.w600,
                      fontColor: Colors.red,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20.w,
                    ),
                    InkWell(
                      onTap: () async {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                        await proceedToPay(
                            context,
                            _razorpay,
                            widget.orderDetails.orderId.toString(),
                            widget.orderDetails.billingPhoneNumber);
                        // Navigator.of(context).pop();
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      child: CustomElevatedButton(
                        label: "Retry Payment",
                      ),
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        downloadController.downloadInvoice(
                            widget.orderDetails.orderId.toString());
                      },
                      child: Obx(() {
                        return Container(
                          height: 55.w,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: kMainThemeColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          child: Center(
                            child: downloadController.isLoading.value
                                ? CircularProgressIndicator()
                                : CustomTextWidget(
                                    text: "Download invoice",
                                    fontSize: 16.sp,
                                    fontColor: kButtonTextColor,
                                    fontweight: FontWeight.w600,
                                  ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),

              SizedBox(height: 50.w),
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
      // Get.to(() => MyOrdersScreen());
    });
  }
}

proceedToPay(BuildContext context, Razorpay razorpay, String orderId,
    String phoneNumber) async {
  final newResponse = await ApiServices().payment(orderId);
  if (newResponse != null) {
    String paymentOrderId = newResponse.data['response']['id'].toString();
    print("Order id = $paymentOrderId");
    final options = {
      'key': "RAZORPAYKEY",
      'amount': newResponse.data['response']['amount'].toString(),
      'name': 'THE KERALA STATE CASHEW DEVELOPMENT CORPORATION LIMITED',
      'order_id': newResponse.data['response']['id'].toString(),
      'description': newResponse.data['response']['notes']['items'].toString(),
      'prefill': {
        'contact': phoneNumber,
        'email': newResponse.data['response']['notes']['email'],
      }
    };
    // context.loaderOverlay.hide();

    try {
      razorpay.open(options);
    } catch (e) {
      print('Error: $e');
    }
  }
}
