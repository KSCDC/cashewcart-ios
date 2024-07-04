import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cashew_cart/controllers/app_controller.dart';
import 'package:cashew_cart/core/base_url.dart';
import 'package:cashew_cart/core/colors.dart';
import 'package:cashew_cart/core/constants.dart';
import 'package:cashew_cart/main.dart';
import 'package:cashew_cart/presentation/home/home_screen.dart';
import 'package:cashew_cart/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:cashew_cart/presentation/product_list/product_listing_screen.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';

class ValueAddedProductsTile extends StatelessWidget {
  ValueAddedProductsTile({super.key});
  AppController controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Obx(() {
        final productImage;
        if (controller.valueAdded.value.isNotEmpty) {
          productImage = controller.valueAdded.value[0].product.productImages.isNotEmpty ? "$baseUrl${controller.valueAdded.value[0].product.productImages[0].productImage}" : "";
        } else {
          productImage = "";
        }

        return controller.isValueAddedLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: screenSize.width * 0.95,
                    height: screenSize.width * 0.6,
                    // color: Colors.black,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(productImage),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextWidget(
                            text: "Value Added Products",
                            fontSize: 20,
                            fontweight: FontWeight.w500,
                          ),
                          CustomTextWidget(
                            text: "${controller.valueAdded.value.length}",
                            fontSize: 16,
                            fontweight: FontWeight.w400,
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () async {
                          controller.productDisplayList = controller.valueAdded;
                          Get.to(() => ProductListingScreen(title: "Value Added Products"));
                          // previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                          // bottomNavbarIndexNotifier.value = 5;
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: kMainThemeColor,
                          side: BorderSide(width: 1, color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Container(
                          width: 80,
                          child: Row(
                            children: [
                              CustomTextWidget(
                                text: "View All",
                                fontSize: 12,
                                fontColor: Colors.white,
                                fontweight: FontWeight.w600,
                              ),
                              Icon(
                                Icons.arrow_forward_outlined,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
      }),
    );
  }
}
