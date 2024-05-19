import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/main.dart';
import 'package:internship_sample/models/orders_list_model.dart';
import 'package:internship_sample/presentation/cart/widgets/cart_product_list_tile.dart';
import 'package:internship_sample/presentation/main_page/main_page_screen.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/my_orders/widgets/my_orders_list_tile.dart';
import 'package:internship_sample/presentation/order_tracking/order_tracking_screen.dart';
import 'package:internship_sample/presentation/widgets/custom_appbar.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/presentation/widgets/products_list_item_tile.dart';
import 'package:skeletonizer/skeletonizer.dart';

List recentOrdersList = [];
List productCountsList = [];
List productDetailsList1 = [];

class MyOrdersScreen extends StatelessWidget {
  MyOrdersScreen({super.key});
  int numberOfRecentOrders = recentOrdersList.length;
  AppController controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    controller.getOrdersList();
    final recentOrdersListRev = recentOrdersList.reversed.toList();
    print(numberOfRecentOrders);
    //log("Recent orders List :${recentOrdersList.toString()}");
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appBackgroundColor,
      // appBar: AppBar(
      //   scrolledUnderElevation: 0,
      //   leading: IconButton(
      //     onPressed: () {
      //       bottomNavbarIndexNotifier.value = previousPageIndexes.last;
      //       previousPageIndexes.removeLast();
      //     },
      //     icon: Icon(Icons.arrow_back_ios_new),
      //   ),
      //   centerTitle: true,
      //   title: CustomTextWidget(
      //     text: "Orders",
      //     fontSize: 18,
      //     fontweight: FontWeight.w600,
      //   ),
      // ),
      appBar: AppBar(
        // backgroundColor: kMainThemeColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              bottomNavbarIndexNotifier.value = 3;
              Get.off(() => MainPageScreen());
            }
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: CustomTextWidget(
          text: "Orders",
          fontSize: 18,
          fontweight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kHeight,
              const CustomTextWidget(
                text: "Recent Orders",
                fontweight: FontWeight.w600,
              ),
              kHeight,
              Obx(() {
                return Container(
                  // color: Colors.white,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      print("Orders values :${controller.ordersList[index].items.length}");
                      final OrdersListModel currentItem = controller.ordersList[index];
                      final String imagePath = "https://backend.cashewcart.com:8443${currentItem.items[0].product.product.productImages[0].productImage}";
                      final String name = currentItem.items[0].product.product.name;
                      final String description = currentItem.items[0].product.product.description;
                      final String price = currentItem.items[0].total;
                      final String rating = "4.5";
                      final String weight = currentItem.items[0].product.weightInGrams;
                      final String paymentStatus = controller.ordersList[index].paymentStatus;
                      final int count = currentItem.items[0].purchaseCount;

                      return Skeletonizer(
                        enabled: controller.isLoadingMyproducts.value,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return OrderTrackingScreen(
                                  productDetails: currentItem,
                                );
                              },
                            ),
                          ),
                          child: MyOrdersListTile(
                            imagePath: imagePath,
                            name: name,
                            price: price,
                            rating: rating,
                            totalItemsCount: currentItem.items.length,
                            weight: weight,
                            paymentStatus: paymentStatus,
                          ),
                        ),

                        //  ListView.builder(
                        //   itemBuilder: (context, ind) {
                        //     final String imagePath = "https://backend.cashewcart.com:8443${currentItem.items[ind].product.product.productImages[0].productImage}";
                        //     final String name = currentItem.items[ind].product.product.name;
                        //     final String description = currentItem.items[ind].product.product.description;
                        //     final String price = currentItem.items[ind].total;
                        //     final String rating = "4.5";
                        //     final String weight = currentItem.items[ind].product.weightInGrams;
                        //     final String paymentStatus = controller.ordersList[index].paymentStatus;
                        //     final int count = currentItem.items[ind].purchaseCount;
                        //     return Column(
                        //       children: [
                        //         kHeight,
                        //         GestureDetector(
                        //           onTap: () => Navigator.of(context).push(
                        //             MaterialPageRoute(
                        //               builder: (context) {
                        //                 return OrderTrackingScreen(
                        //                   productDetails: currentItem,
                        //                 );
                        //               },
                        //             ),
                        //           ),
                        //           child: MyOrdersListTile(
                        //             imagePath: imagePath,
                        //             name: name,
                        //             price: price,
                        //             rating: rating,
                        //             count: count,
                        //             weight: weight,
                        //             paymentStatus: paymentStatus,
                        //           ),
                        //         ),
                        //       ],
                        //     );
                        //   },
                        //   itemCount: currentItem.items.length,
                        //   physics: NeverScrollableScrollPhysics(),
                        //   shrinkWrap: true,
                        // ),
                      );
                    },
                    itemCount: controller.ordersList.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  ),
                );
                // }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
