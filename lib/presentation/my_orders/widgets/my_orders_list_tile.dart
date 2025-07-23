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
    this.onTap,
  });
  
  final OrdersListModel currentItem;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final String orderId = currentItem.orderId.toString();
    final String paymentStatus = currentItem.paymentStatus;
    final int totalItems = currentItem.items.length;
    final DateTime date = currentItem.createdAt;
    final num subTotal = currentItem.subTotalAmount;
    final num deliveryCharge = currentItem.deliveryAdditionalAmount;
    final num grandTotal = currentItem.totalAmount;
    String orderPlacedDate = DateFormat('dd MMM yyyy').format(date);
    
    // Payment status configuration
    PaymentStatusConfig statusConfig = _getPaymentStatusConfig(paymentStatus);
    
    return Container(
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextWidget(
                            text: "Order #$orderId",
                            fontSize: 16.sp,
                            fontweight: FontWeight.w700,
                            fontColor: const Color(0xFF1A1A1A),
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today_outlined,
                                size: 14.sp,
                                color: const Color(0xFF6B7280),
                              ),
                              SizedBox(width: 6.w),
                              CustomTextWidget(
                                text: orderPlacedDate,
                                fontSize: 13.sp,
                                fontColor: const Color(0xFF6B7280),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Payment Status Badge
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: statusConfig.backgroundColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6.w,
                            height: 6.h,
                            decoration: BoxDecoration(
                              color: statusConfig.dotColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          CustomTextWidget(
                            text: statusConfig.label,
                            fontSize: 12.sp,
                            fontweight: FontWeight.w600,
                            fontColor: statusConfig.textColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 20.h),
                
                // Items Count
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: const Color(0xFFE2E8F0),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined,
                        size: 16.sp,
                        color: kMainThemeColor,
                      ),
                      SizedBox(width: 8.w),
                      CustomTextWidget(
                        text: "$totalItems ${totalItems == 1 ? 'item' : 'items'}",
                        fontSize: 14.sp,
                        fontweight: FontWeight.w500,
                        fontColor: const Color(0xFF374151),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 16.h),
                
                // Order Summary Card
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAFAFA),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    children: [
                      ModernOrderSummaryRow(
                        label: "Subtotal",
                        value: "₹${subTotal.toStringAsFixed(2)}",
                      ),
                      SizedBox(height: 8.h),
                      ModernOrderSummaryRow(
                        label: "Delivery",
                        value: "₹${deliveryCharge.toStringAsFixed(2)}",
                      ),
                      SizedBox(height: 12.h),
                      Container(
                        height: 1,
                        color: const Color(0xFFE5E7EB),
                      ),
                      SizedBox(height: 12.h),
                      ModernOrderSummaryRow(
                        label: "Total",
                        value: "₹${grandTotal.toStringAsFixed(2)}",
                        isTotal: true,
                      ),
                    ],
                  ),
                ),
                
                if (onTap != null) ...[
                  SizedBox(height: 16.h),
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
                            color: kMainThemeColor.withOpacity(0.3),
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
                              fontColor: kMainThemeColor,
                            ),
                            SizedBox(width: 4.w),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12.sp,
                              color: kMainThemeColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  PaymentStatusConfig _getPaymentStatusConfig(String paymentStatus) {
    switch (paymentStatus) {
      case "SUCCESS":
        return PaymentStatusConfig(
          label: "Paid",
          backgroundColor: const Color(0xFFECFDF5),
          textColor: const Color(0xFF065F46),
          dotColor: const Color(0xFF10B981),
        );
      case "PAYMENT_NOT_STARTED":
        return PaymentStatusConfig(
          label: "Pending",
          backgroundColor: const Color(0xFFFEF3C7),
          textColor: const Color(0xFF92400E),
          dotColor: const Color(0xFFF59E0B),
        );
      default:
        return PaymentStatusConfig(
          label: "Failed",
          backgroundColor: const Color(0xFFFEF2F2),
          textColor: const Color(0xFF991B1B),
          dotColor: const Color(0xFFEF4444),
        );
    }
  }
}

class ModernOrderSummaryRow extends StatelessWidget {
  const ModernOrderSummaryRow({
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
          fontColor: isTotal ? const Color(0xFF111827) : const Color(0xFF6B7280),
        ),
        CustomTextWidget(
          text: value,
          fontSize: isTotal ? 16.sp : 14.sp,
          fontweight: FontWeight.w700,
          fontColor: isTotal ? kMainThemeColor : const Color(0xFF374151),
        ),
      ],
    );
  }
}

class PaymentStatusConfig {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final Color dotColor;

  PaymentStatusConfig({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    required this.dotColor,
  });
}