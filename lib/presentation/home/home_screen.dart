import 'package:flutter/material.dart';
import 'package:internship_sample/core/constatns.dart';
import 'package:internship_sample/presentation/home/widgets/circle_avatar_list_item.dart';
import 'package:internship_sample/presentation/home/widgets/sliding_image_tile.dart';
import 'package:internship_sample/presentation/home/widgets/view_offer_tile.dart';
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
    // print("sadfsafsafsa ${avatarImage[0]['label']}");
    return Scaffold(
      appBar: MainAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                height: 250,
                width: double.infinity,
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
                mainLabel: "Deal of the Day",
                icon: Icons.timer_outlined,
                subLabel: "22h 55m 20s remaining",
              )
            ],
          ),
        ),
      ),
    );
  }
}
