import 'package:flutter/material.dart';
import 'package:internship_sample/core/constatns.dart';
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
          padding: const EdgeInsets.all(16),
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
                children: List.generate(wishlistScreenProductsList.length, (index) {
                  return ProductsListItemTile(
                    imagePath: wishlistScreenProductsList[index]['imagePath'],
                    heading: wishlistScreenProductsList[index]['heading'],
                    description: wishlistScreenProductsList[index]['description'],
                    price: wishlistScreenProductsList[index]['price'],
                    numberOfRatings: wishlistScreenProductsList[index]['rating'],
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
