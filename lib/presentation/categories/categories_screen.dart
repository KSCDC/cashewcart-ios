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
      controller.getProductsByCategory("Roasted and salted", "");
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchSectionTile(heading: "All Featured Products"),
            ),
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
                  if (controller.plainCashews.value.count != 0) {
                    return controller.isPlainCashewLoading.value
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              final productDetails = controller.plainCashews.value.results[index];

                              return GestureDetector(
                                onTap: () async {
                                  final String productId = controller.plainCashews.value.results[index].product.id.toString();
                                  // final currentCategoryProducts = controller.plainCashews.value;
                                  controller.getSimilarProducts(controller.plainCashews.value, index);
                                  controller.productDetails.value = controller.productDetails.value;
                                  print(controller.productDetails.value!.name);

                                  previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                                  bottomNavbarIndexNotifier.value = 4;
                                  controller.getProductDetails(productId);
                                },
                                child: ProductsListItemTile(
                                  productDetails: productDetails,
                                ),
                              );
                            },
                            itemCount: controller.plainCashews.value.count,
                            scrollDirection: Axis.horizontal,
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
                  print(controller.roastedAndSalted.value.results);
                  if (controller.roastedAndSalted.value.count != 0) {
                    return controller.isRoastedAndSaltedLoading.value
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              final productDetails = controller.roastedAndSalted.value.results[index];

                              return GestureDetector(
                                onTap: () async {
                                  final String productId = controller.roastedAndSalted.value.results[index].product.id.toString();
                                  controller.getProductDetails(productId);

                                  print("Product id ::::::: $productId");
                                  // currentCategoryProducts = controller.roastedAndSalted.value;
                                  controller.getSimilarProducts(controller.roastedAndSalted.value, index);
                                  controller.productDetails.value = controller.productDetails.value;
                                  print(controller.productDetails.value!.name);

                                  previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                                  bottomNavbarIndexNotifier.value = 4;
                                },
                                child: ProductsListItemTile(
                                  productDetails: productDetails,
                                ),
                              );
                            },
                            itemCount: controller.roastedAndSalted.value.count,
                            scrollDirection: Axis.horizontal,
                          );
                  } else {
                    return Center(
                      child: CustomTextWidget(text: "Roasted and salted products not available right now."),
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
                  if (controller.valueAdded.value.count != 0) {
                    return controller.isValueAddedLoading.value
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              final productDetails = controller.valueAdded.value.results[index];

                              return GestureDetector(
                                onTap: () async {
                                  final String productId = controller.valueAdded.value.results[index].product.id.toString();
                                  // currentCategoryProducts = controller.roastedAndSalted.value;
                                  controller.productDetails.value = controller.productDetails.value;
                                  print(controller.productDetails.value!.name);

                                  previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                                  bottomNavbarIndexNotifier.value = 4;
                                  controller.getProductDetails(productId);
                                },
                                child: ProductsListItemTile(
                                  productDetails: productDetails,
                                ),
                              );
                            },
                            itemCount: controller.valueAdded.value.count,
                            scrollDirection: Axis.horizontal,
                          );
                  } else {
                    return Center(
                      child: CustomTextWidget(text: "Value added products not available right now."),
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
                () => controller.isAllProductsLoading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          final productDetails = controller.allProducts.value.results[index];

                          return GestureDetector(
                            onTap: () async {
                              final String productId = controller.allProducts.value.results[index].product.id.toString();

                              controller.getProductDetails(productId);
                              controller.productDetails.value = controller.productDetails.value;
                              print(controller.productDetails.value!.name);

                              previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                              bottomNavbarIndexNotifier.value = 4;
                            },
                            child: ProductsListItemTile(
                              productDetails: productDetails,
                            ),
                          );
                        },
                        itemCount: controller.allProducts.value.count,
                        scrollDirection: Axis.horizontal,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
