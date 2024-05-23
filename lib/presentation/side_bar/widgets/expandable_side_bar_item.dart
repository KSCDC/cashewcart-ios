import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/main.dart';
import 'package:internship_sample/presentation/home/home_screen.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/product_list/product_listing_screen.dart';
import 'package:internship_sample/presentation/product_list/trending_model_product_listing_screen.dart';
import 'package:internship_sample/presentation/side_bar/widgets/side_bar_item_tile.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class ExpandableProductsSideBarItem extends StatelessWidget {
  ExpandableProductsSideBarItem({super.key});
  ValueNotifier<bool> expandNotifier = ValueNotifier(false);

  AppController controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.shopping_bag_outlined,
                ),
                kWidth,
                CustomTextWidget(
                  text: "Products",
                  fontSize: 18,
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    expandNotifier.value = !expandNotifier.value;
                  },
                  child: ValueListenableBuilder(
                      valueListenable: expandNotifier,
                      builder: (context, expanded, _) {
                        return expanded
                            ? Icon(
                                Icons.keyboard_double_arrow_up_rounded,
                                color: kMainThemeColor,
                              )
                            : Icon(
                                Icons.keyboard_double_arrow_down_rounded,
                                color: kMainThemeColor,
                              );
                      }),
                ),
              ],
            ),
          ),
          ValueListenableBuilder(
            valueListenable: expandNotifier,
            builder: (context, expanded, _) {
              return expanded
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (!controller.isAlreadyLoadedAllProducts.value) {
                              controller.getAllProducts();
                            }

                            controller.productDisplayList = controller.allProducts;
                            Get.back();
                            Get.to(
                              () => ProductListingScreen(
                                title: "All Featured",
                              ),
                            );
                          },
                          child: ExpandableSideBarInnerItem(label: "All Featured"),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (!controller.isAlreadyLoadedBestsellers) {
                              controller.getBestSellerProducts();
                            }

                            controller.productDisplayList2 = controller.bestSellers;
                            Get.back();
                            Get.to(
                              () => TrendingModelProductListingScreen(
                                title: "Best Sellers",
                              ),
                            );
                          },
                          child: ExpandableSideBarInnerItem(label: "Best Sellers"),
                        ),
                        GestureDetector(
                          onTap: () {
                            // controller.productDisplayList = controller.plainCashews;
                            // currentDisplayProductCategory = "Trending";
                            if (!controller.isAlreadyLoadedTrending) {
                              controller.getTrendingProducts();
                            }

                            controller.productDisplayList2 = controller.trending;
                            // print("Trending : ${controller.productDisplayList2.value.count}");
                            // previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                            // bottomNavbarIndexNotifier.value = 9;

                            Get.to(
                              () => TrendingModelProductListingScreen(
                                title: "Trending Products",
                              ),
                            );
                          },
                          child: ExpandableSideBarInnerItem(label: "Trending"),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (!controller.isAlreadyLoadedSponserd) {
                              controller.getSponserdProducts();
                            }

                            controller.productDisplayList2 = controller.sponserd;
                            Get.back();
                            Get.to(
                              () => TrendingModelProductListingScreen(
                                title: "Sponsered Products",
                              ),
                            );
                          },
                          child: ExpandableSideBarInnerItem(label: "Sponsered"),
                        ),
                      ],
                    )
                  : SizedBox();
            },
          ),
          Divider(
            thickness: 0.3,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}

class ExpandableSideBarInnerItem extends StatelessWidget {
  const ExpandableSideBarInnerItem({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Column(
        children: [
          Divider(
            thickness: 0.3,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                kWidth,
                CustomTextWidget(text: label, fontSize: 14),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: kMainThemeColor,
                  size: 14,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
