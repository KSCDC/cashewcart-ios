import 'package:flutter/material.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constatns.dart';
import 'package:internship_sample/presentation/kart/widgets/cart_product_list_tile.dart';
import 'package:internship_sample/presentation/widgets/custom_appbar.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/presentation/widgets/products_list_item_tile.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: CustomAppBar(
        title: "Cart",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 15,
                  ),
                  kWidth,
                  CustomTextWidget(
                    text: "Delivery Address",
                    fontweight: FontWeight.w600,
                  ),
                ],
              ),
              kHeight,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: screenSize.width * 0.21,
                    width: screenSize.width * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextWidget(
                                text: "Address :",
                                fontSize: 12,
                                fontweight: FontWeight.w500,
                              ),
                              kHeight,
                              CustomTextWidget(
                                text: "216 St Paul's Rd, London N1 2LL, UK Contact :  +44-784232 ",
                                fontSize: 12,
                                fontweight: FontWeight.w500,
                              ),
                            ],
                          ),
                          Positioned(
                            top: -5,
                            right: -2,
                            child: Icon(Icons.edit_note_rounded),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: screenSize.width * 0.21,
                    width: screenSize.width * 0.21,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                        Icons.add_circle_outline,
                      ),
                    ),
                  )
                ],
              ),
              kHeight,
              CustomTextWidget(
                text: "Shopping List",
                fontweight: FontWeight.w600,
              ),
              kHeight,
              Container(
                color: Colors.white,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    print("values ${homeScreenProductsList1[index]['imagePath']}");
                    return Column(
                      children: [
                        kHeight,
                        CartProductsListTile(
                          imagePath: homeScreenProductsList1[index]['imagePath'],
                          heading: homeScreenProductsList1[index]['heading'],
                          price: homeScreenProductsList1[index]['offerPrice'],
                          originalPrice: homeScreenProductsList1[index]['originalPrice'],
                          offerPercentage: homeScreenProductsList1[index]['offerPercentage'],
                          rating: "4",
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
