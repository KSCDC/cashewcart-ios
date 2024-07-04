import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cashew_cart/core/colors.dart';
import 'package:cashew_cart/core/constants.dart';
import 'package:cashew_cart/models/orders_list_model.dart';
import 'package:cashew_cart/presentation/widgets/custom_star_rating_tile.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';
import 'package:intl/intl.dart';

class MyOrdersListTile extends StatelessWidget {
  const MyOrdersListTile({
    super.key,
    required this.currentItem,
  });
  final OrdersListModel currentItem;

  @override
  Widget build(BuildContext context) {
    final String orderId = currentItem.orderId.toString();
    final String paymentStatus = currentItem.paymentStatus;
    final int totalItems = currentItem.items.length;
    final DateTime date = currentItem.createdAt;
    final num subTotal = currentItem.subTotalAmount;
    final num deliveryCharge = currentItem.deliveryAdditionalAmount;
    final num grandTotal = currentItem.totalAmount;
    String orderPlacedDate = DateFormat('dd MMMM yyyy').format(date);
    final screenSize = MediaQuery.of(context).size;
    Color paymentStatusColor = Colors.black;
    String status;
    if (paymentStatus == "SUCCESS") {
      paymentStatusColor = Colors.green;
      status = "SUCCESS";
    } else if (paymentStatus == "PAYMENT_NOT_STARTED") {
      paymentStatusColor = Colors.red;
      status = "NOT STARTED";
    } else {
      paymentStatusColor = Colors.red;
      status = "FAILED";
    }
    return Container(
      // width: screenSize.width * 0.95,
      width: double.infinity,
      // height: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   children: [
            //     Container(
            //       height: 125,
            //       width: 130,
            //       decoration: BoxDecoration(
            //         image: DecorationImage(
            //           image: NetworkImage(imagePath),
            //           fit: BoxFit.fitHeight,
            //         ),
            //         borderRadius: BorderRadius.all(
            //           Radius.circular(4),
            //         ),
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.all(10),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           SizedBox(
            //             width: screenSize.width * 0.52,
            //             child: CustomTextWidget(
            //               text: name,
            //               fontSize: 13,
            //               fontweight: FontWeight.w600,
            //             ),
            //           ),
            //           const SizedBox(height: 5),
            //           Row(
            //             children: [
            //               const CustomTextWidget(
            //                 text: "Quantity :",
            //                 fontSize: 12,
            //                 fontweight: FontWeight.w500,
            //               ),
            //               kWidth,
            //               CustomTextWidget(
            //                 text: weight.toString(),
            //                 fontSize: 12,
            //               ),
            //               kWidth,
            //             ],
            //           ),
            //           kHeight,
            //           Row(
            //             children: [
            //               CustomTextWidget(
            //                 text: rating,
            //                 // fontColor: ,
            //                 fontSize: 12,
            //               ),
            //               for (int i = 0; i < 4; i++)
            //                 const Icon(
            //                   Icons.star,
            //                   color: Color(0xFFF7B305),
            //                   size: 15,
            //                 ),
            //               const Icon(
            //                 Icons.star_half,
            //                 color: Color(0xFFBBBBBB),
            //                 size: 15,
            //               ),
            //               kWidth,
            //             ],
            //           ),
            //           kHeight,
            //           Row(
            //             children: [
            //               CartProductListTileButton(
            //                 buttonHeight: 30,
            //                 buttonWidth: 85,
            //                 label: "₹ ${price}",
            //                 fontSize: 16,
            //                 fontWeight: FontWeight.w600,
            //               ),
            //               kWidth,
            //             ],
            //           ),
            //         ],
            //       ),
            //     )
            //   ],
            // ),

            Row(
              children: [
                CustomTextWidget(
                  text: "Order ID : $orderId",
                  fontSize: 14.sp,
                  fontweight: FontWeight.w600,
                  fontColor: kMainThemeColor,
                ),
              ],
            ),

            CustomTextWidget(
              text: "Order placed on $orderPlacedDate",
              fontSize: 14.sp,
            ),
            OrderListLine(label: "Number of items", number: "$totalItems"),
            OrderListLine(label: "Sub Total", number: "₹ ${subTotal.toStringAsFixed(2)}"),
            OrderListLine(label: "Delivery charge", number: "₹ ${deliveryCharge.toStringAsFixed(2)}"),
            OrderListLine(label: "Grand Total", number: "₹ ${grandTotal.toStringAsFixed(2)}"),

            SizedBox(height: 10.w),
            Row(
              children: [
                CustomTextWidget(
                  text: "Payment status : ",
                  fontSize: 14.sp,
                  fontweight: FontWeight.w600,
                ),
                CustomTextWidget(
                  text: status,
                  fontColor: paymentStatusColor,
                  fontSize: 14.sp,
                  fontweight: FontWeight.w600,
                ),
              ],
            ),
            kHeight,
            Divider(),

            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}

class OrderListLine extends StatelessWidget {
  const OrderListLine({
    super.key,
    required this.label,
    required this.number,
  });
  final String label;
  final String number;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 200.w,
          child: CustomTextWidget(
            text: label + ": ",
            fontSize: 14.sp,
          ),
        ),
        Spacer(),
        CustomTextWidget(
          text: number,
          fontSize: 14.sp,
          fontweight: FontWeight.w600,
        ),
      ],
    );
  }
}



// class CartProductListTileButton extends StatelessWidget {
//   const CartProductListTileButton({
//     super.key,
//     required this.buttonHeight,
//     required this.buttonWidth,
//     required this.label,
//     required this.fontSize,
//     required this.fontWeight,
//   });

//   final double buttonHeight;
//   final double buttonWidth;
//   final String label;
//   final double fontSize;
//   final FontWeight fontWeight;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: buttonHeight,
//       width: buttonWidth,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(2),
//         border: Border.all(),
//       ),
//       child: Center(
//         child: CustomTextWidget(
//           text: label,
//           fontSize: fontSize,
//           fontweight: fontWeight,
//         ),
//       ),
//     );
//   }
// }
