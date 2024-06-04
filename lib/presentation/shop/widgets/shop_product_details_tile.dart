import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/controllers/cart_controller.dart';
import 'package:internship_sample/controllers/product_details_controller.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/presentation/cart/cart_screen.dart';
import 'package:internship_sample/presentation/home/home_screen.dart';
import 'package:internship_sample/presentation/policies_and_T&C/cancellation_policy_screen.dart';
import 'package:internship_sample/presentation/shop/widgets/custom_styled_shop_page_button.dart';
import 'package:internship_sample/presentation/shop/widgets/custom_text_icon_button.dart';
import 'package:internship_sample/presentation/shop/widgets/size_selector_widget.dart';
import 'package:internship_sample/presentation/widgets/custom_star_rating_tile.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/services/services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  // AppController controller = Get.put(AppController());
  ProductDetailsController productDetailsController = Get.put(ProductDetailsController());
  CartController cartController = Get.put(CartController());
  double priceWithGST = 0;

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
                double cgstPrice = double.parse(productDetailsController.productDetails.value!.productVariants[value].sellingPrice) *
                    (double.parse(productDetailsController.productDetails.value!.productVariants[value].cgstRate) / 100);
                double sgstPrice = double.parse(productDetailsController.productDetails.value!.productVariants[value].sellingPrice) *
                    (double.parse(productDetailsController.productDetails.value!.productVariants[value].cgstRate) / 100);
                double sellingPrice = double.parse(productDetailsController.productDetails.value!.productVariants[value].sellingPrice);
                priceWithGST = sellingPrice + cgstPrice + sgstPrice;
                return Row(
                  children: [
                    CustomTextWidget(
                      text: "Net weight: ",
                      fontweight: FontWeight.w600,
                    ),
                    for (int i = 0; i < productDetailsController.productDetails.value!.productVariants.length; i++)
                      if (value == i)
                        CustomTextWidget(
                          text: double.parse(productDetailsController.productDetails.value!.productVariants[i].weightInGrams) < 1000
                              ? "${productDetailsController.productDetails.value!.productVariants[i].weightInGrams} GM"
                              : "${double.parse(productDetailsController.productDetails.value!.productVariants[i].weightInGrams) / 1000} KG",
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < productDetailsController.productDetails.value!.productVariants.length; i++)
                      SizeSelectorWidget(
                        index: i,
                        label: double.parse(productDetailsController.productDetails.value!.productVariants[i].weightInGrams) < 1000
                            ? "${productDetailsController.productDetails.value!.productVariants[i].weightInGrams} GM"
                            : "${double.parse(productDetailsController.productDetails.value!.productVariants[i].weightInGrams) / 1000} KG",
                        fontColor: sizeSelectNotifier.value == i ? Colors.white : kMainThemeColor,
                        backgroundColor: sizeSelectNotifier.value == i ? kMainThemeColor : Colors.white,
                      ),
                  ],
                );
              }),
          // ValueListenableBuilder(
          //   valueListenable: sizeSelectNotifier,
          //   builder: (context, value, _) {

          //   },
          // ),
          SizedBox(height: 10),
          CustomTextWidget(
            text: productDetailsController.productDetails.value!.name,
            fontSize: 20,
            fontweight: FontWeight.w600,
          ),

          // SizedBox(height: 10),
          Obx(() {
            return CustomStarRatingTile(
              numberOfRatings: productDetailsController.avgRating.value,
              iconAndTextSize: 18,
            );
          }),
          ValueListenableBuilder(
              valueListenable: sizeSelectNotifier,
              builder: (context, value, _) {
                int stock = productDetailsController.productDetails.value!.productVariants[value].stockQty;
                bool isAvailable = productDetailsController.productDetails.value!.productVariants[value].isAvailable;
                String weight = productDetailsController.productDetails.value!.productVariants[value].weightInGrams;

                return Column(
                  children: [
                    Row(
                      children: [
                        if (productDetailsController.productDetails.value!.productVariants[value].actualPrice != productDetailsController.productDetails.value!.productVariants[value].sellingPrice)
                          Text(
                            "₹${productDetailsController.productDetails.value!.productVariants[value].actualPrice}",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 14,
                              color: Color(0xFF808488),
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Color(0xFF808488),
                            ),
                          ),
                        if (productDetailsController.productDetails.value!.productVariants[value].actualPrice != productDetailsController.productDetails.value!.productVariants[value].sellingPrice)
                          kWidth,
                        CustomTextWidget(
                          text: "₹ ${priceWithGST.toStringAsFixed(2)}",
                          fontSize: 24.sp,
                          fontweight: FontWeight.w600,
                          fontColor: kMainThemeColor,
                        ),
                        kWidth,
                        if (productDetailsController.productDetails.value!.productVariants[value].actualPrice != productDetailsController.productDetails.value!.productVariants[value].sellingPrice)
                          CustomTextWidget(
                            text: "${productDetailsController.productDetails.value!.productVariants[value].discountPercentage}%",
                            fontColor: kMainThemeColor,
                            fontSize: 14,
                            fontweight: FontWeight.w400,
                          ),
                      ],
                    ),
                    SizedBox(height: 10.w),
                    if (stock < 1 || !isAvailable)
                      Center(
                        child: Container(
                          height: 40.w,
                          width: 200.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFFdc2626), // Set the border color
                              width: 2, // Set the border width
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: CustomTextWidget(
                              text: double.parse(weight) < 1000 ? "$weight GM Out of stock" : "${double.parse(weight) / 1000} KG Out of stock",
                              fontColor: Color(0xFFdc2626),
                              fontweight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    else
                      GestureDetector(
                        onTap: () async {
                          // context.loaderOverlay.show();
                          SharedPreferences sharedPref = await SharedPreferences.getInstance();
                          String? email = sharedPref.getString(EMAIL);
                          String? password = sharedPref.getString(ENCRYPTEDPASSWORD);

                          if (email != null && password != null) {
                            int stock = productDetailsController.productDetails.value!.productVariants[value].stockQty;
                            bool isAvailable = productDetailsController.productDetails.value!.productVariants[value].isAvailable;

                            if (stock > 0 && isAvailable) {
                              await cartController.addProductToCart(context, productDetailsController.productDetails.value!.productVariants[value].productVariantId.toString());
                              double parsedPrice = double.tryParse(productDetailsController.productDetails.value!.productVariants[value].sellingPrice ?? '')?.toDouble() ?? 0.0;

                              grantTotalNotifier.value = grantTotalNotifier.value + parsedPrice;
                            } else {
                              Services().showCustomSnackBar(context, "This item is currently unavailable");
                            }
                          } else {
                            Services().showLoginAlert(context, "Please login for adding product to your cart");
                          }
                          // context.loaderOverlay.hide();
                        },
                        child: const CustomStyledShopPageButton(
                          gradientColors: [
                            Color(0xFF3F92FF),
                            Color(0xFF0B3689),
                          ],
                          icon: Icons.shopping_cart_outlined,
                          label: "Add to cart",
                        ),
                      ),
                    SizedBox(height: 10.w),
                  ],
                );
              }),

          kHeight,
          CustomTextWidget(
            text: "Product Description",
            fontSize: 16.sp,
            fontweight: FontWeight.w600,
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
                          text: productDetailsController.productDetails.value!.description.replaceAll('\n', ''),
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

          kHeight,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // CustomTextIconButton(
              //   onPressed: () {},
              //   icon: Icons.location_on_outlined,
              //   label: "Nearest Store",
              //   textAndIconColor: Color(0xFF828282),
              //   textAndIconSize: 12,
              // ),
              // kWidth,
              // CustomTextIconButton(
              //   onPressed: () {},
              //   icon: Icons.lock_outline_sharp,
              //   label: "VIP",
              //   textAndIconColor: Color(0xFF828282),
              //   textAndIconSize: 12,
              // ),
              // kWidth,
              // CustomTextIconButton(
              //   onPressed: () {
              //     Get.to(() => CancellationPolicyScreen());
              //   },
              //   icon: Icons.lock_outline_sharp,
              //   label: "Return & Refund Policy",
              //   textAndIconColor: Color(0xFF828282),
              //   textAndIconSize: 12.sp,
              // ),
            ],
          )
        ],
      ),
    );
  }
}
