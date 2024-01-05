import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:internship_sample/core/constatns.dart';
import 'package:internship_sample/presentation/checkout/checkout_screen.dart';
import 'package:internship_sample/presentation/cart/cart_screen.dart';
import 'package:internship_sample/presentation/place_order/place_order_screen.dart';
import 'package:internship_sample/presentation/shop/widgets/custom_styled_shop_page_button.dart';
import 'package:internship_sample/presentation/shop/widgets/custom_text_icon_button.dart';
import 'package:internship_sample/presentation/shop/widgets/shop_product_details_tile.dart';
import 'package:internship_sample/presentation/widgets/custom_appbar.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/presentation/widgets/products_list_item_tile.dart';
import 'package:internship_sample/presentation/widgets/search_filter_bar.dart';
import 'package:internship_sample/presentation/widgets/sliding_product_tile.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({
    super.key,
    required this.imageList,
    required this.productName,
  });

  final List<String> imageList;
  final String productName;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        actionWidget: GestureDetector(
          child: const CircleAvatar(
            backgroundColor: Color(0xFFF2F2F2),
            child: Icon(
              Icons.shopping_cart_outlined,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SlidingProductTile(
              imagePath: imageList,
              count: imageList.length,
            ),
            ShopProductDetailsTile(
              productName: productName,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CartScreen(),
                      ),
                    ),
                    child: const CustomStyledShopPageButton(
                      gradientColors: [
                        Color(0xFF3F92FF),
                        Color(0xFF0B3689),
                      ],
                      icon: Icons.shopping_cart_outlined,
                      label: "Go to cart",
                    ),
                  ),
                  kWidth,
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PlaceOrderScreen(),
                      ),
                    ),
                    child: const CustomStyledShopPageButton(
                      gradientColors: [
                        Color(0xFF71F9A9),
                        Color(0xFF31B769),
                      ],
                      icon: Icons.touch_app_outlined,
                      label: "Buy Now",
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFCCD5),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextWidget(
                            text: "Delivery in",
                            fontweight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          CustomTextWidget(
                            text: "1 within Hour",
                            fontSize: 21,
                            fontweight: FontWeight.w600,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: screenSize.width * 0.48,
                  child: const CustomTextIconButton(
                    icon: Icons.remove_red_eye_outlined,
                    label: "Nearest Store",
                    textAndIconColor: Colors.black,
                    textAndIconSize: 14,
                  ),
                ),
                Container(
                  width: screenSize.width * 0.48,
                  child: const CustomTextIconButton(
                    icon: Icons.difference_outlined,
                    label: "Add to compare",
                    textAndIconColor: Colors.black,
                    textAndIconSize: 14,
                  ),
                ),
              ],
            ),
            kHeight,
            const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomTextWidget(
                text: "Similar To",
                fontSize: 20,
                fontweight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SearchFilterBar(
                heading: "282+ Items",
              ),
            ),
            Container(
              height: 250,
              color: Colors.white,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ProductsListItemTile(
                    imageList: productDetailsList1[index]['imagePath'],
                    heading: productDetailsList1[index]['name'],
                    description: productDetailsList1[index]['description'],
                    price: productDetailsList1[index]['offerPrice'],
                    originalPrice: productDetailsList1[index]['originalPrice'],
                    offerPercentage: productDetailsList1[index]['offerPercentage'],
                    numberOfRatings: productDetailsList1[index]['rating'],
                  );
                },
                itemCount: productDetailsList1.length,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
