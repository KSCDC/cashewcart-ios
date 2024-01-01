import 'package:flutter/material.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class SlidingImageTile extends StatelessWidget {
  const SlidingImageTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xFFFD6E87)),
      padding: EdgeInsets.all(5),
      child: Stack(children: [
        // FittedBox(
        //   child: Image.asset(
        //     "lib/core/assets/images/other/offer_image1.jpg",
        //   ),
        //   fit: BoxFit.fill,
        // ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                text: "50-40% OFF",
                fontSize: 20,
                fontColor: Colors.white,
                fontweight: FontWeight.w700,
              ),
              CustomTextWidget(
                text: "Now in (product)",
                fontSize: 12,
                fontColor: Colors.white,
                fontweight: FontWeight.w400,
              ),
              CustomTextWidget(
                text: "All colours",
                fontSize: 12,
                fontColor: Colors.white,
                fontweight: FontWeight.w400,
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: BorderSide(width: 1, color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Container(
                  width: 100,
                  child: Row(
                    children: [
                      CustomTextWidget(
                        text: "Shop Now",
                        fontSize: 12,
                        fontColor: Colors.white,
                        fontweight: FontWeight.w600,
                      ),
                      Icon(
                        Icons.arrow_forward_outlined,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
