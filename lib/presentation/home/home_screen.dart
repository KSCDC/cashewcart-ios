import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/controllers/search_controller.dart';
import 'package:internship_sample/core/base_url.dart';
import 'package:internship_sample/core/colors.dart';
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
import 'package:internship_sample/presentation/product_list/trending_model_product_listing_screen.dart';
import 'package:internship_sample/presentation/shop/shop_screen.dart';
import 'package:internship_sample/presentation/side_bar/side_bar.dart';
import 'package:internship_sample/presentation/widgets/products_list_item_skeleton.dart';
import 'package:internship_sample/presentation/widgets/products_list_item_tile.dart';
import 'package:internship_sample/presentation/widgets/search_section_tile.dart';
import 'package:internship_sample/presentation/widgets/custom_search_filtering_button.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/presentation/widgets/main_appbar.dart';
import 'package:internship_sample/services/services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ProductDetailsModel? controller.productDetails.value;

// ProductModel? currentCategoryProducts;

String? currentDisplayProductCategory;

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final pageController = PageController();
  AppController controller = Get.put(AppController());
  // SearchController searchController = Get.put(SearchController());
  SearchResultController searchController = Get.put(SearchResultController());
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: kMainThemeColor,
      ),
    );
    startAutoSlide();

    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: MainAppBar(),
      drawer: SideBar(),
      body: LoaderOverlay(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: SearchSectionTile(),
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Column(
                    children: [
                      Obx(() {
                        // if (controller.isLoading.value) {
                        //   return Center(
                        //     child: CircularProgressIndicator(),
                        //   );
                        // } else {
                        // print("count : ${controller.searchResults.value.count}");
                        // print("total count :${controller.searchResults.value.results!.length}");
                        // print("have seawrchresult : ${searchController.haveSearchResult.value}");
                        if (!searchController.isSearchMode.value) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // circular list
                              if (controller.isCircleAvatarProductsLoading.value)
                                SizedBox(
                                  height: 120.w,
                                  // width: screenSize.width,
                                  child: ListView.builder(
                                      itemCount: 5,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Skeletonizer(
                                          enabled: true,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              height: 120.w,
                                              width: 85.w,
                                              child: Column(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 35,
                                                    backgroundColor: Colors.white,
                                                    // backgroundImage: NetworkImage(imagePath),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(40.r),
                                                      child: SizedBox(
                                                        height: 60,
                                                      ),
                                                    ),
                                                  ),
                                                  CustomTextWidget(
                                                    text: "Product name",
                                                    fontSize: 10,
                                                    fontweight: FontWeight.w400,
                                                    fontColor: Color(0xFF21003D),
                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                )
                              else
                                Container(
                                  height: 120.w,
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      String productImageUrl = '';
                                      if (controller.circleAvatarProductsList.isNotEmpty) {
                                        productImageUrl = controller.circleAvatarProductsList[index].product.productImages.isNotEmpty
                                            ? "$baseUrl${controller.circleAvatarProductsList[index].product.productImages[0].productImage}"
                                            : "https://t3.ftcdn.net/jpg/05/04/28/96/240_F_504289605_zehJiK0tCuZLP2MdfFBpcJdOVxKLnXg1.jpg";
                                      }

                                      final productName = controller.circleAvatarProductsList[index].product.name;
                                      return GestureDetector(
                                        onTap: () async {
                                          final String productId = controller.circleAvatarProductsList.value[index].product.productId.toString();

                                          // controller.getSimilarProducts(controller.allProducts.value, index);

                                          Services().getProductDetailsAndGotoShopScreen(context, productId);
                                        },
                                        child: CircleAvatarListItem(
                                          imagePath: productImageUrl,
                                          label: productName,
                                        ),
                                      );
                                    },
                                    itemCount: controller.circleAvatarProductsList.length,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                ),

                              kHeight,
                              //sliding windows
                              if (controller.isAllProductsLoading.value)
                                Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: Skeletonizer(
                                      enabled: true,
                                      child: Container(
                                        height: 230.w,
                                        width: screenSize.width * 0.9,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ),
                                )
                              else
                                SizedBox(
                                  height: 230.w,
                                  width: screenSize.width * 0.9,
                                  child: controller.isAllProductsLoadingError.value
                                      ? Center(
                                          child: CustomTextWidget(
                                            text: "Loading failed. Please check your internet connection",
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      : PageView(
                                          controller: pageController,
                                          children: [
                                            for (int i = 0; i < controller.slidingProductsList.length; i++)
                                              SlidingImageTile(
                                                productDetails: controller.slidingProductsList[i],
                                              ),
                                          ],
                                        ),
                                ),

                              SizedBox(height: 10.w),
                              Center(
                                child: Obx(() {
                                  return controller.slidingProductsList.isNotEmpty
                                      ? SmoothPageIndicator(
                                          controller: pageController,
                                          count: controller.slidingProductsList.length,
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
                                        )
                                      : SizedBox();
                                }),
                              ),

                              // SizedBox(
                              //   width: double.infinity,
                              //   child: Image(
                              //     image: AssetImage("lib/core/assets/images/home/banners/Premium_cashew_kernels.jpg"),
                              //   ),
                              // ),
                              // SizedBox(height: 10),
                              // ViewOfferTile(
                              //   color: Color(0xFF4392F9),
                              //   mainLabel: "Deal of the Day",
                              //   icon: Icons.timer_outlined,
                              //   subLabel: "22h 55m 20s remaining",
                              // ),

                              kHeight,
                              CustomTextWidget(
                                text: "All Featured Products",
                                fontSize: 18.sp,
                                fontweight: FontWeight.w600,
                              ),
                              Obx(() {
                                return controller.isAllProductsLoading.value
                                    ? Column(
                                        children: [
                                          GridView.count(
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            childAspectRatio: (20 / 30),
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 0,
                                            crossAxisSpacing: 5,
                                            children: List.generate(
                                              6,
                                              (index) {
                                                return ProductsListItemTileSkeleton();
                                              },
                                            ),
                                          ),
                                          kHeight,
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          GridView.count(
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            childAspectRatio: (20 / 30),
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 0,
                                            crossAxisSpacing: 5,
                                            children: List.generate(
                                              controller.allProducts.length,
                                              (index) {
                                                final productDetails = controller.allProducts[index];
                                                return GestureDetector(
                                                  onTap: () async {
                                                    final String productId = controller.allProducts[index].product.productId.toString();

                                                    // controller.getSimilarProducts(controller.allProducts.value, index);

                                                    Services().getProductDetailsAndGotoShopScreen(context, productId);
                                                  },
                                                  child: ProductsListItemTile(
                                                    productDetails: productDetails,
                                                  ),
                                                );
                                              },
                                            ),
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
                              }),

                              kHeight,
                              Container(
                                height: 84.w,
                                width: screenSize.width * 0.9,
                                child: Row(
                                  children: [
                                    Image.asset("lib/core/assets/images/home/special_offer.png"),
                                    SizedBox(width: 20),
                                    Container(
                                      width: 180.w,
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

                              // best sellers
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextWidget(
                                    text: "Best Sellers",
                                    fontSize: 18.sp,
                                    fontweight: FontWeight.w600,
                                  ),
                                  Container(
                                    height: 230.w,
                                    child: Obx(
                                      () => controller.isBestSellersLoading.value
                                          ? SizedBox(
                                              width: screenSize.width * 0.4,
                                              height: 300.w,
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
                                                        final productDetails = controller.bestSellers[index];

                                                        return GestureDetector(
                                                          onTap: () async {
                                                            final String productId = controller.bestSellers[index].product.productId.toString();
                                                            Services().getProductDetailsAndGotoShopScreen(context, productId);
                                                          },
                                                          child: ProductsListItemTile(
                                                            productDetails: productDetails,
                                                            imagePath: productDetails.product.productImages.isNotEmpty
                                                                ? "$baseUrl${productDetails.product.productImages[0].productImage}"
                                                                : "https://t3.ftcdn.net/jpg/05/04/28/96/240_F_504289605_zehJiK0tCuZLP2MdfFBpcJdOVxKLnXg1.jpg",
                                                          ),
                                                        );
                                                      },
                                                      itemCount: controller.bestSellers.length,
                                                      scrollDirection: Axis.horizontal,
                                                    ),
                                    ),
                                  ),
                                ],
                              ),
                              kHeight,

                              // trending

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextWidget(
                                    text: "Trending",
                                    fontSize: 18.sp,
                                    fontweight: FontWeight.w600,
                                  ),
                                  Container(
                                    height: 230.w,
                                    child: Obx(
                                      () => controller.isTrendingLoading.value
                                          ? SizedBox(
                                              width: screenSize.width * 0.4,
                                              height: 300.w,
                                              child: Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                            )
                                          : controller.isTrendingLoadingError.value
                                              ? Center(
                                                  child: CustomTextWidget(
                                                    text: "Loading trending products failed. Please check your internet connection",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                )
                                              : controller.trending.isEmpty
                                                  ? Center(
                                                      child: CustomTextWidget(text: "No trending products found"),
                                                    )
                                                  : ListView.builder(
                                                      itemBuilder: (context, index) {
                                                        final productDetails = controller.trending[index];

                                                        return GestureDetector(
                                                          onTap: () async {
                                                            final String productId = controller.trending[index].product.productId.toString();
                                                            Services().getProductDetailsAndGotoShopScreen(context, productId);
                                                          },
                                                          child: ProductsListItemTile(
                                                            productDetails: productDetails,
                                                            imagePath: productDetails.product.productImages.isNotEmpty
                                                                ? "$baseUrl${productDetails.product.productImages[0].productImage}"
                                                                : "https://t3.ftcdn.net/jpg/05/04/28/96/240_F_504289605_zehJiK0tCuZLP2MdfFBpcJdOVxKLnXg1.jpg",
                                                          ),
                                                        );
                                                      },
                                                      itemCount: controller.trending.length,
                                                      scrollDirection: Axis.horizontal,
                                                    ),
                                    ),
                                  ),
                                ],
                              ),
                              kHeight,

                              // sponsered
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextWidget(
                                    text: "Sponsered",
                                    fontSize: 18.sp,
                                    fontweight: FontWeight.w600,
                                  ),
                                  Container(
                                    height: 230.w,
                                    child: Obx(
                                      () => controller.isSponserdLoading.value
                                          ? SizedBox(
                                              width: screenSize.width * 0.4,
                                              height: 300.w,
                                              child: Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                            )
                                          : controller.isSponserdLoadingError.value
                                              ? Center(
                                                  child: CustomTextWidget(
                                                    text: "Loading sponsered products failed. Please check your internet connection",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                )
                                              : controller.sponserd.isEmpty
                                                  ? Center(
                                                      child: CustomTextWidget(text: "No sponsered products found"),
                                                    )
                                                  : ListView.builder(
                                                      itemBuilder: (context, index) {
                                                        final productDetails = controller.sponserd[index];

                                                        return GestureDetector(
                                                          onTap: () async {
                                                            final String productId = controller.sponserd[index].product.productId.toString();
                                                            Services().getProductDetailsAndGotoShopScreen(context, productId);
                                                          },
                                                          child: ProductsListItemTile(
                                                            productDetails: productDetails,
                                                            imagePath: productDetails.product.productImages.isNotEmpty
                                                                ? "$baseUrl${productDetails.product.productImages[0].productImage}"
                                                                : "https://t3.ftcdn.net/jpg/05/04/28/96/240_F_504289605_zehJiK0tCuZLP2MdfFBpcJdOVxKLnXg1.jpg",
                                                          ),
                                                        );
                                                      },
                                                      itemCount: controller.sponserd.length,
                                                      scrollDirection: Axis.horizontal,
                                                    ),
                                    ),
                                  ),
                                ],
                              ),
                              kHeight,

                              //special offers

                              //buy now

                              // Obx(() {
                              //   return controller.isPlainCashewLoading.value
                              //       ? const Center(
                              //           child: CircularProgressIndicator(),
                              //         )
                              //       : BuyNowTile(
                              //           productDetails: controller.allProducts.value,
                              //         );
                              // }),

                              // Trending
                              // Obx(() {
                              //   return controller.isTrendingLoading.value
                              //       ? const Center(
                              //           child: CircularProgressIndicator(),
                              //         )
                              //       : controller.isTrendingLoadingError.value
                              //           ? const Center(
                              //               child: CustomTextWidget(text: "Loading trending products failed. Please check your internet connection"),
                              //             )
                              //           : ViewOfferTile(
                              //               onPressed: () {
                              //                 if (!controller.isAlreadyLoadedTrending) {
                              //                   controller.getTrendingProducts();
                              //                 }

                              //                 controller.productDisplayList2 = controller.trending;
                              //                 // print("Trending : ${controller.productDisplayList2.value.count}");
                              //                 // previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                              //                 // bottomNavbarIndexNotifier.value = 9;
                              //                 Get.to(() => TrendingModelProductListingScreen(
                              //                       title: "Trending Products",
                              //                     ));
                              //               },
                              //               color: kMainThemeColor,
                              //               mainLabel: "Trending Products",
                              //               icon: Icons.calendar_month,
                              //               subLabel: "Last Date 29/02/22",
                              //             );
                              // }),

                              SizedBox(height: 10.w),

                              // value added products

                              // ValueAddedProductsTile(),
                              SizedBox(height: 15.w),

                              //Sponsered product
                              // Obx(
                              //   () {
                              //     if (controller.sponserd.value.isEmpty) {
                              //       return SizedBox(
                              //         width: screenSize.width * 0.95,
                              //         height: screenSize.width * 0.8,
                              //         child: const Center(child: CustomTextWidget(text: "No sponserd products right now")),
                              //       );
                              //     } else {
                              //       // log(controller.sponserd.value.toString());
                              //       final String imagePath = controller.sponserd.value[0].product.productImages.isNotEmpty
                              //           ? "$baseUrl${controller.sponserd.value[0].product!.productImages[0].productImage}"
                              //           : "https://t3.ftcdn.net/jpg/05/04/28/96/240_F_504289605_zehJiK0tCuZLP2MdfFBpcJdOVxKLnXg1.jpg";
                              //       return controller.isSponserdLoading.value
                              //           ? const Center(
                              //               child: CircularProgressIndicator(),
                              //             )
                              //           : GestureDetector(
                              //               onTap: () {
                              //                 final String productId = controller.sponserd.value[0].product.productId.toString();
                              //                 Services().getProductDetailsAndGotoShopScreen(context,productId);
                              //               },
                              //               child: SponseredProductTile(
                              //                 imagePath: imagePath,
                              //               ),
                              //             );
                              //     }
                              //   },
                              // ),
                            ],
                          );
                        } else {
                          int count = 0;
                          // print("displaying search results");
                          // //log("total result count :${controller.searchResults.value.length}");
                          return searchController.searchResults.length == 0
                              ? Center(
                                  child: CustomTextWidget(
                                    text: "Product not found",
                                    fontSize: 16.sp,
                                  ),
                                )
                              : GridView.count(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  childAspectRatio: (20 / 30),
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                  children: List.generate(searchController.searchResults.length, (index) {
                                    count++;
                                    // print("total count :${searchController.searchResults.value.length}");
                                    // print("generating results");
                                    // print(count);
                                    final productDetails = searchController.searchResults[index];

                                    return GestureDetector(
                                      onTap: () async {
                                        final String productId = searchController.searchResults[index].product.productId.toString();
                                        // controller.getSimilarProducts(controller.searchResults.value, index);
                                        // Get.to(() => ShopScreen());
                                        // await controller.getProductDetails(productId);
                                        // controller.productDetailsList.add(controller.productDetails.value!);
                                        // previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                                        // bottomNavbarIndexNotifier.value = 4;
                                        Services().getProductDetailsAndGotoShopScreen(context, productId);
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
                      SizedBox(
                        height: 20.w,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startAutoSlide() {
    timer = Timer.periodic(
      Duration(seconds: 4),
      (timer) {
        if (pageController.hasClients) {
          if (controller.currentSlideNumber.value < controller.slidingProductsList.length - 1) {
            controller.currentSlideNumber.value++;
          } else {
            controller.currentSlideNumber.value = 0;
          }

          pageController.animateToPage(
            controller.currentSlideNumber.value,
            duration: Duration(seconds: 1),
            curve: Curves.easeIn,
          );
        }
      },
    );
  }
}
