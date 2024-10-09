import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cashew_cart/controllers/app_controller.dart';
import 'package:cashew_cart/core/colors.dart';
import 'package:cashew_cart/core/constants.dart';
import 'package:cashew_cart/main.dart';
import 'package:cashew_cart/presentation/home/home_screen.dart';
import 'package:cashew_cart/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';

class SponseredProductTile extends StatelessWidget {
  SponseredProductTile({
    super.key,
    required this.imagePath,
  });
  final String imagePath;
  AppController controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextWidget(
            text: "Sponserd",
            fontSize: 20,
            fontweight: FontWeight.w500,
          ),
          SizedBox(height: 10),
          Stack(
            children: [
              Container(
                width: screenSize.width * 0.95,
                height: screenSize.width * 0.8,
                // color: Colors.black,
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
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     CustomTextWidget(
          //       text: "up to 50% Off",
          //       fontSize: 16,
          //       fontweight: FontWeight.w700,
          //     ),
          //     IconButton(
          //       onPressed: () {
          //         controller.productDisplayList2 = controller.sponserd;
          //         currentDisplayProductCategory = "Sponserd";
          //         print("sponserd : ${controller.productDisplayList2.value.count}");
          //         previousPageIndexes.add(bottomNavbarIndexNotifier.value);
          //         bottomNavbarIndexNotifier.value = 9;
          //       },
          //       icon: Icon(Icons.arrow_forward_ios),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}
