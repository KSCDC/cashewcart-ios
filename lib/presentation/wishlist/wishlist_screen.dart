import 'package:flutter/material.dart';
import 'package:internship_sample/core/constatns.dart';
import 'package:internship_sample/presentation/shop/shop_screen.dart';
import 'package:internship_sample/presentation/widgets/main_appbar.dart';
import 'package:internship_sample/presentation/widgets/products_list_item_tile.dart';
import 'package:internship_sample/presentation/widgets/search_section_tile.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

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
                children: List.generate(productDetailsList2.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      print("image list ${productDetailsList1[index]['imagePath']}");
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ShopScreen(
                            imageList: productDetailsList1[index]['imagePath'],
                            productName: productDetailsList1[index]['name'],
                          ),
                        ),
                      );
                    },
                    child: ProductsListItemTile(
                      imageList: productDetailsList1[index]['imagePath'],
                      heading: productDetailsList1[index]['name'],
                      description: productDetailsList1[index]['description'],
                      price: productDetailsList1[index]['offerPrice'],
                      originalPrice: productDetailsList1[index]['originalPrice'],
                      offerPercentage: productDetailsList1[index]['offerPercentage'],
                      numberOfRatings: productDetailsList1[index]['rating'],
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
