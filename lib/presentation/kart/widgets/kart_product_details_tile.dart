import 'package:flutter/material.dart';
import 'package:internship_sample/presentation/kart/widgets/size_selector_widget.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

ValueNotifier<int> sizeSelectNotifier = ValueNotifier(0);

class KartProductDetailsTile extends StatelessWidget {
  const KartProductDetailsTile({super.key});

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
          SizedBox(height: 10),
          Row(
            children: [
              for (int i = 0; i < 4; i++)
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Container(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("lib/core/assets/images/product_images/home/star.jpg"),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                  ),
                ),
              SizedBox(width: 20),
              CustomTextWidget(
                text: "56,890",
                fontColor: Color(0xFF828282),
                fontweight: FontWeight.w500,
              )
            ],
          ),
        ],
      ),
    );
  }
}
