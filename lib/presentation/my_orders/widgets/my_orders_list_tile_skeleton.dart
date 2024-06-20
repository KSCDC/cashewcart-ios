import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/presentation/my_orders/widgets/my_orders_list_tile.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyOrdersListTileSkeleton extends StatelessWidget {
  const MyOrdersListTileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomTextWidget(
                    text: "Order ID : 1234",
                    fontSize: 14.sp,
                    fontweight: FontWeight.w600,
                    fontColor: Colors.black,
                  ),
                ],
              ),
              CustomTextWidget(
                text: "Order placed on 10 june 2024",
                fontSize: 14.sp,
              ),
              const OrderListLine(label: "Number of items", number: "4"),
              const OrderListLine(label: "Sub Total", number: "₹ 1234.00"),
              const OrderListLine(label: "Delivery charge", number: "₹ 123.00"),
              const OrderListLine(label: "Grand Total", number: "₹ 1234.00"),
              SizedBox(height: 10.w),
              Row(
                children: [
                  CustomTextWidget(
                    text: "Payment status : ",
                    fontSize: 14.sp,
                    fontweight: FontWeight.w600,
                  ),
                  CustomTextWidget(
                    text: "status",
                    fontColor: Colors.black,
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
      ),
    );
  }
}
