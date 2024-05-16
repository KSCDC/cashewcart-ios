import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/core/base_url.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/main.dart';
import 'package:internship_sample/models/product_details_model.dart';
import 'package:internship_sample/models/product_model.dart';
import 'package:internship_sample/presentation/home/widgets/circle_avatar_list_item.dart';
import 'package:internship_sample/presentation/home/widgets/buy_now_tile.dart';
import 'package:internship_sample/presentation/home/widgets/value_added_products_tile.dart';
import 'package:internship_sample/presentation/home/widgets/sliding_image_tile.dart';
import 'package:internship_sample/presentation/home/widgets/sponsered_product_tile.dart';
import 'package:internship_sample/presentation/home/widgets/view_offer_tile.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/shop/shop_screen.dart';
import 'package:internship_sample/presentation/side_bar/side_bar.dart';
import 'package:internship_sample/presentation/widgets/products_list_item_tile.dart';
import 'package:internship_sample/presentation/widgets/search_section_tile.dart';
import 'package:internship_sample/presentation/widgets/custom_search_filtering_button.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/presentation/widgets/main_appbar.dart';
import 'package:internship_sample/services/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ProductDetailsModel? controller.productDetails.value;

// ProductModel? currentCategoryProducts;

String? currentDisplayProductCategory;

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final pageController = PageController();
  AppController controller = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    if (!controller.isAlreadyLoadedcircleAvatarProducts) {}
    if (!controller.isAlreadyLoadedPlainCashews) {
      controller.getProductsByCategory("PLAIN CASHEWS", "");
    }
    if (!controller.isAlreadyLoadedRoastedAndSaltedCashews) {
      controller.getProductsByCategory("ROASTED AND SALTED CASHEWS", "");
    }
    if (!controller.isAlreadyLoadedValueAdded) {
      controller.getProductsByCategory("VALUE ADDED CASHEW PRODUCTS", "");
    }
    if (!controller.isAlreadyLoadedAllProducts) {
      log("getting all products");
      controller.getAllProducts();
    }
    // if (!controller.isAlreadyLoadedBestsellers) {
    //   controller.getBestSellerProducts();
    // }
    // if (!controller.isAlreadyLoadedSponserd) {
    //   controller.getSponserdProducts();
    // }

    controller.getCartList();

    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MainAppBar(),
      drawer: SideBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SearchSectionTile(),
              Obx(() {
                // if (controller.isLoading.value) {
                //   return Center(
                //     child: CircularProgressIndicator(),
                //   );
                // } else {
                // print("count : ${controller.searchResults.value.count}");
                // print("total count :${controller.searchResults.value.results!.length}");
                print("have seawrchresult : ${controller.haveSearchResult.value}");
                if (!controller.haveSearchResult.value) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // circular list
                      Container(
                        height: 120,
                        child: Obx(
                          () {
                            return controller.isCircleAvatarProductsLoading.value
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ListView.builder(
                                    itemBuilder: (context, index) {
                                      String productImageUrl = '';
                                      if (controller.circleAvatarProductsList.isNotEmpty) {
                                        productImageUrl = controller.circleAvatarProductsList[index].product.productImages.isNotEmpty
                                            ? "$baseUrl${controller.circleAvatarProductsList[index].product.productImages[0].productImage}"
                                            : "https://t3.ftcdn.net/jpg/05/04/28/96/240_F_504289605_zehJiK0tCuZLP2MdfFBpcJdOVxKLnXg1.jpg";
                                      }

                                      final productName = controller.circleAvatarProductsList[index].product.name;
                                      return CircleAvatarListItem(
                                        imagePath: productImageUrl,
                                        label: productName,
                                      );
                                    },
                                    itemCount: controller.circleAvatarProductsList.length,
                                    scrollDirection: Axis.horizontal,
                                  );
                          },
                        ),
                      ),

                      kHeight,
                      //sliding windows
                      // Obx(() {
                      //   return controller.isPlainCashewLoading.value || controller.isRoastedAndSaltedLoading.value
                      //       ? SizedBox(
                      //           height: 230,
                      //           width: screenSize.width * 0.9,
                      //           child: Center(
                      //             child: CircularProgressIndicator(),
                      //           ),
                      //         )
                      //       : SizedBox(
                      //           height: 230,
                      //           width: screenSize.width * 0.9,
                      //           child: controller.isPlainCashewLoadingError.value
                      //               ? Center(
                      //                   child: CustomTextWidget(
                      //                     text: "Loading failed. Please check your internet connection",
                      //                     textAlign: TextAlign.center,
                      //                   ),
                      //                 )
                      //               : PageView(
                      //                   controller: pageController,
                      //                   children: [
                      //                     SlidingImageTile(
                      //                       productDetails: controller.plainCashews[0],
                      //                     ),
                      //                     SlidingImageTile(
                      //                       productDetails: controller.roastedAndSalted[0],
                      //                     ),
                      //                     if (controller.valueAdded.isNotEmpty)
                      //                       SlidingImageTile(
                      //                         productDetails: controller.valueAdded[0],
                      //                       ),
                      //                   ],
                      //                 ),
                      //         );
                      // }),
                      SizedBox(height: 10),
                      Center(
                        child: SmoothPageIndicator(
                          controller: pageController,
                          count: 3,
                          effect: const WormEffect(
                            dotColor: Color(0xFFDEDBDB),
                            activeDotColor: Color(0xFFFFA3B3),
                            dotHeight: 10,
                            dotWidth: 10,
                            spacing: 15,
                          ),
                          onDotClicked: (index) {
                            pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );
                          },
                        ),
                      ),

                      // SizedBox(
                      //   width: double.infinity,
                      //   child: Image(
                      //     image: AssetImage("lib/core/assets/images/home/banners/Premium_cashew_kernels.jpg"),
                      //   ),
                      // ),
                      SizedBox(height: 10),
                      ViewOfferTile(
                        color: Color(0xFF4392F9),
                        mainLabel: "Deal of the Day",
                        icon: Icons.timer_outlined,
                        subLabel: "22h 55m 20s remaining",
                      ),
                      kHeight,

                      // best sellers
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextWidget(
                            text: "Best Sellers",
                            fontSize: 18,
                            fontweight: FontWeight.w600,
                          ),
                          Container(
                            height: 250,
                            child: Obx(
                              () => controller.isBestSellersLoading.value
                                  ? SizedBox(
                                      width: screenSize.width * 0.4,
                                      height: 300,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : controller.isBestSellersLoadingError.value
                                      ? Center(
                                          child: CustomTextWidget(
                                            text: "Loading bestsellers failed. Please check your internet connection",
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      : controller.bestSellers.value.isEmpty
                                          ? Center(
                                              child: CustomTextWidget(text: "No best sellers found"),
                                            )
                                          : ListView.builder(
                                              itemBuilder: (context, index) {
                                                final productDetails = controller.bestSellers.value[index].product;
                                                // print("${productDetails.product.productImages[0].productImage}");

                                                return GestureDetector(
                                                  onTap: () async {
                                                    final String productId = controller.bestSellers.value[index].product.product.productId.toString();
                                                    Services().getProductDetailsAndGotoShopScreen(productId);
                                                    // controller.getSimilarProducts(controller.plainCashews.value, index);
                                                  },
                                                  child: ProductsListItemTile(
                                                    productDetails: productDetails,
                                                    imagePath: productDetails.product.productImages.isNotEmpty
                                                        ? "$baseUrl${productDetails.product.productImages[0].productImage}"
                                                        : "https://t3.ftcdn.net/jpg/05/04/28/96/240_F_504289605_zehJiK0tCuZLP2MdfFBpcJdOVxKLnXg1.jpg",
                                                  ),
                                                );
                                              },
                                              itemCount: controller.bestSellers.value.length,
                                              scrollDirection: Axis.horizontal,
                                            ),
                            ),
                          ),
                        ],
                      ),
                      kHeight,

                      //special offers

                      Container(
                        height: 84,
                        width: screenSize.width * 0.9,
                        child: Row(
                          children: [
                            Image.asset("lib/core/assets/images/home/special_offer.png"),
                            SizedBox(width: 20),
                            Container(
                              width: 180,
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextWidget(text: "Special Offers 😱"),
                                  CustomTextWidget(
                                    text: "We make sure you get the offer you need at best prices",
                                    fontSize: 12,
                                    fontweight: FontWeight.w300,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      kHeight,

                      //buy now

                      Obx(() {
                        return controller.isPlainCashewLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : BuyNowTile(
                                productDetails: controller.allProducts.value,
                              );
                      }),

                      Obx(() {
                        return controller.isTrendingLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : controller.isTrendingLoadingError.value
                                ? const Center(
                                    child: CustomTextWidget(text: "Loading trending products failed. Please check your internet connection"),
                                  )
                                : ViewOfferTile(
                                    onPressed: () {
                                      if (!controller.isAlreadyLoadedTrending) {
                                        controller.getTrendingProducts();
                                      }

                                      // controller.productDisplayList2 = controller.trending;
                                      // print("Trending : ${controller.productDisplayList2.value.count}");
                                      previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                                      bottomNavbarIndexNotifier.value = 9;
                                    },
                                    color: Color(0xFFFD6E87),
                                    mainLabel: "Trending Products",
                                    icon: Icons.calendar_month,
                                    subLabel: "Last Date 29/02/22",
                                  );
                      }),

                      // products list

                      // SizedBox(
                      //   height: 250,
                      //   child: Obx(
                      //     () => controller.isAllProductsLoading.value
                      //         ? SizedBox(
                      //             width: screenSize.width * 0.4,
                      //             height: 300,
                      //             child: const Center(
                      //               child: CircularProgressIndicator(),
                      //             ),
                      //           )
                      //         : ListView.builder(
                      //             itemBuilder: (context, index) {
                      //               final productDetails = controller.allProducts.value.results![index];

                      //               return GestureDetector(
                      //                 onTap: () async {
                      //                   final String productId = controller.allProducts.value.results!.isNotEmpty ? controller.allProducts.value.results![index].product.id.toString() : "";

                      //                  await controller.getProductDetails(productId);
                      //                   controller.productDetailsList.add(controller.productDetails.value!);
                      //                   previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                      //                   bottomNavbarIndexNotifier.value = 4;
                      //                   controller.getProductReviews(productId);
                      //                   controller.getSimilarProducts(controller.allProducts.value, index);
                      //                 },
                      //                 child: ProductsListItemTile(
                      //                   productDetails: productDetails,
                      //                 ),
                      //               );
                      //             },
                      //             itemCount: controller.allProducts.value.results?.length,
                      //             scrollDirection: Axis.horizontal,
                      //           ),
                      //   ),
                      // ),
                      const SizedBox(height: 10),

                      // value added products

                      ValueAddedProductsTile(),
                      const SizedBox(height: 15),

                      //Sponsered product
                      Obx(
                        () {
                          if (controller.sponserd.value.isEmpty) {
                            return SizedBox(
                              width: screenSize.width * 0.95,
                              height: screenSize.width * 0.8,
                              child: const Center(child: CustomTextWidget(text: "No sponserd products right now")),
                            );
                          } else {
                            // log(controller.sponserd.value.toString());
                            final String imagePath = controller.sponserd.value[0].product.product.productImages.isNotEmpty
                                ? "$baseUrl${controller.sponserd.value[0].product!.product.productImages[0].productImage}"
                                : "https://t3.ftcdn.net/jpg/05/04/28/96/240_F_504289605_zehJiK0tCuZLP2MdfFBpcJdOVxKLnXg1.jpg";
                            return controller.isSponserdLoading.value
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : GestureDetector(
                                    child: SponseredProductTile(
                                      imagePath: imagePath,
                                    ),
                                  );
                          }
                        },
                      ),
                      kHeight,
                      const CustomTextWidget(
                        text: "All Featured Products",
                        fontSize: 18,
                        fontweight: FontWeight.w600,
                      ),
                      Obx(() {
                        return controller.isAllProductsLoading.value
                            ? SizedBox(
                                width: screenSize.width,
                                height: 300,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : Column(
                                children: [
                                  GridView.count(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    childAspectRatio: (20 / 30),
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 5,
                                    crossAxisSpacing: 5,
                                    children: List.generate(controller.allProducts.value.length, (index) {
                                      final productDetails = controller.allProducts.value[index];
                                      return GestureDetector(
                                        onTap: () async {
                                          final String productId = controller.allProducts.value[index].product.productId.toString();

                                          // controller.getSimilarProducts(controller.allProducts.value, index);

                                          Services().getProductDetailsAndGotoShopScreen(productId);
                                        },
                                        child: ProductsListItemTile(
                                          productDetails: productDetails,
                                        ),
                                      );
                                    }),
                                  ),
                                  kHeight,
                                  // if (controller.allProducts.value.next != null)
                                  //   GestureDetector(
                                  //     onTap: () {
                                  //       controller.allProductsPageNo++;
                                  //       controller.getAllProducts();
                                  //     },
                                  //     child: CustomTextWidget(text: "Load More"),
                                  //   ),
                                  kHeight,
                                ],
                              );
                      })
                    ],
                  );
                } else {
                  int count = 0;
                  // print("displaying search results");
                  // log("total result count :${controller.searchResults.value.length}");
                  return controller.searchResults.value.length == 0
                      ? const Center(
                          child: CustomTextWidget(
                            text: "Product not found",
                            fontSize: 16,
                          ),
                        )
                      : GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          childAspectRatio: (20 / 30),
                          crossAxisCount: 2,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          children: List.generate(controller.searchResults.value.length, (index) {
                            count++;
                            // print("total count :${controller.searchResults.value.length}");
                            print("generating results");
                            print(count);
                            final productDetails = controller.searchResults.value[index];

                            return GestureDetector(
                              onTap: () async {
                                final String productId = controller.searchResults.value[index].product.productId.toString();
                                // controller.getSimilarProducts(controller.searchResults.value, index);
                                await controller.getProductDetails(productId);
                                controller.productDetailsList.add(controller.productDetails.value!);
                                previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                                bottomNavbarIndexNotifier.value = 4;
                              },
                              child: ProductsListItemTile(
                                productDetails: productDetails,
                              ),
                            );
                          }),
                        );
                }
                // }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
