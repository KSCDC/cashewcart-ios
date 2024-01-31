import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/main.dart';
import 'package:internship_sample/presentation/home/widgets/circle_avatar_list_item.dart';
import 'package:internship_sample/presentation/home/widgets/buy_now_tile.dart';
import 'package:internship_sample/presentation/home/widgets/value_added_products_tile.dart';
import 'package:internship_sample/presentation/home/widgets/sliding_image_tile.dart';
import 'package:internship_sample/presentation/home/widgets/sponsered_product_tile.dart';
import 'package:internship_sample/presentation/home/widgets/view_offer_tile.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/shop/shop_screen.dart';
import 'package:internship_sample/presentation/side_bar/side_bar.dart';
import 'package:internship_sample/presentation/widgets/products_list_item_tile.dart';
import 'package:internship_sample/presentation/widgets/search_section_tile.dart';
import 'package:internship_sample/presentation/widgets/custom_search_filtering_button.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/presentation/widgets/main_appbar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

var selectedProductDetails;

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MainAppBar(),
      drawer: SideBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchSectionTile(heading: "All Featured"),

              // circular list
              Container(
                height: 95,
                child: ListView.builder(
                  itemBuilder: (context, index) => CircleAvatarListItem(
                    imagePath: avatarImage[index]['imagePath'],
                    label: avatarImage[index]['label'],
                  ),
                  itemCount: avatarImage.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),

              //sliding windows
              Container(
                height: 230,
                width: screenSize.width * 0.9,
                child: PageView(
                  controller: controller,
                  children: [
                    SlidingImageTile(
                      productDetails: cashewsPlaneList[0],
                    ),
                    SlidingImageTile(
                      productDetails: roastedCashewsList[0],
                    ),
                    SlidingImageTile(
                      productDetails: valueAddedProducts[0],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: const WormEffect(
                  dotColor: Color(0xFFDEDBDB),
                  activeDotColor: Color(0xFFFFA3B3),
                  dotHeight: 10,
                  dotWidth: 10,
                  spacing: 15,
                ),
                onDotClicked: (index) {
                  controller.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  );
                },
              ),
              SizedBox(height: 10),
              ViewOfferTile(
                color: Color(0xFF4392F9),
                mainLabel: "Deal of the Day",
                icon: Icons.timer_outlined,
                subLabel: "22h 55m 20s remaining",
              ),
              kHeight,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          onTap: () async {
                            selectedProductDetails = await bestSellersList[index];
                            previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                            bottomNavbarIndexNotifier.value = 4;
                          },
                          child: ProductsListItemTile(
                            productDetails: bestSellersList[index],
                          ),
                        );
                      },
                      itemCount: bestSellersList.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ],
              ),
              kHeight,
              //special offers

              Container(
                height: 84,
                width: screenSize.width * 0.9,
                child: Row(
                  children: [
                    Image.asset("lib/core/assets/images/home/special_offer.png"),
                    SizedBox(width: 20),
                    Container(
                      width: 180,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextWidget(text: "Special Offers 😱"),
                          CustomTextWidget(
                            text: "We make sure you get the offer you need at best prices",
                            fontSize: 12,
                            fontweight: FontWeight.w300,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              kHeight,

              //buy now

              BuyNowTile(
                productDetails: cashewsPlaneList[0],
              ),

              const ViewOfferTile(
                color: Color(0xFFFD6E87),
                mainLabel: "Trending Products",
                icon: Icons.calendar_month,
                subLabel: "Last Date 29/02/22",
              ),

              // products list

              Container(
                height: 250,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        selectedProductDetails = await productDetailsList2[index];
                        previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                        bottomNavbarIndexNotifier.value = 4;
                      },
                      child: ProductsListItemTile(
                        productDetails: productDetailsList2[index],
                      ),
                    );
                  },
                  itemCount: productDetailsList2.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              const SizedBox(height: 10),

              // value added products

              const ValueAddedProductsTile(),
              const SizedBox(height: 15),

              //Sponsered product
              GestureDetector(
                onTap: () async {
                  selectedProductDetails = await roastedCashewsList[0];
                  previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                  bottomNavbarIndexNotifier.value = 4;
                },
                child: SponseredProductTile(
                  imagePath: "lib/core/assets/images/product_images/Roasted and Salted Cashew/Roasted and salted Cashew.png",
                ),
              ),
              kHeight,
              CustomTextWidget(
                text: "All Featured Products",
                fontSize: 18,
                fontweight: FontWeight.w600,
              ),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                childAspectRatio: (20 / 30),
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                children: List.generate(allFeaturedProductsList.length, (index) {
                  return GestureDetector(
                    onTap: () async {
                      print("image list ${allFeaturedProductsList[index]['imagePath']}");

                      selectedProductDetails = await allFeaturedProductsList[index];
                      previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                      bottomNavbarIndexNotifier.value = 4;
                    },
                    child: ProductsListItemTile(
                      productDetails: allFeaturedProductsList[index],
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
