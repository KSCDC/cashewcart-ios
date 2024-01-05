import 'package:flutter/material.dart';
import 'package:internship_sample/core/constatns.dart';
import 'package:internship_sample/presentation/home/widgets/circle_avatar_list_item.dart';
import 'package:internship_sample/presentation/home/widgets/flat_and_heels_tile.dart';
import 'package:internship_sample/presentation/home/widgets/new_arrivals_tile.dart';
import 'package:internship_sample/presentation/home/widgets/sliding_image_tile.dart';
import 'package:internship_sample/presentation/home/widgets/sponsered_product_tile.dart';
import 'package:internship_sample/presentation/home/widgets/view_offer_tile.dart';
import 'package:internship_sample/presentation/shop/shop_screen.dart';
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
                  children: const [
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
                  },
                  itemCount: productDetailsList1.length,
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
              const FlatAndHeelsTile(),
              const ViewOfferTile(
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
                    print("Image list in kart ${productDetailsList2[index]['imagePath']}");
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
                        imageList: productDetailsList2[index]['imagePath'],
                        heading: productDetailsList2[index]['name'],
                        description: productDetailsList2[index]['description'],
                        price: productDetailsList2[index]['offerPrice'],
                        originalPrice: productDetailsList2[index]['originalPrice'],
                        offerPercentage: productDetailsList2[index]['offerPercentage'],
                        numberOfRatings: productDetailsList2[index]['rating'],
                      ),
                    );
                  },
                  itemCount: productDetailsList2.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              const SizedBox(height: 10),
              const NewArrivalsTile(),
              const SizedBox(height: 15),
              SponseredProductTile(
                imagePath: "${productDetailsList1[5]['imagePath'][0]}",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
