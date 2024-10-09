import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cashew_cart/controllers/app_controller.dart';
import 'package:cashew_cart/core/colors.dart';
import 'package:cashew_cart/core/constants.dart';
import 'package:cashew_cart/main.dart';
import 'package:cashew_cart/models/orders_list_model.dart';
import 'package:cashew_cart/presentation/cart/widgets/cart_product_list_tile.dart';
import 'package:cashew_cart/presentation/main_page/main_page_screen.dart';
import 'package:cashew_cart/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:cashew_cart/presentation/my_orders/widgets/my_orders_list_tile.dart';
import 'package:cashew_cart/presentation/my_orders/widgets/my_orders_list_tile_skeleton.dart';
import 'package:cashew_cart/presentation/order_tracking/order_tracking_screen.dart';
import 'package:cashew_cart/presentation/widgets/custom_appbar.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';
import 'package:cashew_cart/presentation/widgets/products_list_item_tile.dart';
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
    // print(numberOfRecentOrders);
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
              // bottomNavbarIndexNotifier.value = 3;
              // Get.off(() => MainPageScreen());
              Navigator.of(context).pop();
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
                return controller.isLoadingMyproducts.value
                    ? Container(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return MyOrdersListTileSkeleton();
                          },
                          itemCount: 5,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                        ),
                      )
                    : Container(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            final OrdersListModel currentItem = controller.ordersList[index];

                            return GestureDetector(
                              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderTrackingScreen(orderDetails: currentItem))),
                              //  Get.to(() => OrderTrackingScreen(orderDetails: currentItem)),
                              child: MyOrdersListTile(
                                currentItem: currentItem,
                              ),
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
