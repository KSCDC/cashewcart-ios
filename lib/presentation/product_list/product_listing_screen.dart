import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
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

class ProductListingScreen extends StatelessWidget {
  ProductListingScreen({
    super.key,
    required this.title,
  });
  final String title;
  AppController controller = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: MainAppBar(),
      appBar: CustomAppBar(),
      drawer: SideBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SearchSectionTile(),
                CustomTextWidget(
                  text: title,
                  fontSize: 24,
                  fontweight: FontWeight.w600,
                ),
                controller.productDisplayList.value.length != 0
                    ? GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        childAspectRatio: (20 / 30),
                        crossAxisCount: 2,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 5,
                        children: List.generate(controller.productDisplayList.length, (index) {
                          final productDetails = controller.productDisplayList[index];
                          return GestureDetector(
                            onTap: () async {
                              // print(
                              //     "image list ${controller.productDisplayList.valueindex]}");
                              final String productId = controller.productDisplayList.value[index].product.productId.toString();
                              Services().getProductDetailsAndGotoShopScreen(productId);
                              // controller.getSimilarProducts(controller.plainCashews.value, index);
                              // await controller.getProductDetails(productId);
                              // controller.productDetailsList.add(controller.productDetails.value!);
                              // previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                              // bottomNavbarIndexNotifier.value = 4;
                            },
                            child: ProductsListItemTile(
                              productDetails: productDetails,
                            ),
                          );
                        }),
                      )
                    : Container(
                        height: screenSize.height * 0.7,
                        child: Center(
                          child: CustomTextWidget(text: "No products found"),
                        ),
                      ),
                // if (controller.productDisplayList.value.next != null)
                //   GestureDetector(
                //     onTap: () {
                //       controller.trendingProductsPageNo++;
                //       if (currentDisplayProductCategory == "Sponserd") {
                //         controller.getSponserdProducts();
                //       }
                //     },
                //     child: CustomTextWidget(text: "Load More"),
                //   ),
                kHeight,
              ],
            );
          }),
        ),
      ),
    );
  }
}
