import 'dart:developer';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/controllers/product_details_controller.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/main.dart';
import 'package:internship_sample/models/product_details_model.dart';
import 'package:internship_sample/models/trending_product_model.dart';
import 'package:internship_sample/presentation/shop/widgets/review_tile.dart';
import 'package:internship_sample/presentation/shop/widgets/shop_product_details_tile.dart';
import 'package:internship_sample/presentation/widgets/custom_appbar.dart';
import 'package:internship_sample/presentation/widgets/custom_elevated_button.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/presentation/widgets/products_list_item_tile.dart';
import 'package:internship_sample/presentation/widgets/search_filter_bar.dart';
import 'package:internship_sample/presentation/widgets/sliding_product_tile.dart';
import 'package:internship_sample/services/services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<int> customerRatingNotifier = ValueNotifier(5);

class ShopScreen extends StatelessWidget {
  ShopScreen({
    super.key,
    required this.randomIndex,
    required this.randomProductList,
    required this.productDetails,
  });

  final int randomIndex;
  final List<TrendingProductModel> randomProductList;
  final ProductDetailsModel productDetails;

  AppController controller = Get.put(AppController());
  ProductDetailsController productDetailsController = Get.put(ProductDetailsController());

  @override
  Widget build(BuildContext context) {
    log("random num :$randomIndex");

    final screenSize = MediaQuery.of(context).size;

    TextEditingController reviewController = TextEditingController();

    return Scaffold(
      // appBar: AppBar(
      //   scrolledUnderElevation: 0,
      //   leading: IconButton(
      //     onPressed: () {
      //       if (controller.productDetailsList.isNotEmpty) {
      //         controller.productDetailsList.removeLast();
      //         print("Removing last : ${controller.productDetailsList}");
      //         print("length now : ${controller.productDetailsList.length}");
      //       }
      //       bottomNavbarIndexNotifier.value = previousPageIndexes.last;
      //       previousPageIndexes.removeLast();
      //     },
      //     icon: Icon(Icons.arrow_back_ios_new),
      //   ),
      // ),
      appBar: AppBar(
        // backgroundColor: kMainThemeColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
              print("Going back");
              productDetailsController.isLoading.value = false;
              log("is loading : ${productDetailsController.isLoading.value}");
            }
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 10),
        //     child: InkWell(
        //       onTap: () {
        //         Get.back();
        //       },
        //       child: SvgPicture.asset(
        //         "lib/core/assets/images/home_icon.svg",
        //         color: Colors.black,
        //       ),
        //     ),
        //   ),
        // ],
      ),

      body: LoaderOverlay(
        child: SingleChildScrollView(
          // controller: _scrollController,
          child: Obx(() {
            // ProductDetailsModel currentProductDetails = controller.productDetailsList[controller.productDetailsList.length - 1];
            // productDetailsController.isLoading.value ? context.loaderOverlay.show() : context.loaderOverlay.hide();
            return
                //  productDetailsController.isLoading.value
                // ? SizedBox(
                //     height: screenSize.height * 0.9,
                //     width: screenSize.width,
                //     child: Center(
                //       child: CircularProgressIndicator(),
                //     ),
                //   )
                // :
                Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SlidingProductTile(
                  imageList: productDetails.productImages,
                  count: productDetails.productImages.isNotEmpty ? productDetails.productImages.length : 1,
                ),



                // product details
                ShopProductDetailsTile(),




                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ValueListenableBuilder(
                      valueListenable: sizeSelectNotifier,
                      builder: (context, value, _) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // add to cart button

                            kWidth,

                            // buy now button
                            // GestureDetector(
                            //   onTap: () async {
                            //     print("buy now");
                            //     context.loaderOverlay.show();
                            //     SharedPreferences sharedPref = await SharedPreferences.getInstance();
                            //     String? email = sharedPref.getString(EMAIL);
                            //     String? password = sharedPref.getString(ENCRYPTEDPASSWORD);

                            //     if (email != null && password != null) {
                            //       productCountNotifier.value = 1;
                            //       // int stock = currentProductDetails.productVariants[i].stockQty;
                            //       bool isAvailable = controller.productDetails.value!.productVariants[value].isAvailable;

                            //       int stock = 1;
                            //       if (stock > 0 && isAvailable) {
                            //         controller.getUserAddresses();
                            //         // await controller.addProductToCart(context, currentProductDetails.productVariants[value]Id.toString());
                            //         controller.getCartList();
                            //         // previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                            //         bottomNavbarIndexNotifier.value = 2;
                            //         Get.to(() => MainPageScreen());
                            //       } else {
                            //         Services().showCustomSnackBar(context, "This item is currently unavailable");
                            //       }
                            //     } else {
                            //       Services().showLoginAlert(context, "Please login for for purchasing this product");
                            //     }
                            //     context.loaderOverlay.hide();
                            //   },
                            //   child: const CustomStyledShopPageButton(
                            //     gradientColors: [
                            //       Color(0xFF71F9A9),
                            //       Color(0xFF31B769),
                            //     ],
                            //     icon: Icons.touch_app_outlined,
                            //     label: "Buy Now",
                            //   ),
                            // ),
                          ],
                        );
                      }),
                ),

                kHeight,
                Obx(() {
                  print(
                      "Stars : ${productDetailsController.numOf1Stars},${productDetailsController.numOf2Stars},${productDetailsController.numOf3Stars},${productDetailsController.numOf4Stars},${productDetailsController.numOf5Stars}");

                  return productDetailsController.isReviewsLoading.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: CustomTextWidget(
                                text: "Customer Ratings and Reviews",
                                fontSize: 20.sp,
                                fontweight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    CustomTextWidget(
                                      text: "${productDetailsController.productReviewsList.length.toString()} Ratings and reviews",
                                      fontSize: 15.sp,
                                      fontweight: FontWeight.w600,
                                    ),
                                    CustomTextWidget(text: "Average rating : ${productDetailsController.avgRating}"),
                                    kHeight,
                                    Container(
                                      height: 40.w,
                                      width: 110.w,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey, // Set the border color
                                          width: 1, // Set the border width
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: GestureDetector(
                                          onTap: () async {
                                            SharedPreferences sharedPref = await SharedPreferences.getInstance();
                                            final email = sharedPref.getString(EMAIL);
                                            final password = sharedPref.getString(ENCRYPTEDPASSWORD);
                                            if (email != null && password != null) {
                                              await showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return Dialog(
                                                    insetAnimationDuration: Duration(milliseconds: 1000),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(6),
                                                      ),
                                                      width: screenSize.width * 0.9,
                                                      height: screenSize.width * 0.8,
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(15),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            ValueListenableBuilder(
                                                                valueListenable: customerRatingNotifier,
                                                                builder: (context, value, _) {
                                                                  return RatingStars();
                                                                }),
                                                            kHeight,
                                                            CustomTextWidget(text: "Enter your product review here"),
                                                            TextField(
                                                              controller: reviewController,
                                                              maxLines: 4, // Set to null for an unlimited number of lines
                                                              decoration: InputDecoration(
                                                                border: OutlineInputBorder(),
                                                              ),
                                                            ),
                                                            SizedBox(height: 20),
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.of(context).pop();
                                                              },
                                                              child: GestureDetector(
                                                                onTap: () {
                                                                  if (reviewController.text.trim() != "") {
                                                                    productDetailsController.addProductReview(
                                                                      context,
                                                                      productDetailsController.productDetails.value!.productId.toString(),
                                                                      reviewController.text,
                                                                      customerRatingNotifier.value,
                                                                    );
                                                                    Get.back();
                                                                  }
                                                                },
                                                                child: CustomElevatedButton(
                                                                  label: "Submit",
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            } else {
                                              Services().showLoginAlert(context, "Please login to add product review");
                                            }
                                          },
                                          child: CustomTextWidget(text: "Rate Product"),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  height: 100,
                                  width: 1,
                                  color: Colors.grey,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DisplayStars(
                                      numberOfStars: 5,
                                      rating: productDetailsController.numOf5Stars,
                                    ),
                                    DisplayStars(
                                      numberOfStars: 4,
                                      rating: productDetailsController.numOf4Stars,
                                    ),
                                    DisplayStars(
                                      numberOfStars: 3,
                                      rating: productDetailsController.numOf3Stars,
                                    ),
                                    DisplayStars(
                                      numberOfStars: 2,
                                      rating: productDetailsController.numOf2Stars,
                                    ),
                                    DisplayStars(
                                      numberOfStars: 1,
                                      rating: productDetailsController.numOf1Stars,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            kHeight,
                            for (int i = productDetailsController.productReviewsList.length - 1; i >= 0; i--)
                              ReviewTile(
                                  rating: productDetailsController.productReviewsList[i].stars,
                                  review: productDetailsController.productReviewsList[i].reviewText,
                                  reviewerName: productDetailsController.productReviewsList[i].userName),
                            // ReviewTile(rating: 4, review: "Good product", reviewerName: "Arun"),
                          ],
                        );
                }),
                kHeight,
                const Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTextWidget(
                    text: "Similar To",
                    fontSize: 20,
                    fontweight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTextWidget(
                    text: (controller.similarProducts.value.length - 1) < 0 ? "0" : "${(controller.similarProducts.value.length - 1).toString()}+",
                    fontSize: 20,
                    fontweight: FontWeight.w600,
                  ),
                ),

                Container(
                  height: 250,
                  child: Obx(
                    () {
                      // print("similar products length:${controller.similarProducts.value.length}");
                      // print("similar products length:${controller.similarProducts.value[0].weightInGrams}");
                      if (controller.similarProducts.length > 1) {
                        return controller.isSimilarProductsLoading.value
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                itemBuilder: (context, index) {
                                  final productDetails = controller.similarProducts[index];

                                  return GestureDetector(
                                    onTap: () async {
                                      // final String productId = productDetails.productVariantId.toString();
                                      // currentCategoryProducts = controller.roastedAndSalted.value;
                                      // await controller.getProductDetails(productId);
                                      // controller.productDetailsList.add(controller.productDetails.value!);
                                      // print(controller.productDetails.value!.name);

                                      // previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                                      // bottomNavbarIndexNotifier.value = 4;
                                      // Services().getProductDetailsAndGotoShopScreen(context, productId);
                                      final String productId = controller.similarProducts[index].product.productId.toString();

                                      Services().getProductDetailsAndGotoShopScreen(context, productId);
                                    },
                                    child: ProductsListItemTile(
                                      productDetails: productDetails,
                                    ),
                                  );
                                },
                                itemCount: controller.similarProducts.value.length - 1,
                                scrollDirection: Axis.horizontal,
                              );
                      } else {
                        return Center(
                          child: CustomTextWidget(text: "No similar products"),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 20),

                //related products

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTextWidget(
                    text: randomIndex == 0
                        ? "Trending Products"
                        : randomIndex == 1
                            ? "Sponserd Products"
                            : "Best Sellers",
                    fontSize: 20,
                    fontweight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTextWidget(
                    text: "${randomProductList.length.toString()}+",
                    fontSize: 20,
                    fontweight: FontWeight.w600,
                  ),
                ),

                Container(
                  height: 250,
                  child: Obx(
                    () {
                      // for showing shuffled list of all products as related products

                      if (randomProductList.isNotEmpty) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            final productDetails = randomProductList[index];

                            return GestureDetector(
                              onTap: () async {
                                // await controller.getProductDetails(productId);
                                // controller.productDetailsList.add(controller.productDetails.value!);
                                // print(controller.productDetails.value!.name);

                                // // previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                                // bottomNavbarIndexNotifier.value = 4;
                                final String productId = randomProductList[index].product.productId.toString();
                                Services().getProductDetailsAndGotoShopScreen(context, productId);
                              },
                              child: ProductsListItemTile(
                                productDetails: productDetails,
                              ),
                            );
                          },
                          itemCount: randomProductList!.length,
                          scrollDirection: Axis.horizontal,
                        );
                      } else {
                        return Center(
                          child: CustomTextWidget(text: "Related products not available right now."),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CustomTextWidget(
                    text: "ALL FEATURED PRODUCTS",
                    fontSize: 18,
                    fontweight: FontWeight.w600,
                  ),
                ),
                Container(
                  height: 250,
                  child: Obx(() {
                    return controller.isAllProductsLoading.value
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              final productDetails = controller.allProducts[index];

                              return GestureDetector(
                                onTap: () async {
                                  final String productId = controller.allProducts[index].product.productId.toString();
                                  Services().getProductDetailsAndGotoShopScreen(context, productId);
                                },
                                child: ProductsListItemTile(
                                  productDetails: productDetails,
                                ),
                              );
                            },
                            itemCount: controller.allProducts.length,
                            scrollDirection: Axis.horizontal,
                          );
                  }),
                ),
                SizedBox(height: 50.w)
              ],
            );
          }),
        ),
      ),
    );
  }
}

class RatingStars extends StatelessWidget {
  RatingStars({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 1; i <= 5; i++)
          GestureDetector(
            onTap: () {
              customerRatingNotifier.value = i;
            },
            child: Icon(
              Icons.star,
              color: customerRatingNotifier.value < i ? Colors.grey : Color(0xFFF7B305),
              size: 35,
            ),
          ),
      ],
    );
  }
}

class DisplayStars extends StatelessWidget {
  const DisplayStars({
    super.key,
    required this.numberOfStars,
    required this.rating,
  });
  final int numberOfStars;
  final int rating;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 45,
          child: CustomTextWidget(
            text: rating.toString(),
          ),
        ),
        for (int i = 0; i < numberOfStars; i++)
          Icon(
            Icons.star,
            color: Color(0xFFF7B305),
            size: 18,
          ),
      ],
    );
  }
}
