import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/presentation/side_bar/side_bar.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/presentation/widgets/main_appbar.dart';
import 'package:internship_sample/presentation/widgets/products_list_item_tile.dart';
import 'package:internship_sample/presentation/widgets/search_section_tile.dart';
import 'package:internship_sample/services/services.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});

  AppController controller = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    // controller.getAllProducts();
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: MainAppBar(),
      drawer: SideBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SearchSectionTile(),
          ),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //Plain cashews

                  Obx(() {
                    if (controller.isLoading.value) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      // print("count : ${controller.searchResults.value.count}");
                      if (!controller.haveSearchResult.value) {
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
                                      print(newValue);
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
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (controller.plainCashews.length != 0) {
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
                                        // }
                                        // else if (controller.plainCashews.value.next != null) {
                                        //   return GestureDetector(
                                        //     onTap: () {
                                        //       controller.plainCashewsPageNo++;
                                        //       String subCategory;
                                        //       if (controller.selectedPlainCashewCategory.value == "All") {
                                        //         subCategory = "";
                                        //       } else {
                                        //         subCategory = controller.selectedPlainCashewCategory.value;
                                        //       }
                                        //       controller.getProductsByCategory("Plain Cashews", subCategory);
                                        //     },
                                        //     child: Row(
                                        //       children: [
                                        //         CustomTextWidget(text: "Load More ->"),
                                        //         kWidth,
                                        //       ],
                                        //     ),
                                        //   );
                                        // }
                                      },
                                      itemCount: controller.plainCashews.length,
                                      scrollDirection: Axis.horizontal,
                                    );
                                  } else {
                                    return Center(
                                      child: CustomTextWidget(
                                        text: "Plain cashews products not available right now.",
                                        textAlign: TextAlign.center,
                                      ),
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
                                      print(newValue);
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
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (controller.roastedAndSalted.length != 0) {
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
                                  } else {
                                    return Center(
                                      child: CustomTextWidget(
                                        text: "Roasted and Salted Cashews products not available right now.",
                                        textAlign: TextAlign.center,
                                      ),
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
                                      print(newValue);
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
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (controller.valueAdded.length != 0) {
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
                                  } else {
                                    return Center(
                                      child: CustomTextWidget(
                                        text: "Value Added products not available right now.",
                                        textAlign: TextAlign.center,
                                      ),
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
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (controller.allProducts.length != 0) {
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
                                              // }
                                              //  else if (controller.allProducts.value.length != null) {
                                              //   return GestureDetector(
                                              //     onTap: () {
                                              //       controller.allProductsPageNo++;
                                              //       controller.getAllProducts();
                                              //     },
                                              //     child: Row(
                                              //       children: [
                                              //         CustomTextWidget(text: "Load More ->"),
                                              //         kWidth,
                                              //       ],
                                              //     ),
                                              //   );
                                              // }
                                            },
                                            itemCount: controller.allProducts.length,
                                            scrollDirection: Axis.horizontal,
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Center(
                                      child: CustomTextWidget(text: "Products not available right now."),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        );
                      } else {
                        print("displaying search results");
                        return controller.searchResults.value.length == 0
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
                                      controller.searchResults.length,
                                      (index) {
                                        final productDetails = controller.searchResults[index];

                                        return GestureDetector(
                                          onTap: () async {
                                            print("Search results");
                                            // print(
                                            //     "image list ${controller.productDisplayList.valueindex]}");
                                            final String productId = controller.searchResults[index].product.productId.toString();
                                            // controller.getSimilarProducts(controller.searchResults.value, index);
                                            Services().getProductDetailsAndGotoShopScreen(context, productId);
                                            // await controller.getProductDetails(productId);
                                            // Get.to(() => ShopScreen());
                                            // controller.productDetailsList.add(controller.productDetails.value!);
                                            // previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                                            // bottomNavbarIndexNotifier.value = 4;
                                          },
                                          child: ProductsListItemTile(
                                            productDetails: productDetails,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  kHeight,

                                  // if (controller.searchResults.value.length != null)
                                  //   GestureDetector(
                                  //     onTap: () {
                                  //       controller.searchResultPageNo++;
                                  //       controller.searchProducts(SearchSectionTile().searchController.text);
                                  //     },
                                  //     child: CustomTextWidget(text: "Load More"),
                                  //   ),
                                  // kHeight,
                                ],
                              );
                      }
                    }
                  }),
                  SizedBox(
                    height: 50.w
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
