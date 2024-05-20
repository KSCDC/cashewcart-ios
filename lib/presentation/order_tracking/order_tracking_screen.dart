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
    required this.productDetails,
  });
  final OrdersListModel productDetails;

  @override
  Widget build(BuildContext context) {
    final String imagePath = "https://backend.cashewcart.com:8443${productDetails.items[0].product.product.productImages[0].productImage}";

    final DateTime createdAt = productDetails.createdAt;
    final bool isPaymentSuccess = productDetails.paymentStatus == "SUCCESS" ? true : false;
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      height: 125,
                      width: screenSize.width * 0.25,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(imagePath),
                          fit: BoxFit.fitHeight,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 250,
                          child: CustomTextWidget(
                            text: productDetails.items[0].product.product.name,
                            fontweight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: screenSize.width * 0.6,
                          child: CustomTextWidget(
                            text: productDetails.items[0].product.product.description,
                            fontSize: 13,
                            fontweight: FontWeight.w400,
                          ),
                        ),
                        kHeight,
                        kHeight,
                        Row(
                          children: [
                            Container(
                              height: 35,
                              child: Row(
                                children: [
                                  CustomTextWidget(
                                    text: "Wt:",
                                    fontweight: FontWeight.w600,
                                  ),
                                  SizedBox(width: 5),
                                  CustomTextWidget(text: "250GM"),
                                ],
                              ),
                            ),
                            SizedBox(width: 20),
                            Container(
                              height: 35,
                              child: Row(
                                children: [
                                  CustomTextWidget(
                                    text: "Qty: ",
                                    fontweight: FontWeight.w600,
                                  ),
                                  SizedBox(width: 5),
                                  CustomTextWidget(text: "1"),
                                ],
                              ),
                            ),
                            kWidth,
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              // kHeight,
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
                  minWidth: 1000.w,
                  dataRowHeight: 50.w,
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
                      label: CustomTextWidget(
                        text: 'HSN/SAC',
                        fontSize: 14.sp,
                        fontweight: FontWeight.w600,
                      ),
                    ),
                    DataColumn(
                      label: CustomTextWidget(
                        text: 'Qty',
                        fontSize: 14.sp,
                        fontweight: FontWeight.w600,
                      ),
                    ),
                    DataColumn(
                      label: CustomTextWidget(
                        text: 'Unit Price',
                        fontSize: 14.sp,
                        fontweight: FontWeight.w600,
                      ),
                    ),
                    DataColumn(
                      label: CustomTextWidget(
                        text: 'CGST %',
                        fontSize: 14.sp,
                        fontweight: FontWeight.w600,
                      ),
                      numeric: true,
                    ),
                    DataColumn(
                      label: CustomTextWidget(
                        text: 'CGST Amnt',
                        fontSize: 14.sp,
                        fontweight: FontWeight.w600,
                      ),
                      numeric: true,
                    ),
                    DataColumn(
                      label: CustomTextWidget(
                        text: 'SGST %',
                        fontSize: 14.sp,
                        fontweight: FontWeight.w600,
                      ),
                      numeric: true,
                    ),
                    DataColumn(
                      label: CustomTextWidget(
                        text: 'SGST Amnt',
                        fontSize: 14.sp,
                        fontweight: FontWeight.w600,
                      ),
                      numeric: true,
                    ),
                    DataColumn(
                      label: CustomTextWidget(
                        text: 'Total Payable',
                        fontSize: 14.sp,
                        fontweight: FontWeight.w600,
                      ),
                      numeric: true,
                    ),
                  ],
                  rows: List<DataRow>.generate(
                    productDetails.items.length,
                    (index) {
                      subTotal += double.parse(productDetails.items[index].total);
                      return DataRow(
                        cells: [
                          DataCell(
                            CustomTextWidget(text: productDetails.items[index].product.product.name),
                          ),
                          DataCell(
                            CustomTextWidget(text: productDetails.items[index].product.hsn),
                          ),
                          DataCell(
                            CustomTextWidget(text: productDetails.items[index].purchaseCount.toString()),
                          ),
                          DataCell(
                            CustomTextWidget(text: productDetails.items[index].product.sellingPrice),
                          ),
                          // DataCell(
                          //   CustomTextWidget(text: productDetails.items[index].product.sellingPrice),
                          // ),
                          DataCell(
                            CustomTextWidget(text: productDetails.items[index].product.cgstRate),
                          ),
                          DataCell(
                            CustomTextWidget(text: productDetails.items[index].cgstPrice),
                          ),
                          DataCell(
                            CustomTextWidget(text: productDetails.items[index].product.sgstRate),
                          ),
                          DataCell(
                            CustomTextWidget(text: productDetails.items[index].sgstPrice),
                          ),
                          DataCell(
                            CustomTextWidget(text: productDetails.items[index].total),
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
                              text: "₹$subTotal",
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
                              text: "₹${productDetails.deliveryAdditionalAmount}",
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
                              text: "₹${subTotal + productDetails.deliveryAdditionalAmount}",
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
                        Get.to(PaymentStartingScreen(orderDetails: productDetails));
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
