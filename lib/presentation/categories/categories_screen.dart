import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cashew_cart/controllers/app_controller.dart';
import 'package:cashew_cart/controllers/search_controller.dart';
import 'package:cashew_cart/core/colors.dart';
import 'package:cashew_cart/core/constants.dart';
import 'package:cashew_cart/presentation/shop/shop_screen.dart';
import 'package:cashew_cart/presentation/side_bar/side_bar.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';
import 'package:cashew_cart/presentation/widgets/main_appbar.dart';
import 'package:cashew_cart/presentation/widgets/products_list_item_skeleton.dart';
import 'package:cashew_cart/presentation/widgets/products_list_item_tile.dart';
import 'package:cashew_cart/presentation/widgets/search_section_tile.dart';
import 'package:cashew_cart/services/services.dart';
import 'package:loader_overlay/loader_overlay.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});

  AppController controller = Get.put(AppController());
  SearchResultController searchController = Get.put(SearchResultController());

  @override
  Widget build(BuildContext context) {
    // controller.getAllProducts();
    return Scaffold(
      backgroundColor: appBackgroundColor,
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
                child: Column(
                  children: [
                    //Plain cashews

                    Obx(() {
                      // print("count : ${controller.searchResults.value.count}");
                      if (!searchController.isSearchMode.value) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: CustomTextWidget(
                                text: "PLAIN",
                                fontSize: 18,
                                fontweight: FontWeight.w600,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Obx(
                                () {
                                  return DropdownButton<String>(
                                    value: controller.selectedPlainCashewCategory.value,
                                    onChanged: (String? newValue) {
                                      // print(newValue);
                                      if (newValue == "All") {
                                        controller.getProductsByCategory("PLAIN CASHEWS", '');
                                        controller.selectedPlainCashewCategory.value = newValue!;
                                      } else {
                                        controller.getProductsByCategory("PLAIN CASHEWS", newValue!);
                                        controller.selectedPlainCashewCategory.value = newValue;
                                      }
                                    },
                                    items: controller.plainCashewSubCategories.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: CustomTextWidget(
                                          text: value,
                                          fontweight: FontWeight.w600,
                                          fontColor: kMainThemeColor,
                                        ),
                                      );
                                    }).toList(),
                                  );
                                },
                              ),
                            ),
                            Container(
                              height: 230.w,
                              child: Obx(
                                () {
                                  if (controller.isPlainCashewLoading.value) {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return ProductsListItemTileSkeleton();
                                      },
                                      itemCount: 6,
                                      scrollDirection: Axis.horizontal,
                                    );
                                  } else if (controller.isAlreadyLoadedPlainCashews.value && controller.plainCashews.isEmpty) {
                                    return Center(
                                      child: CustomTextWidget(
                                        text: "Plain cashews products not available right now.",
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  } else if (controller.isPlainCashewLoadingError.value) {
                                    log("pl lo err");
                                    return Center(
                                      child: CustomTextWidget(
                                        text: "Loading failed. Please check your internet connection",
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  } else {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        // if (index < controller.plainCashews.length) {
                                        final productDetails = controller.plainCashews[index];
                                        return GestureDetector(
                                          onTap: () async {
                                            final String productId = controller.plainCashews[index].product.productId.toString();
                                            // controller.getSimilarProducts(controller.plainCashews.value, index);
                                            Services().getProductDetailsAndGotoShopScreen(context, productId);
                                          },
                                          child: ProductsListItemTile(
                                            productDetails: productDetails,
                                          ),
                                        );
                                      },
                                      itemCount: controller.plainCashews.length,
                                      scrollDirection: Axis.horizontal,
                                    );
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: CustomTextWidget(
                                text: "ROASTED & SALTED",
                                fontSize: 18,
                                fontweight: FontWeight.w600,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Obx(
                                () {
                                  return DropdownButton<String>(
                                    value: controller.selectedRoastedAndSaltedCategory.value,
                                    onChanged: (String? newValue) {
                                      // print(newValue);
                                      if (newValue == "All") {
                                        controller.getProductsByCategory("ROASTED AND SALTED CASHEWS", '');
                                        controller.selectedRoastedAndSaltedCategory.value = newValue!;
                                      } else {
                                        controller.getProductsByCategory("ROASTED AND SALTED CASHEWS", newValue!);
                                        controller.selectedRoastedAndSaltedCategory.value = newValue;
                                      }
                                    },
                                    items: controller.roastedAndSaltedSubCategories.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: CustomTextWidget(
                                          text: value,
                                          fontweight: FontWeight.w600,
                                          fontColor: kMainThemeColor,
                                        ),
                                      );
                                    }).toList(),
                                  );
                                },
                              ),
                            ),
                            Container(
                              height: 230.w,
                              child: Obx(
                                () {
                                  if (controller.isRoastedAndSaltedLoading.value) {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return ProductsListItemTileSkeleton();
                                      },
                                      itemCount: 6,
                                      scrollDirection: Axis.horizontal,
                                    );
                                  } else if (controller.isAlreadyLoadedRoastedAndSaltedCashews.value && controller.roastedAndSalted.isEmpty) {
                                    return Center(
                                      child: CustomTextWidget(
                                        text: "Roasted cashews products not available right now.",
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  } else if (controller.isRoastedAndSaltedLoadingError.value) {
                                    return Center(
                                      child: CustomTextWidget(
                                        text: "Loading failed. Please check your internet connection",
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  } else {
                                    return Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            itemBuilder: (context, index) {
                                              // if (index < controller.roastedAndSalted.length) {
                                              final productDetails = controller.roastedAndSalted[index];
                                              return GestureDetector(
                                                onTap: () async {
                                                  final String productId = controller.roastedAndSalted[index].product.productId.toString();
                                                  // controller.getSimilarProducts(controller.roastedAndSalted, index);
                                                  Services().getProductDetailsAndGotoShopScreen(context, productId);
                                                },
                                                child: ProductsListItemTile(
                                                  productDetails: productDetails,
                                                ),
                                              );
                                              // }
                                            },
                                            itemCount: controller.roastedAndSalted.length,
                                            scrollDirection: Axis.horizontal,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: CustomTextWidget(
                                text: "VALUE ADDED PRODUCTS",
                                fontSize: 18,
                                fontweight: FontWeight.w600,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Obx(
                                () {
                                  return DropdownButton<String>(
                                    value: controller.selectedValueAddedCategory.value,
                                    onChanged: (String? newValue) {
                                      // print(newValue);
                                      if (newValue == "All") {
                                        controller.getProductsByCategory("VALUE ADDED CASHEW PRODUCTS", '');
                                        controller.selectedValueAddedCategory.value = newValue!;
                                      } else {
                                        controller.getProductsByCategory("VALUE ADDED CASHEW PRODUCTS", newValue!);
                                        controller.selectedValueAddedCategory.value = newValue;
                                      }
                                    },
                                    items: controller.valueAddedSubCategories.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: CustomTextWidget(
                                          text: value,
                                          fontweight: FontWeight.w600,
                                          fontColor: kMainThemeColor,
                                        ),
                                      );
                                    }).toList(),
                                  );
                                },
                              ),
                            ),
                            Container(
                              height: 230.w,
                              child: Obx(
                                () {
                                  if (controller.isValueAddedLoading.value) {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return ProductsListItemTileSkeleton();
                                      },
                                      itemCount: 6,
                                      scrollDirection: Axis.horizontal,
                                    );
                                  } else if (controller.isAlreadyLoadedValueAdded.value && controller.valueAdded.isEmpty) {
                                    return Center(
                                      child: CustomTextWidget(
                                        text: "Value added products not available right now.",
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  } else if (controller.isValueAddedLoadingError.value) {
                                    return Center(
                                      child: CustomTextWidget(
                                        text: "Loading failed. Please check your internet connection",
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  } else {
                                    return Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            itemBuilder: (context, index) {
                                              // if (index < controller.valueAdded.value.length) {
                                              final productDetails = controller.valueAdded[index];
                                              return GestureDetector(
                                                onTap: () async {
                                                  final String productId = controller.valueAdded[index].product.productId.toString();
                                                  // controller.getSimilarProducts(controller.valueAdded.value, index);
                                                  Services().getProductDetailsAndGotoShopScreen(context, productId);
                                                },
                                                child: ProductsListItemTile(
                                                  productDetails: productDetails,
                                                ),
                                              );
                                              // }
                                            },
                                            itemCount: controller.valueAdded.length,
                                            scrollDirection: Axis.horizontal,
                                          ),
                                        ),
                                      ],
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
                              height: 230.w,
                              child: Obx(
                                () {
                                  if (controller.isAllProductsLoading.value) {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return ProductsListItemTileSkeleton();
                                      },
                                      itemCount: 6,
                                      scrollDirection: Axis.horizontal,
                                    );
                                  } else if (controller.isAlreadyLoadedAllProducts.value && controller.allProducts.isEmpty) {
                                    return Center(
                                      child: CustomTextWidget(
                                        text: "Featured products not available right now.",
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  } else if (controller.isAllProductsLoadingError.value) {
                                    return Center(
                                      child: CustomTextWidget(
                                        text: "Loading failed. Please check your internet connection",
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  } else {
                                    return Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            itemBuilder: (context, index) {
                                              // if (index < controller.allProducts.length) {
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
                                            itemCount: controller.allProducts.length,
                                            scrollDirection: Axis.horizontal,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        );
                      } else {
                        print("displaying search results");
                        return searchController.searchResults.value.length == 0
                            ? Center(
                                child: CustomTextWidget(
                                  text: "Product not found",
                                  fontSize: 16,
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
                                    children: List.generate(
                                      searchController.searchResults.length,
                                      (index) {
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
                                      },
                                    ),
                                  ),
                                  kHeight,
                                ],
                              );
                      }
                    }),
                    SizedBox(height: 50.w),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
