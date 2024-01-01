import 'package:flutter/material.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class FlatAndHeelsTile extends StatelessWidget {
  const FlatAndHeelsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 20,
            height: 180,
            // color: Colors.black,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/core/assets/images/product_images/home/yellow_bar.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                width: 78,
                height: 180,
                // color: Colors.black,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("lib/core/assets/images/product_images/home/starbg.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: 130,
                  height: 150,
                  // color: Colors.black,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("lib/core/assets/images/product_images/home/heels.jpg"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextWidget(
                text: "Flat and Heels",
                fontSize: 16,
                fontweight: FontWeight.w500,
              ),
              CustomTextWidget(
                text: "Stand a chance to get rewarded",
                fontSize: 10,
                fontweight: FontWeight.w400,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 10),
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: kMainThemeColor,
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
                          text: "Visit Now",
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
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
