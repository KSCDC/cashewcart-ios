import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:internship_sample/core/base_url.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SlidingProductTile extends StatelessWidget {
  SlidingProductTile({
    super.key,
    required this.imageList,
    required this.count,
  });
  final controller = PageController();
  final List<dynamic> imageList;
  final int count;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // if (imageList.isEmpty) {
    //   // add image to display if the product image is missing from the api
    //   imageList.add("");
    // }
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
                      imagePath: imageList.isNotEmpty ? "$baseUrl${imageList[i].productImage}" : "https://t3.ftcdn.net/jpg/05/04/28/96/240_F_504289605_zehJiK0tCuZLP2MdfFBpcJdOVxKLnXg1.jpg",
                    ),
                    // Positioned(
                    //   top: 25,
                    //   right: 25,
                    //   child: CircleAvatar(
                    //     radius: 20,
                    //     child: Icon(Icons.share),
                    //   ),
                    // ),
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
    // print("Image path: $imagePath");
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          showImageViewer(context, NetworkImage(imagePath), swipeDismissible: true, doubleTapZoomable: true);
        },
        child: imagePath == ''
            ? Container(
                width: screenSize.width * 0.9,
                height: screenSize.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: CustomTextWidget(text: "Product image not available right now"),
                ),
              )
            : Container(
                width: screenSize.width * 0.9,
                height: screenSize.width * 0.8,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imagePath),
                    fit: BoxFit.fitHeight,
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
