import 'dart:async';
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:cashew_cart/controllers/app_controller.dart';
import 'package:cashew_cart/controllers/cart_controller.dart';
import 'package:cashew_cart/controllers/search_controller.dart';
import 'package:cashew_cart/core/base_url.dart';
import 'package:cashew_cart/core/colors.dart';
import 'package:cashew_cart/core/constants.dart';
import 'package:cashew_cart/presentation/home/widgets/circle_avatar_list_item.dart';
import 'package:cashew_cart/presentation/home/widgets/sliding_image_tile.dart';
import 'package:cashew_cart/presentation/side_bar/side_bar.dart';
import 'package:cashew_cart/presentation/widgets/products_list_item_skeleton.dart';
import 'package:cashew_cart/presentation/widgets/products_list_item_tile.dart';
import 'package:cashew_cart/presentation/widgets/search_section_tile.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';
import 'package:cashew_cart/presentation/widgets/main_appbar.dart';
import 'package:cashew_cart/services/services.dart';
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
  CartController cartController = Get.put(CartController());
  // SearchController searchController = Get.put(SearchController());
  SearchResultController searchController = Get.put(SearchResultController());
  Timer? timer;
  bool isIcrementing = true;

  @override
  Widget build(BuildContext context) {
    log("rebuilding home");
    // cartController.getCartList();
    controller.currentSlideNumber.value = 0;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: kMainThemeColor,
      ),
    );
    // startAutoSlide();

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

                              //sliding new products windows

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
                                  width: screenSize.width * 0.95,
                                  child: controller.isAllProductsLoadingError.value
                                      ? Center(
                                          child: CustomTextWidget(
                                            text: "Loading failed. Please check your internet connection",
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      : CarouselSlider(
                                          options: CarouselOptions(
                                            height: 350.w,
                                            autoPlay: true,
                                            autoPlayInterval: Duration(seconds: 5),
                                            // padEnds: true,
                                            viewportFraction: 0.8,
                                            enlargeCenterPage: true,
                                            enlargeFactor: 0.4,
                                            onPageChanged: (index, reason) {
                                              controller.currentSlideNumber.value = index;
                                            },
                                          ),
                                          items: controller.slidingProductsList.map((product) {
                                            return Builder(
                                              builder: (BuildContext context) {
                                                return SizedBox(
                                                  width: screenSize.width * 0.95,
                                                  child: SlidingImageTile(
                                                    productDetails: product,
                                                  ),
                                                );
                                              },
                                            );
                                          }).toList(),
                                        ),
                                ),

                              SizedBox(height: 10.w),
                              Obx(() {
                                return Center(
                                  child: DotsIndicator(
                                    dotsCount: controller.slidingProductsList.length == 0 ? 8 : controller.slidingProductsList.length,
                                    position: controller.currentSlideNumber.value,
                                    decorator: DotsDecorator(
                                      activeColor: Colors.red,
                                      color: Colors.grey,
                                      size: const Size.square(9.0),
                                      activeSize: const Size(18.0, 9.0),
                                      activeShape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                    ),
                                  ),
                                );
                              }),

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

                                                    print("stopped");
                                                    Services().getProductDetailsAndGotoShopScreen(context, productId);
                                                  },
                                                  child: ProductsListItemTile(
                                                    productDetails: productDetails,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                              }),

                              // kHeight,
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
                                          ? Center(
                                              child: ListView.builder(
                                                itemBuilder: (context, index) {
                                                  return ProductsListItemTileSkeleton();
                                                },
                                                itemCount: 5,
                                                scrollDirection: Axis.horizontal,
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
                                          ? Center(
                                              child: ListView.builder(
                                                itemBuilder: (context, index) {
                                                  return ProductsListItemTileSkeleton();
                                                },
                                                itemCount: 5,
                                                scrollDirection: Axis.horizontal,
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
                                          ? Center(
                                              child: ListView.builder(
                                                itemBuilder: (context, index) {
                                                  return ProductsListItemTileSkeleton();
                                                },
                                                itemCount: 5,
                                                scrollDirection: Axis.horizontal,
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

                              SizedBox(height: 10.w),
                            ],
                          );
                        } else {
                          int count = 0;
                          // //log("total result count :${controller.searchResults.value.length}");
                          return searchController.isLoading.value
                              ? Center(child: CircularProgressIndicator())
                              : searchController.searchResults.length == 0
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
                                        final productDetails = searchController.searchResults[index];

                                        return GestureDetector(
                                          onTap: () async {
                                            final String productId = searchController.searchResults[index].product.productId.toString();

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
}
