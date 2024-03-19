import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/main.dart';
import 'package:internship_sample/presentation/home/home_screen.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/shop/shop_screen.dart';
import 'package:internship_sample/presentation/side_bar/side_bar.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/presentation/widgets/main_appbar.dart';
import 'package:internship_sample/presentation/widgets/products_list_item_tile.dart';
import 'package:internship_sample/presentation/widgets/search_section_tile.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});

  AppController controller = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    if (!controller.isAlreadyLoadedPlainCashews) {
      controller.getProductsByCategory("Plain Cashews", "");
    }
    if (!controller.isAlreadyLoadedRoastedAndSaltedCashews) {
      controller.getProductsByCategory("Roasted and Salted Cashews", "");
    }
    if (!controller.isAlreadyLoadedValueAdded) {
      controller.getProductsByCategory("Value Added", "");
    }
    if (!controller.isAlreadyLoadedAllProducts) {
      controller.getAllProducts();
    }

    controller.getAllProducts();
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: MainAppBar(),
      drawer: SideBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchSectionTile(),
            ),

            //Plain cashews

            Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                print("count : ${controller.searchResults.value.count}");
                if (!controller.haveSearchResult.value) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CustomTextWidget(
                          text: "PLAIN CASHEWS",
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
                                  controller.getProductsByCategory("Plain Cashews", '');
                                  controller.selectedPlainCashewCategory.value = newValue!;
                                } else {
                                  controller.getProductsByCategory("Plain Cashews", newValue!);
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
                        height: 250,
                        child: Obx(
                          () {
                            if (controller.isPlainCashewLoading.value) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (controller.plainCashews.value.count != 0) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      itemBuilder: (context, index) {
                                        if (index < controller.plainCashews.value.results!.length) {
                                          final productDetails = controller.plainCashews.value.results![index];
                                          return GestureDetector(
                                            onTap: () async {
                                              final String productId = controller.plainCashews.value.results![index].product.id.toString();
                                              controller.getSimilarProducts(controller.plainCashews.value, index);
                                              controller.productDetails.value = controller.productDetails.value;
                                              previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                                              bottomNavbarIndexNotifier.value = 4;
                                              controller.getProductDetails(productId);
                                              controller.getProductReviews(productId);
                                            },
                                            child: ProductsListItemTile(
                                              productDetails: productDetails,
                                            ),
                                          );
                                        } else if (controller.plainCashews.value.next != null) {
                                          return GestureDetector(
                                            onTap: () {
                                              controller.plainCashewsPageNo++;
                                              String subCategory;
                                              if (controller.selectedPlainCashewCategory.value == "All") {
                                                subCategory = "";
                                              } else {
                                                subCategory = controller.selectedPlainCashewCategory.value;
                                              }
                                              controller.getProductsByCategory("Plain Cashews", subCategory);
                                            },
                                            child: Row(
                                              children: [
                                                CustomTextWidget(text: "Load More ->"),
                                                kWidth,
                                              ],
                                            ),
                                          );
                                        }
                                      },
                                      itemCount: controller.plainCashews.value.results!.length + 1,
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Center(
                                child: CustomTextWidget(text: "Plain cashews products not available right now."),
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CustomTextWidget(
                          text: "ROASTED & SALTED CASHEWS",
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
                                  controller.getProductsByCategory("Roasted and salted", '');
                                  controller.selectedRoastedAndSaltedCategory.value = newValue!;
                                } else {
                                  controller.getProductsByCategory("Roasted and salted", newValue!);
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
                        height: 250,
                        child: Obx(
                          () {
                            if (controller.isRoastedAndSaltedLoading.value) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (controller.roastedAndSalted.value.count != 0) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      itemBuilder: (context, index) {
                                        if (index < controller.roastedAndSalted.value.results!.length) {
                                          final productDetails = controller.roastedAndSalted.value.results![index];
                                          return GestureDetector(
                                            onTap: () async {
                                              final String productId = controller.roastedAndSalted.value.results![index].product.id.toString();
                                              controller.getSimilarProducts(controller.roastedAndSalted.value, index);
                                              controller.productDetails.value = controller.productDetails.value;
                                              previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                                              bottomNavbarIndexNotifier.value = 4;
                                              controller.getProductDetails(productId);
                                              controller.getProductReviews(productId);
                                            },
                                            child: ProductsListItemTile(
                                              productDetails: productDetails,
                                            ),
                                          );
                                        } else if (controller.roastedAndSalted.value.next != null) {
                                          return GestureDetector(
                                            onTap: () {
                                              controller.roastedAndSaltedPageNo++;
                                              controller.getProductsByCategory("Roasted and Salted Cashews", controller.selectedPlainCashewCategory.value);
                                            },
                                            child: Row(
                                              children: [
                                                CustomTextWidget(text: "Load More ->"),
                                                kWidth,
                                              ],
                                            ),
                                          );
                                        }
                                      },
                                      itemCount: controller.roastedAndSalted.value.results!.length + 1,
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Center(
                                child: CustomTextWidget(text: "Roasted and Salted Cashews products not available right now."),
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
                                  controller.getProductsByCategory("Value Added", '');
                                  controller.selectedValueAddedCategory.value = newValue!;
                                } else {
                                  controller.getProductsByCategory("Value Added", newValue!);
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
                        height: 250,
                        child: Obx(
                          () {
                            if (controller.isValueAddedLoading.value) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (controller.valueAdded.value.count != 0) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      itemBuilder: (context, index) {
                                        if (index < controller.valueAdded.value.results!.length) {
                                          final productDetails = controller.valueAdded.value.results![index];
                                          return GestureDetector(
                                            onTap: () async {
                                              final String productId = controller.valueAdded.value.results![index].product.id.toString();
                                              controller.getSimilarProducts(controller.valueAdded.value, index);
                                              controller.productDetails.value = controller.productDetails.value;
                                              previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                                              bottomNavbarIndexNotifier.value = 4;
                                              controller.getProductDetails(productId);
                                              controller.getProductReviews(productId);
                                            },
                                            child: ProductsListItemTile(
                                              productDetails: productDetails,
                                            ),
                                          );
                                        } else if (controller.valueAdded.value.next != null) {
                                          return GestureDetector(
                                            onTap: () {
                                              controller.valueAddedPageNo++;
                                              controller.getProductsByCategory("Value Added", controller.selectedPlainCashewCategory.value);
                                            },
                                            child: Row(
                                              children: [
                                                CustomTextWidget(text: "Load More ->"),
                                                kWidth,
                                              ],
                                            ),
                                          );
                                        }
                                      },
                                      itemCount: controller.valueAdded.value.results!.length + 1,
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Center(
                                child: CustomTextWidget(text: "Value Added products not available right now."),
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
                        child: Obx(
                          () {
                            if (controller.isAllProductsLoading.value) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (controller.allProducts.value.count != 0) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      itemBuilder: (context, index) {
                                        if (index < controller.allProducts.value.results!.length) {
                                          final productDetails = controller.allProducts.value.results![index];
                                          return GestureDetector(
                                            onTap: () async {
                                              final String productId = controller.allProducts.value.results![index].product.id.toString();
                                              controller.getSimilarProducts(controller.allProducts.value, index);
                                              controller.productDetails.value = controller.productDetails.value;
                                              previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                                              bottomNavbarIndexNotifier.value = 4;
                                              controller.getProductDetails(productId);
                                              controller.getProductReviews(productId);
                                            },
                                            child: ProductsListItemTile(
                                              productDetails: productDetails,
                                            ),
                                          );
                                        } else if (controller.allProducts.value.next != null) {
                                          return GestureDetector(
                                            onTap: () {
                                              controller.allProductsPageNo++;
                                              controller.getAllProducts();
                                            },
                                            child: Row(
                                              children: [
                                                CustomTextWidget(text: "Load More ->"),
                                                kWidth,
                                              ],
                                            ),
                                          );
                                        }
                                      },
                                      itemCount: controller.allProducts.value.results!.length + 1,
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
                  return controller.searchResults.value.count == 0
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
                                controller.searchResults.value.results!.length,
                                (index) {
                                  final productDetails = controller.searchResults.value.results![index];

                                  return GestureDetector(
                                    onTap: () async {
                                      // print(
                                      //     "image list ${controller.productDisplayList.valueindex]}");
                                      final String productId = controller.searchResults.value.results![index].product.id.toString();
                                      controller.getSimilarProducts(controller.searchResults.value, index);
                                      await controller.getProductDetails(productId);
                                      // controller.productDetails.value = controller.productDetails.value;
                                      previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                                      bottomNavbarIndexNotifier.value = 4;
                                    },
                                    child: ProductsListItemTile(
                                      productDetails: productDetails,
                                    ),
                                  );
                                },
                              ),
                            ),
                            kHeight,
                            if (controller.searchResults.value.next != null)
                              GestureDetector(
                                onTap: () {
                                  controller.searchResultPageNo++;
                                  controller.searchProducts(SearchSectionTile().searchController.text);
                                },
                                child: CustomTextWidget(text: "Load More"),
                              ),
                            kHeight,
                          ],
                        );
                }
              }
            }),
          ],
        ),
      ),
    );
  }
}
