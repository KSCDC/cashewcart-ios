import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/main.dart';
import 'package:internship_sample/presentation/home/home_screen.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/product_list/product_listing_screen.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

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
                        image: AssetImage("lib/core/assets/images/product_images/Cashew Powder/Cashew Powder 1.jpg"),
                        fit: BoxFit.fitWidth,
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
                            text: "${controller.valueAdded.value.count}",
                            fontSize: 16,
                            fontweight: FontWeight.w400,
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () async {
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          // builder: (context) => ProductListingScreen(productDetailsList: valueAddedProducts),
                          //   ),
                          // );
                          // final String productId = controller.valueAdded.value.results[0].product.id.toString();
                          // final currentCategoryProducts = controller.valueAdded.value;
                          // controller.getSimilarProducts(controller.valueAdded.value, 0);
                          // await controller.getProductDetails(productId);
                          // controller.productDetails.value = controller.productDetails.value;
                          controller.productDisplayList = controller.valueAdded;
                          // print(controller.productDetails.value!.name);
                          // print(controller.productDisplayList .toString());

                          previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                          bottomNavbarIndexNotifier.value = 5;
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
