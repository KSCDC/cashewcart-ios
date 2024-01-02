import 'package:flutter/material.dart';
import 'package:internship_sample/core/constatns.dart';
import 'package:internship_sample/presentation/home/widgets/circle_avatar_list_item.dart';
import 'package:internship_sample/presentation/home/widgets/flat_and_heels_tile.dart';
import 'package:internship_sample/presentation/home/widgets/new_arrivals_tile.dart';
import 'package:internship_sample/presentation/home/widgets/sliding_image_tile.dart';
import 'package:internship_sample/presentation/home/widgets/sponsered_product_tile.dart';
import 'package:internship_sample/presentation/home/widgets/view_offer_tile.dart';
import 'package:internship_sample/presentation/widgets/products_list_item_tile.dart';
import 'package:internship_sample/presentation/widgets/search_section_tile.dart';
import 'package:internship_sample/presentation/widgets/custom_search_filtering_button.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/presentation/widgets/main_appbar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MainAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SearchSectionTile(heading: "All Featured"),
              Container(
                height: 87,
                child: ListView.builder(
                  itemBuilder: (context, index) => CircleAvatarListItem(
                    imagePath: avatarImage[index]['imagePath'],
                    label: avatarImage[index]['label'],
                  ),
                  itemCount: avatarImage.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              Container(
                height: 230,
                width: screenSize.width * 0.9,
                child: PageView(
                  controller: controller,
                  children: [
                    SlidingImageTile(),
                    SlidingImageTile(),
                    SlidingImageTile(),
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
              Container(
                height: 250,
                color: Colors.white,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    print("values ${homeScreenProductsList1[index]['imagePath']}");
                    return ProductsListItemTile(
                      imagePath: homeScreenProductsList1[index]['imagePath'],
                      heading: homeScreenProductsList1[index]['heading'],
                      description: homeScreenProductsList1[index]['description'],
                      price: homeScreenProductsList1[index]['offerPrice'],
                      originalPrice: homeScreenProductsList1[index]['originalPrice'],
                      offerPercentage: homeScreenProductsList1[index]['offerPercentage'],
                      numberOfRatings: homeScreenProductsList1[index]['rating'],
                    );
                  },
                  itemCount: homeScreenProductsList1.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              Container(
                height: 84,
                width: screenSize.width * 0.9,
                child: Row(
                  children: [
                    Image.asset("lib/core/assets/images/product_images/home/special_offer.jpg"),
                    SizedBox(width: 20),
                    Container(
                      width: 180,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomTextWidget(text: "Special Offers"),
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
              FlatAndHeelsTile(),
              ViewOfferTile(
                color: Color(0xFFFD6E87),
                mainLabel: "Trending Products",
                icon: Icons.calendar_month,
                subLabel: "Last Date 29/02/22",
              ),
              Container(
                height: 250,
                color: Colors.white,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    print("values ${homeScreenProductsList1[index]['imagePath']}");
                    return ProductsListItemTile(
                      imagePath: homeScreenProductsList2[index]['imagePath'],
                      heading: homeScreenProductsList2[index]['heading'],
                      price: homeScreenProductsList2[index]['offerPrice'],
                      originalPrice: homeScreenProductsList2[index]['originalPrice'],
                      offerPercentage: homeScreenProductsList2[index]['offerPercentage'],
                    );
                  },
                  itemCount: homeScreenProductsList2.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(height: 10),
              NewArrivalsTile(),
              SizedBox(height: 15),
              SponseredProductTile(),
            ],
          ),
        ),
      ),
    );
  }
}
