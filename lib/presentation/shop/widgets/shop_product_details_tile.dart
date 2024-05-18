import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/presentation/home/home_screen.dart';
import 'package:internship_sample/presentation/shop/widgets/custom_text_icon_button.dart';
import 'package:internship_sample/presentation/shop/widgets/size_selector_widget.dart';
import 'package:internship_sample/presentation/widgets/custom_star_rating_tile.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

ValueNotifier<int> sizeSelectNotifier = ValueNotifier(0);

class ShopProductDetailsTile extends StatelessWidget {
  ShopProductDetailsTile({
    super.key,
    // required this.productName,
    // required this.description,
  });
  ValueNotifier<bool> readMoreClickNotifier = ValueNotifier(false);
  // final String productName;
  // final String description;
  AppController controller = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    sizeSelectNotifier.value = 0;
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder(
              valueListenable: sizeSelectNotifier,
              builder: (context, value, _) {
                return Row(
                  children: [
                    CustomTextWidget(
                      text: "Net weight: ",
                      fontweight: FontWeight.w600,
                    ),
                    for (int i = 0; i < controller.productDetails.value!.productVariants.length; i++)
                      if (value == i)
                        CustomTextWidget(
                          text: "${controller.productDetails.value!.productVariants[i].weightInGrams} GM",
                          fontweight: FontWeight.w600,
                        ),
                  ],
                );
              }),
          SizedBox(height: 10),
          ValueListenableBuilder(
              valueListenable: sizeSelectNotifier,
              builder: (context, value, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < controller.productDetails.value!.productVariants.length; i++)
                      SizeSelectorWidget(
                        index: i,
                        label: "${controller.productDetails.value!.productVariants[i].weightInGrams} GM",
                        fontColor: sizeSelectNotifier.value == i ? Colors.white : kMainThemeColor,
                        backgroundColor: sizeSelectNotifier.value == i ? kMainThemeColor : Colors.white,
                      ),
                  ],
                );
              }),
          SizedBox(height: 10),
          CustomTextWidget(
            text: controller.productDetails.value!.name,
            fontSize: 20,
            fontweight: FontWeight.w600,
          ),

          // SizedBox(height: 10),
          Obx(() {
            return CustomStarRatingTile(
              numberOfRatings: controller.avgRating.value,
              iconAndTextSize: 18,
            );
          }),
          ValueListenableBuilder(
              valueListenable: sizeSelectNotifier,
              builder: (context, value, _) {
                return Row(
                  children: [
                    Text(
                      "₹${controller.productDetails.value!.productVariants[value].actualPrice}",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 14,
                        color: Color(0xFF808488),
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Color(0xFF808488),
                      ),
                    ),
                    kWidth,
                    CustomTextWidget(
                      text: "₹${controller.productDetails.value!.productVariants[value].sellingPrice}",
                      fontSize: 14,
                      fontweight: FontWeight.w400,
                    ),
                    kWidth,
                    CustomTextWidget(
                      text: "${controller.productDetails.value!.productVariants[value].discountPercentage}%",
                      fontColor: kMainThemeColor,
                      fontSize: 14,
                      fontweight: FontWeight.w400,
                    ),
                  ],
                );
              }),
          kHeight,
          CustomTextWidget(
            text: "Product Details",
            fontSize: 15,
            fontweight: FontWeight.w500,
          ),

          ValueListenableBuilder(
            valueListenable: readMoreClickNotifier,
            builder: (context, value, _) {
              return Wrap(
                children: [
                  ValueListenableBuilder(
                      valueListenable: sizeSelectNotifier,
                      builder: (context, value, _) {
                        return CustomTextWidget(
                          text: controller.productDetails.value!.description.replaceAll('\n', ''),
                          maxLines: readMoreClickNotifier.value ? 20 : 5,
                          textOverflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                        );
                      }),
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.all(6),
                    child: GestureDetector(
                      child: Text(
                        readMoreClickNotifier.value ? "Less" : "More",
                        style: TextStyle(
                          color: kMainThemeColor,
                        ),
                      ),
                      onTap: () {
                        readMoreClickNotifier.value = !(readMoreClickNotifier.value);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: sizeSelectNotifier,
            builder: (context, value, _) {
              int stock = controller.productDetails.value!.productVariants[value].stockQty;
              bool isAvailable = controller.productDetails.value!.productVariants[value].isAvailable;
              String weight = controller.productDetails.value!.productVariants[value].weightInGrams;
              if (stock < 1 || !isAvailable) {
                return Center(
                  child: Container(
                    height: 40.w,
                    width: 200.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.red, // Set the border color
                        width: 1, // Set the border width
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: CustomTextWidget(
                        text: "$weight GM Out of stock",
                        fontColor: Colors.red,
                      ),
                    ),
                  ),
                );
              } else
                return SizedBox();
            },
          ),
          kHeight,
          Row(
            children: [
              CustomTextIconButton(
                onPressed: () {},
                icon: Icons.location_on_outlined,
                label: "Nearest Store",
                textAndIconColor: Color(0xFF828282),
                textAndIconSize: 12,
              ),
              kWidth,
              CustomTextIconButton(
                onPressed: () {},
                icon: Icons.lock_outline_sharp,
                label: "VIP",
                textAndIconColor: Color(0xFF828282),
                textAndIconSize: 12,
              ),
              kWidth,
              CustomTextIconButton(
                onPressed: () {},
                icon: Icons.lock_outline_sharp,
                label: "Return Policy",
                textAndIconColor: Color(0xFF828282),
                textAndIconSize: 12,
              ),
            ],
          )
        ],
      ),
    );
  }
}
