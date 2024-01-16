import 'package:flutter/material.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constatns.dart';
import 'package:internship_sample/presentation/shop/shop_screen.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchSectionTile(heading: "All Featured"),
              CustomTextWidget(
                text: "Best Sellers",
                fontSize: 18,
                fontweight: FontWeight.w600,
              ),
              Container(
                height: 250,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ShopScreen(
                              imageList: bestSellersList[index]['imagePath'],
                              productName: bestSellersList[index]['name'],
                              description: bestSellersList[index]['description'],
                              price: bestSellersList[index]['offerPrice'],
                            ),
                          ),
                        );
                      },
                      child: ProductsListItemTile(
                        imageList: bestSellersList[index]['imagePath'],
                        heading: bestSellersList[index]['name'],
                        description: bestSellersList[index]['description'],
                        price: bestSellersList[index]['offerPrice'],
                        originalPrice: bestSellersList[index]['originalPrice'],
                        offerPercentage: bestSellersList[index]['offerPercentage'],
                        numberOfRatings: bestSellersList[index]['rating'],
                      ),
                    );
                  },
                  itemCount: bestSellersList.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(height: 20),
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
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ShopScreen(
                              imageList: valueAddedProducts[index]['imagePath'],
                              productName: valueAddedProducts[index]['name'],
                              description: valueAddedProducts[index]['description'],
                              price: valueAddedProducts[index]['offerPrice'],
                            ),
                          ),
                        );
                      },
                      child: ProductsListItemTile(
                        imageList: valueAddedProducts[index]['imagePath'],
                        heading: valueAddedProducts[index]['name'],
                        description: valueAddedProducts[index]['description'],
                        price: valueAddedProducts[index]['offerPrice'],
                        originalPrice: valueAddedProducts[index]['originalPrice'],
                        offerPercentage: valueAddedProducts[index]['offerPercentage'],
                        numberOfRatings: valueAddedProducts[index]['rating'],
                      ),
                    );
                  },
                  itemCount: valueAddedProducts.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(height: 20),
              CustomTextWidget(
                text: "Plain Cashews",
                fontSize: 18,
                fontweight: FontWeight.w600,
              ),
              Container(
                height: 250,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ShopScreen(
                              imageList: plainCashewsList[index]['imagePath'],
                              productName: plainCashewsList[index]['name'],
                              description: plainCashewsList[index]['description'],
                              price: plainCashewsList[index]['offerPrice'],
                            ),
                          ),
                        );
                      },
                      child: ProductsListItemTile(
                        imageList: plainCashewsList[index]['imagePath'],
                        heading: plainCashewsList[index]['name'],
                        description: plainCashewsList[index]['description'],
                        price: plainCashewsList[index]['offerPrice'],
                        originalPrice: plainCashewsList[index]['originalPrice'],
                        offerPercentage: plainCashewsList[index]['offerPercentage'],
                        numberOfRatings: plainCashewsList[index]['rating'],
                      ),
                    );
                  },
                  itemCount: plainCashewsList.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(height: 20),
              CustomTextWidget(
                text: "Roasted Cashews",
                fontSize: 18,
                fontweight: FontWeight.w600,
              ),
              Container(
                height: 250,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ShopScreen(
                              imageList: roastedCashewsList[index]['imagePath'],
                              productName: roastedCashewsList[index]['name'],
                              description: roastedCashewsList[index]['description'],
                              price: roastedCashewsList[index]['offerPrice'],
                            ),
                          ),
                        );
                      },
                      child: ProductsListItemTile(
                        imageList: roastedCashewsList[index]['imagePath'],
                        heading: roastedCashewsList[index]['name'],
                        description: roastedCashewsList[index]['description'],
                        price: roastedCashewsList[index]['offerPrice'],
                        originalPrice: roastedCashewsList[index]['originalPrice'],
                        offerPercentage: roastedCashewsList[index]['offerPercentage'],
                        numberOfRatings: roastedCashewsList[index]['rating'],
                      ),
                    );
                  },
                  itemCount: roastedCashewsList.length,
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
