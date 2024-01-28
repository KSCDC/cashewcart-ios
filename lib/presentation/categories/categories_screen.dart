import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constatns.dart';
import 'package:internship_sample/main.dart';
import 'package:internship_sample/presentation/home/home_screen.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/shop/shop_screen.dart';
import 'package:internship_sample/presentation/side_bar/side_bar.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/presentation/widgets/main_appbar.dart';
import 'package:internship_sample/presentation/widgets/products_list_item_tile.dart';
import 'package:internship_sample/presentation/widgets/search_section_tile.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: MainAppBar(),
      drawer: SideBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchSectionTile(heading: "All Featured Products"),
              CustomTextWidget(
                text: "Cashews Plane Premium Grade ",
                fontSize: 18,
                fontweight: FontWeight.w600,
              ),
              Container(
                height: 250,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    // log("details :${cashewsPlaneList[index]['category'][0]}");
                    log("description :${cashewsPlaneList[index]['category'][0]['description']}");
                    log("ofprice :${cashewsPlaneList[index]['category'][0]['offerPrice']}");
                    log("name :${cashewsPlaneList[index]['name']}");
                    log("length :${cashewsPlaneList.length}");
                    // log("details :${cashewsPlaneList[index]['category'][0]}");
                    // log("details :${cashewsPlaneList[index]['category'][0]}");
                    return GestureDetector(
                      onTap: () async {
                        selectedProductDetails = await cashewsPlaneList[index];
                        previousPageIndex = bottomNavbarIndexNotifier.value;
                        bottomNavbarIndexNotifier.value = 4;

                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => ShopScreen(
                        //       productDetails: cashewsPlaneList[index],
                        //     ),
                        //   ),
                        // );
                      },
                      child: ProductsListItemTile(
                        productDetails: cashewsPlaneList[index],
                      ),
                    );
                  },
                  itemCount: cashewsPlaneList.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(height: 20),
              CustomTextWidget(
                text: "Cashews Roasted & Saltted Premium Grade",
                fontSize: 18,
                fontweight: FontWeight.w600,
              ),
              Container(
                height: 250,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => ShopScreen(
                        //       productDetails: roastedCashewsList[index],
                        //     ),
                        //   ),
                        // );
                        selectedProductDetails = await roastedCashewsList[index];
                        previousPageIndex = bottomNavbarIndexNotifier.value;
                        bottomNavbarIndexNotifier.value = 4;
                      },
                      child: ProductsListItemTile(
                        productDetails: roastedCashewsList[index],
                      ),
                    );
                  },
                  itemCount: roastedCashewsList.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              CustomTextWidget(
                text: "Value Added Products",
                fontSize: 18,
                fontweight: FontWeight.w600,
              ),
              Container(
                height: 250,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => ShopScreen(
                        //       productDetails: valueAddedProducts[index],
                        //     ),
                        //   ),
                        // );
                        selectedProductDetails = await valueAddedProducts[index];
                        previousPageIndex = bottomNavbarIndexNotifier.value;
                        bottomNavbarIndexNotifier.value = 4;
                      },
                      child: ProductsListItemTile(
                        productDetails: valueAddedProducts[index],
                      ),
                    );
                  },
                  itemCount: valueAddedProducts.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
