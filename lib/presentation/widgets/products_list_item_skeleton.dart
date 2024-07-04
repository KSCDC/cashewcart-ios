import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cashew_cart/presentation/widgets/custom_star_rating_tile.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductsListItemTileSkeleton extends StatelessWidget {
  const ProductsListItemTileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Skeletonizer(
      enabled: true,
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.w),
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 5,
          ),
          width: screenSize.width * 0.4,
          // height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            // border: Border.all(
            //   width: 0.1,
            //   color: Colors.grey,
            // ),
            borderRadius: BorderRadius.all(
              Radius.circular(10.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 1,
                blurRadius: 8,
                offset: Offset(2, 4),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: screenSize.width * 0.4,
                    decoration: BoxDecoration(
                      // image: DecorationImage(
                      //   image: NetworkImage(imagePath),
                      //   fit: BoxFit.fitHeight,
                      // ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5.w),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                          text: "Product Name",
                          fontSize: 12.sp,
                          fontweight: FontWeight.w500,
                        ),
                        SizedBox(height: 5.w),
                        Text(
                          "Some random description",
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w400,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        CustomTextWidget(
                          text: "₹ 234.23",
                          fontSize: 12.sp,
                          fontweight: FontWeight.w500,
                        ),
                        Row(
                          children: [
                            Text(
                              "₹ 234.2",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 15.sp,
                                color: Color(0xFF808488),
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Color(0xFF808488),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            // CustomTextWidget(
                            //   text: offerPrice == "" || originalPrice == "" ? "" : "${((double.parse(offerPrice) * 100 / double.parse(originalPrice))).toStringAsFixed(2)}%",
                            //   fontColor: Color(0xFFFE735C),
                            //   fontSize: 10.w,
                            //   fontweight: FontWeight.w400,
                            // )
                          ],
                        ),
                        CustomStarRatingTile(
                          numberOfRatings: 4.toDouble(),
                          iconAndTextSize: 10.sp,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
