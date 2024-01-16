import 'package:flutter/material.dart';
import 'package:internship_sample/core/constatns.dart';
import 'package:internship_sample/presentation/shop/widgets/custom_text_icon_button.dart';
import 'package:internship_sample/presentation/shop/widgets/size_selector_widget.dart';
import 'package:internship_sample/presentation/widgets/custom_star_rating_tile.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

ValueNotifier<int> sizeSelectNotifier = ValueNotifier(0);

class ShopProductDetailsTile extends StatelessWidget {
  ShopProductDetailsTile({
    super.key,
    required this.productName,
    required this.description,

  });
  ValueNotifier<bool> readMoreClickNotifier = ValueNotifier(false);
  final String productName;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder(
              valueListenable: sizeSelectNotifier,
              builder: (context, value, _) {
                return Row(
                  children: [
                    CustomTextWidget(
                      text: "Net weight: ",
                      fontweight: FontWeight.w600,
                    ),
                    if (value == 0)
                      CustomTextWidget(
                        text: "65 GM",
                        fontweight: FontWeight.w600,
                      ),
                    if (value == 1)
                      CustomTextWidget(
                        text: "100 GM",
                        fontweight: FontWeight.w600,
                      ),
                    if (value == 2)
                      CustomTextWidget(
                        text: "250 GM",
                        fontweight: FontWeight.w600,
                      ),
                    if (value == 3)
                      CustomTextWidget(
                        text: "500 GM",
                        fontweight: FontWeight.w600,
                      ),
                  ],
                );
              }),
          SizedBox(height: 10),
          ValueListenableBuilder(
              valueListenable: sizeSelectNotifier,
              builder: (context, value, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizeSelectorWidget(
                      index: 0,
                      label: "65 GM",
                      fontColor: sizeSelectNotifier.value == 0 ? Colors.white : Color(0xFFFA7189),
                      backgroundColor: sizeSelectNotifier.value == 0 ? Color(0xFFFA7189) : Colors.white,
                    ),
                    SizeSelectorWidget(
                      index: 1,
                      label: "100 GM",
                      fontColor: sizeSelectNotifier.value == 1 ? Colors.white : Color(0xFFFA7189),
                      backgroundColor: sizeSelectNotifier.value == 1 ? Color(0xFFFA7189) : Colors.white,
                    ),
                    SizeSelectorWidget(
                      index: 2,
                      label: "250 GM",
                      fontColor: sizeSelectNotifier.value == 2 ? Colors.white : Color(0xFFFA7189),
                      backgroundColor: sizeSelectNotifier.value == 2 ? Color(0xFFFA7189) : Colors.white,
                    ),
                    SizeSelectorWidget(
                      index: 3,
                      label: "500 GM",
                      fontColor: sizeSelectNotifier.value == 3 ? Colors.white : Color(0xFFFA7189),
                      backgroundColor: sizeSelectNotifier.value == 3 ? Color(0xFFFA7189) : Colors.white,
                    ),
                  ],
                );
              }),
          SizedBox(height: 10),
          CustomTextWidget(
            text: productName,
            fontSize: 20,
            fontweight: FontWeight.w600,
          ),
          const CustomTextWidget(
            text: "Vision Alta Men’s Shoes Size (All Colours)",
            fontSize: 14,
            fontweight: FontWeight.w400,
          ),
          // SizedBox(height: 10),
          CustomStarRatingTile(
            numberOfRatings: "56,890",
            iconAndTextSize: 18,
          ),
          const Row(
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
                    description,
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
          const Row(
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
