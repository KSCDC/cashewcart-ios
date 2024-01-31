import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/presentation/cart/widgets/cart_product_list_tile.dart';
import 'package:internship_sample/presentation/my_orders/widgets/my_orders_list_tile.dart';
import 'package:internship_sample/presentation/order_tracking/order_tracking_screen.dart';
import 'package:internship_sample/presentation/widgets/custom_appbar.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/presentation/widgets/products_list_item_tile.dart';

List recentOrdersList = [];
List productCountsList = [];

class MyOrdersScreen extends StatelessWidget {
  MyOrdersScreen({super.key});
  int numberOfRecentOrders = recentOrdersList.length;

  @override
  Widget build(BuildContext context) {
    print(numberOfRecentOrders);
    log("Recent orders List :${recentOrdersList.toString()}");
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
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
                    final int category = recentOrdersList[index]['category'];
                    final String imagePath = recentOrdersList[index]['product']['imagePath'][0];
                    final String name = recentOrdersList[index]['product']['name'];
                    final String description = recentOrdersList[index]['product']['category'][category]['description'];
                    final String price = recentOrdersList[index]['product']['category'][category]['offerPrice'];
                    final String rating = recentOrdersList[index]['product']['category'][category]['rating'];
                    final String weight = recentOrdersList[index]['product']['category'][category]['weight'];

                    final int count = recentOrdersList[index]['count'];

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
