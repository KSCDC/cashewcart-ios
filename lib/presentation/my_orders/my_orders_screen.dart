import 'package:flutter/material.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constatns.dart';
import 'package:internship_sample/presentation/cart/widgets/cart_product_list_tile.dart';
import 'package:internship_sample/presentation/my_orders/widgets/my_orders_list_tile.dart';
import 'package:internship_sample/presentation/order_tracking/order_tracking_screen.dart';
import 'package:internship_sample/presentation/widgets/custom_appbar.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/presentation/widgets/products_list_item_tile.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    print("values ${productDetailsList1[index]['imagePath']}");
                    return Column(
                      children: [
                        kHeight,
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OrderTrackingScreen(
                              imagePath: productDetailsList1[index]['imagePath'][0],
                              productName: productDetailsList1[index]['name'],
                              productDescription: productDetailsList1[index]['description'],
                              price: productDetailsList1[index]['offerPrice'],
                            ),
                          )),
                          child: MyOrdersListTile(
                            imagePath: productDetailsList1[index]['imagePath'][0],
                            heading: productDetailsList1[index]['name'],
                            price: productDetailsList1[index]['offerPrice'],
                            rating: "4",
                          ),
                        ),
                      ],
                    );
                  },
                  itemCount: 2,
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
