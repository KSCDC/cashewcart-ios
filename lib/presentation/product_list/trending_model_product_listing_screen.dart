import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/core/base_url.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/main.dart';
import 'package:internship_sample/models/product_model.dart';
import 'package:internship_sample/presentation/home/home_screen.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/shop/shop_screen.dart';
import 'package:internship_sample/presentation/side_bar/side_bar.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/presentation/widgets/main_appbar.dart';
import 'package:internship_sample/presentation/widgets/products_list_item_tile.dart';
import 'package:internship_sample/presentation/widgets/search_section_tile.dart';

class TrendingModelProductListingScreen extends StatelessWidget {
  TrendingModelProductListingScreen({
    super.key,
  });

  AppController controller = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      drawer: SideBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              SearchSectionTile(
                  // heading: "${controller.productDisplayList2.value.count} Items ",
                  ),
              Obx(() {
                print("count :${controller.productDisplayList2.value.count}");
                return controller.isTrendingLoading.value || controller.isSponserdLoading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          controller.productDisplayList2.value.count != 0
                              ? GridView.count(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  childAspectRatio: (20 / 30),
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                  children: List.generate(controller.productDisplayList2.value.count, (index) {
                                    final productDetails = controller.productDisplayList2.value.results[index].product;
                                    return GestureDetector(
                                      onTap: () async {
                                        // print(
                                        //     "image list ${controller.productDisplayList.valueindex]}");
                                        final String productId = controller.productDisplayList2.value.results[index].product.product.id.toString();
                                        controller.getSimilarProducts(controller.plainCashews.value, index);
                                        await controller.getProductDetails(productId);
                                        controller.productDetails.value = controller.productDetails.value;
                                        previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                                        bottomNavbarIndexNotifier.value = 4;
                                      },
                                      child: ProductsListItemTile(
                                        productDetails: productDetails,
                                        imagePath: "$baseUrl${controller.productDisplayList2.value.results[index].product.product.productImages[0].productImage}",
                                      ),
                                    );
                                  }),
                                )
                              : Center(
                                  child: CustomTextWidget(text: "No products found"),
                                )
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
