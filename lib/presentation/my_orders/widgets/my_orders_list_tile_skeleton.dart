import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cashew_cart/core/constants.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyOrdersListTileSkeleton extends StatelessWidget {
  const MyOrdersListTileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row Skeleton
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                          text: "Order #12345678",
                          fontSize: 16.sp,
                          fontweight: FontWeight.w700,
                          fontColor: Colors.black,
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 14.sp,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 6.w),
                            CustomTextWidget(
                              text: "15 Jun 2024",
                              fontSize: 13.sp,
                              fontColor: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Payment Status Badge Skeleton
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6.w,
                          height: 6.h,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        CustomTextWidget(
                          text: "Paid",
                          fontSize: 12.sp,
                          fontweight: FontWeight.w600,
                          fontColor: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              // Items Count Skeleton
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 8.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      size: 16.sp,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 8.w),
                    CustomTextWidget(
                      text: "3 items",
                      fontSize: 14.sp,
                      fontweight: FontWeight.w500,
                      fontColor: Colors.grey,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              // Order Summary Card Skeleton
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    SkeletonOrderSummaryRow(
                      label: "Subtotal",
                      value: "₹850.00",
                    ),
                    SizedBox(height: 8.h),
                    SkeletonOrderSummaryRow(
                      label: "Delivery",
                      value: "₹50.00",
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      height: 1,
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(height: 12.h),
                    SkeletonOrderSummaryRow(
                      label: "Total",
                      value: "₹900.00",
                      isTotal: true,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              // View Details Button Skeleton
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextWidget(
                          text: "View Details",
                          fontSize: 13.sp,
                          fontweight: FontWeight.w600,
                          fontColor: Colors.grey,
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12.sp,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SkeletonOrderSummaryRow extends StatelessWidget {
  const SkeletonOrderSummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  final String label;
  final String value;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextWidget(
          text: label,
          fontSize: isTotal ? 15.sp : 14.sp,
          fontweight: isTotal ? FontWeight.w600 : FontWeight.w500,
          fontColor: Colors.grey,
        ),
        CustomTextWidget(
          text: value,
          fontSize: isTotal ? 16.sp : 14.sp,
          fontweight: FontWeight.w700,
          fontColor: Colors.grey,
        ),
      ],
    );
  }
}
