import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SlidingProductTile extends StatelessWidget {
  SlidingProductTile({
    super.key,
    required this.imagePath,
    required this.count,
  });
  final controller = PageController();
  final List<String> imagePath;
  final int count;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: screenSize.width * 0.95,
          height: screenSize.width * 0.75,
          child: PageView(
            controller: controller,
            children: [
              for (int i = 0; i < count; i++)
                Stack(
                  children: [
                    SlideItem(
                      imagePath: imagePath[i],
                    ),
                    Positioned(
                      top: 25,
                      right: 25,
                      child: CircleAvatar(
                        radius: 20,
                        child: Icon(Icons.share),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        SizedBox(height: 10),
        SmoothPageIndicator(
          controller: controller,
          count: count,
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
      ],
    );
  }
}

class SlideItem extends StatelessWidget {
  const SlideItem({
    super.key,
    required this.imagePath,
  });
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          showImageViewer(context, AssetImage(imagePath), swipeDismissible: true, doubleTapZoomable: true);
        },
        child: Container(
          width: screenSize.width * 0.9,
          height: screenSize.width * 0.8,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
