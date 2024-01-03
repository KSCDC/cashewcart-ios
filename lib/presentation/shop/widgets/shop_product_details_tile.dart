import 'package:flutter/material.dart';
import 'package:internship_sample/core/constatns.dart';
import 'package:internship_sample/presentation/shop/widgets/custom_text_icon_button.dart';
import 'package:internship_sample/presentation/shop/widgets/size_selector_widget.dart';
import 'package:internship_sample/presentation/widgets/custom_star_rating_tile.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

ValueNotifier<int> sizeSelectNotifier = ValueNotifier(0);

class ShopProductDetailsTile extends StatelessWidget {
  ShopProductDetailsTile({super.key});
  ValueNotifier<bool> readMoreClickNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextWidget(
            text: "Size: 7UK",
            fontweight: FontWeight.w600,
          ),
          SizedBox(height: 10),
          ValueListenableBuilder(
              valueListenable: sizeSelectNotifier,
              builder: (BuildContext, int, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizeSelectorWidget(
                      index: 0,
                      label: "6 UK",
                      fontColor: sizeSelectNotifier.value == 0 ? Colors.white : Color(0xFFFA7189),
                      backgroundColor: sizeSelectNotifier.value == 0 ? Color(0xFFFA7189) : Colors.white,
                    ),
                    SizeSelectorWidget(
                      index: 1,
                      label: "7 UK",
                      fontColor: sizeSelectNotifier.value == 1 ? Colors.white : Color(0xFFFA7189),
                      backgroundColor: sizeSelectNotifier.value == 1 ? Color(0xFFFA7189) : Colors.white,
                    ),
                    SizeSelectorWidget(
                      index: 2,
                      label: "8 UK",
                      fontColor: sizeSelectNotifier.value == 2 ? Colors.white : Color(0xFFFA7189),
                      backgroundColor: sizeSelectNotifier.value == 2 ? Color(0xFFFA7189) : Colors.white,
                    ),
                    SizeSelectorWidget(
                      index: 3,
                      label: "9 UK",
                      fontColor: sizeSelectNotifier.value == 3 ? Colors.white : Color(0xFFFA7189),
                      backgroundColor: sizeSelectNotifier.value == 3 ? Color(0xFFFA7189) : Colors.white,
                    ),
                    SizeSelectorWidget(
                      index: 4,
                      label: "10 UK",
                      fontColor: sizeSelectNotifier.value == 4 ? Colors.white : Color(0xFFFA7189),
                      backgroundColor: sizeSelectNotifier.value == 4 ? Color(0xFFFA7189) : Colors.white,
                    ),
                  ],
                );
              }),
          SizedBox(height: 10),
          CustomTextWidget(
            text: "Nike Sneakers",
            fontSize: 20,
            fontweight: FontWeight.w600,
          ),
          CustomTextWidget(
            text: "Vision Alta Men’s Shoes Size (All Colours)",
            fontSize: 14,
            fontweight: FontWeight.w400,
          ),
          // SizedBox(height: 10),
          CustomStarRatingTile(
            numberOfRatings: "56,890",
            iconAndTextSize: 18,
          ),
          Row(
            children: [
              Text(
                "2,999",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 14,
                  color: Color(0xFF808488),
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Color(0xFF808488),
                ),
              ),
              kWidth,
              CustomTextWidget(
                text: "1,500",
                fontSize: 14,
                fontweight: FontWeight.w400,
              ),
              kWidth,
              CustomTextWidget(
                text: "50%Off",
                fontColor: Color(0xFFFE735C),
                fontSize: 14,
                fontweight: FontWeight.w400,
              ),
            ],
          ),
          kHeight,
          CustomTextWidget(
            text: "Product Details",
            fontSize: 15,
            fontweight: FontWeight.w500,
          ),

          ValueListenableBuilder(
            valueListenable: readMoreClickNotifier,
            builder: (context, value, _) {
              return Wrap(
                children: [
                  Text(
                    '''Perhaps the most iconic sneaker of all-time, this original "Chicago"? colorway is the cornerstone to any sneaker collection. Made famous in 1985 by Michael Jordan, the shoe has stood the test of time, becoming the most famous colorway of the Air Jordan 1. This 2015 release saw the Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ''',
                    maxLines: readMoreClickNotifier.value ? 10 : 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.all(6),
                    child: GestureDetector(
                      child: Text(
                        readMoreClickNotifier.value ? "Less" : "More",
                        style: TextStyle(
                          color: Color(0xFFFE735C),
                        ),
                      ),
                      onTap: () {
                        readMoreClickNotifier.value = !(readMoreClickNotifier.value);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
          Row(
            children: [
              CustomTextIconButton(
                icon: Icons.location_on_outlined,
                label: "Nearest Store",
                textAndIconColor: Color(0xFF828282),
                textAndIconSize: 12,
              ),
              kWidth,
              CustomTextIconButton(
                icon: Icons.lock_outline_sharp,
                label: "VIP",
                textAndIconColor: Color(0xFF828282),
                textAndIconSize: 12,
              ),
              kWidth,
              CustomTextIconButton(
                icon: Icons.lock_outline_sharp,
                label: "Return Policy",
                textAndIconColor: Color(0xFF828282),
                textAndIconSize: 12,
              ),
            ],
          )
        ],
      ),
    );
  }
}
