import 'package:flutter/material.dart';
import 'package:internship_sample/core/constatns.dart';
import 'package:internship_sample/presentation/shop/shop_screen.dart';
import 'package:internship_sample/presentation/widgets/main_appbar.dart';
import 'package:internship_sample/presentation/widgets/products_list_item_tile.dart';
import 'package:internship_sample/presentation/widgets/search_section_tile.dart';

class ProductListingScreen extends StatelessWidget {
  const ProductListingScreen({super.key, required this.productDetailsList});
  final List productDetailsList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              SearchSectionTile(
                heading: "52,082+ Iteams ",
              ),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                childAspectRatio: (20 / 30),
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                children: List.generate(productDetailsList.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      print("image list ${productDetailsList[index]['imagePath']}");
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ShopScreen(
                            imageList: productDetailsList[index]['imagePath'],
                            productName: productDetailsList[index]['name'],
                            description: productDetailsList[index]['description'],
                            price: productDetailsList[index]['offerPrice'],
                          ),
                        ),
                      );
                    },
                    child: ProductsListItemTile(
                      imageList: productDetailsList[index]['imagePath'],
                      heading: productDetailsList[index]['name'],
                      description: productDetailsList[index]['description'],
                      price: productDetailsList[index]['offerPrice'],
                      originalPrice: productDetailsList[index]['originalPrice'],
                      offerPercentage: productDetailsList[index]['offerPercentage'],
                      numberOfRatings: productDetailsList[index]['rating'],
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
