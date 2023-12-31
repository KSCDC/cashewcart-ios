import 'package:flutter/material.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class NewArrivalsTile extends StatelessWidget {
  const NewArrivalsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          FittedBox(
            child: Image.asset(
              "lib/core/assets/images/product_images/home/new_arrivals.jpg",
            ),
            fit: BoxFit.fill,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidget(
                    text: "New Arrivals",
                    fontSize: 20,
                    fontweight: FontWeight.w500,
                  ),
                  CustomTextWidget(
                    text: "Summer’ 25 Collections",
                    fontSize: 16,
                    fontweight: FontWeight.w400,
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: kMainThemeColor,
                  side: BorderSide(width: 1, color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Container(
                  width: 80,
                  child: Row(
                    children: [
                      CustomTextWidget(
                        text: "View All",
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
            ],
          )
        ],
      ),
    );
  }
}
