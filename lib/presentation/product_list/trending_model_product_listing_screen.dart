import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/core/base_url.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/main.dart';
import 'package:internship_sample/models/product_model.dart';
import 'package:internship_sample/presentation/home/home_screen.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/shop/shop_screen.dart';
import 'package:internship_sample/presentation/side_bar/side_bar.dart';
import 'package:internship_sample/presentation/widgets/custom_appbar.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/presentation/widgets/main_appbar.dart';
import 'package:internship_sample/presentation/widgets/products_list_item_tile.dart';
import 'package:internship_sample/presentation/widgets/search_section_tile.dart';
import 'package:internship_sample/services/services.dart';

class TrendingModelProductListingScreen extends StatelessWidget {
  TrendingModelProductListingScreen({
    super.key,
    required this.title,
  });
  final String title;
  AppController controller = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: kMainThemeColor,
      ),
    );
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: SideBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SearchSectionTile(),

              Obx(() {
                print("counts :${controller.productDisplayList2.value.length}");
                return controller.isTrendingLoading.value
                    //  || controller.isSponserdLoading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextWidget(
                            text: title,
                            fontSize: 24,
                            fontweight: FontWeight.w600,
                          ),
                          controller.productDisplayList2.value.length != 0
                              ? GridView.count(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  childAspectRatio: (20 / 30),
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 0,
                                  crossAxisSpacing: 5,
                                  children: List.generate(controller.productDisplayList2.value.length, (index) {
                                    String imagePath;
                                    List imageList = controller.productDisplayList2.value[index].product.productImages;
                                    imagePath = imageList.isNotEmpty ? "$baseUrl${imageList[0].productImage}" : "";
                                    final productDetails = controller.productDisplayList2.value[index];
                                    print(productDetails);
                                    return GestureDetector(
                                      onTap: () async {
                                        // print(
                                        //     "image list ${controller.productDisplayList.valueindex]}");

                                        final String productId = controller.productDisplayList2.value[index].product.productId.toString();
                                        Services().getProductDetailsAndGotoShopScreen(context,productId);
                                        // controller.getSimilarProducts(controller.plainCashews.value, index);
                                        // await controller.getProductDetails(productId);
                                        // controller.productDetailsList.add(controller.productDetails.value!);
                                        // previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                                        // bottomNavbarIndexNotifier.value = 4;
                                      },
                                      child: ProductsListItemTile(
                                        productDetails: productDetails,
                                        imagePath: imagePath,
                                        // isUsedTrendingProductModel: true,
                                      ),
                                    );
                                  }),
                                )
                              : Center(
                                  child: CustomTextWidget(text: "No products found"),
                                ),
                          kHeight,
                          // if (controller.productDisplayList2.value.next != null)
                          //   GestureDetector(
                          //     onTap: () {
                          //       if (currentDisplayProductCategory == "Sponserd") {
                          //         controller.sponserdProductsPageNo++;
                          //         controller.getSponserdProducts();
                          //       }
                          //       if (currentDisplayProductCategory == "Trending") {
                          //         controller.trendingProductsPageNo++;
                          //         controller.getTrendingProducts();
                          //       }
                          //       if (currentDisplayProductCategory == "Best Sellers") {
                          //         controller.bestSellersPageNo++;
                          //         controller.getBestSellerProducts();
                          //       }
                          //     },
                          //     child: CustomTextWidget(text: "Load More"),
                          //   ),
                          // kHeight,
                        ],
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
