import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/models/orders_list_model.dart';
import 'package:internship_sample/presentation/checkout/checkout_screen.dart';
import 'package:internship_sample/presentation/cart/widgets/cart_product_list_tile.dart';
import 'package:internship_sample/presentation/order_tracking/widgets/custom_timeline_tile.dart';
import 'package:internship_sample/presentation/payment_starting/payment_starting_screen.dart';
import 'package:internship_sample/presentation/place_order/place_order_dropdown.dart';
import 'package:internship_sample/presentation/widgets/custom_appbar.dart';
import 'package:internship_sample/presentation/widgets/custom_elevated_button.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/services/api_services.dart';
import 'package:intl/intl.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({
    super.key,
    required this.orderDetails,
  });
  final OrdersListModel orderDetails;

  @override
  Widget build(BuildContext context) {
    final String imagePath = "https://backend.cashewcart.com:8443${orderDetails.items[0].product.product.productImages[0].productImage}";

    final DateTime createdAt = orderDetails.createdAt;
    final bool isPaymentSuccess = orderDetails.paymentStatus == "SUCCESS" ? true : false;
    double subTotal = 0;
    final screenSize = MediaQuery.of(context).size;
    String formattedDateTime = DateFormat("dd/MM/yyyy - hh a").format(createdAt.toLocal());
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
                text: orderDetails.shippingName,
                fontSize: 14.w,
              ),
              CustomTextWidget(
                text: orderDetails.shippingPhoneNumber,
                fontSize: 14.w,
              ),
              CustomTextWidget(
                text: "${orderDetails.shippingRegion}, ${orderDetails.shippingDistrict}, ${orderDetails.shippingState}, ${orderDetails.shippingPostalCode}",
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
                height: 200,
                child: DataTable2(
                  columnSpacing: 12,
                  horizontalMargin: 12,
                  minWidth: 1400.w,
                  dataRowHeight: 65.w,
                  // fixedLeftColumns: 1,
                  dividerThickness: 2,

                  columns: [
                    DataColumn2(
                      label: CustomTextWidget(
                        text: 'Product Name',
                        fontSize: 14.sp,
                        fontweight: FontWeight.w600,
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
                    orderDetails.items.length,
                    (index) {
                      subTotal += double.parse(orderDetails.items[index].total);
                      return DataRow(
                        cells: [
                          DataCell(
                            Center(
                                child: CustomTextWidget(
                              text: orderDetails.items[index].product.product.name,
                              maxLines: 3,
                            )),
                          ),
                          DataCell(
                            Center(child: CustomTextWidget(text: orderDetails.items[index].product.hsn)),
                          ),
                          DataCell(
                            Center(child: CustomTextWidget(text: orderDetails.items[index].purchaseCount.toString())),
                          ),
                          DataCell(
                            Center(child: CustomTextWidget(text: orderDetails.items[index].product.sellingPrice)),
                          ),
                          DataCell(
                            Center(child: CustomTextWidget(text: orderDetails.items[index].product.sellingPrice)),
                          ),
                          DataCell(
                            Center(child: CustomTextWidget(text: orderDetails.items[index].product.cgstRate)),
                          ),
                          DataCell(
                            Center(child: CustomTextWidget(text: orderDetails.items[index].cgstPrice)),
                          ),
                          DataCell(
                            Center(child: CustomTextWidget(text: orderDetails.items[index].product.sgstRate)),
                          ),
                          DataCell(
                            Center(child: CustomTextWidget(text: orderDetails.items[index].sgstPrice)),
                          ),
                          DataCell(
                            Center(child: CustomTextWidget(text: orderDetails.items[index].total)),
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
                          child: Center(
                            child: CustomTextWidget(
                              text: "₹${subTotal..toStringAsFixed(2)}",
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
                              text: "₹${orderDetails.deliveryAdditionalAmount..toStringAsFixed(2)}",
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
                          fontSize: 14.sp,
                          fontweight: FontWeight.w600,
                          height: 2,
                        ),
                        SizedBox(
                          width: 100.w,
                          child: Center(
                            child: CustomTextWidget(
                              text: "₹${subTotal + orderDetails.deliveryAdditionalAmount..toStringAsFixed(2)}",
                              fontSize: 14.sp,
                              fontweight: FontWeight.w600,
                              height: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              SizedBox(height: 20),
              if (!isPaymentSuccess)
                Column(
                  children: [
                    CustomTextWidget(
                      text: "Your payment was not success. Please retry payment for continuing purchase.",
                      fontSize: 14.sp,
                      fontweight: FontWeight.w600,
                      fontColor: Colors.red,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20.w,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(PaymentStartingScreen(orderDetails: orderDetails));
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
                        ApiServices().getInvoice(orderDetails.orderId.toString());
                      },
                      child: CustomElevatedButton(
                        label: "Retry Payment",
                      ),
                    ),
                  ],
                ),

              kHeight,
            ],
          ),
        ),
      ),
    );
  }
}
