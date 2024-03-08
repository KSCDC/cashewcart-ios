import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/main.dart';
import 'package:internship_sample/presentation/cart/widgets/cart_product_list_tile.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/my_orders/widgets/my_orders_list_tile.dart';
import 'package:internship_sample/presentation/order_tracking/order_tracking_screen.dart';
import 'package:internship_sample/presentation/widgets/custom_appbar.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/presentation/widgets/products_list_item_tile.dart';

List recentOrdersList = [];
List productCountsList = [];
List productDetailsList1 = [];

class MyOrdersScreen extends StatelessWidget {
  MyOrdersScreen({super.key});
  int numberOfRecentOrders = recentOrdersList.length;

  @override
  Widget build(BuildContext context) {
    final recentOrdersListRev = recentOrdersList.reversed.toList();
    print(numberOfRecentOrders);
    log("Recent orders List :${recentOrdersList.toString()}");
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            bottomNavbarIndexNotifier.value = previousPageIndexes.last;
            previousPageIndexes.removeLast();
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
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
              Container(
                // color: Colors.white,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    print("values ${productDetailsList1[index]['imagePath'][0]}");
                    final int category = recentOrdersListRev[index]['category'];
                    final String imagePath = recentOrdersListRev[index]['product']['imagePath'][0];
                    final String name = recentOrdersListRev[index]['product']['name'];
                    final String description = recentOrdersListRev[index]['product']['category'][category]['description'];
                    final String price = recentOrdersListRev[index]['product']['category'][category]['offerPrice'];
                    final String rating = recentOrdersListRev[index]['product']['category'][category]['rating'];
                    final String weight = recentOrdersListRev[index]['product']['category'][category]['weight'];

                    final int count = recentOrdersListRev[index]['count'];
                    log("count :$count");

                    return Column(
                      children: [
                        kHeight,
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return OrderTrackingScreen(
                                  imagePath: imagePath,
                                  productName: name,
                                  productDescription: description,
                                  price: price,
                                );
                              },
                            ),
                          ),
                          child: MyOrdersListTile(
                            imagePath: imagePath,
                            name: name,
                            price: price,
                            rating: rating,
                            count: count,
                            weight: weight,
                          ),
                        ),
                      ],
                    );
                  },
                  itemCount: numberOfRecentOrders,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
