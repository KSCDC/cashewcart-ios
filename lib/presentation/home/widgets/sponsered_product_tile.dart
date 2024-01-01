import 'package:flutter/material.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class SponseredProductTile extends StatelessWidget {
  const SponseredProductTile({super.key});

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
          Container(
            width: screenSize.width * 0.95,
            height: screenSize.width * 0.8,
            // color: Colors.black,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/core/assets/images/product_images/home/sponserd.jpg"),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextWidget(
                text: "up to 50% Off",
                fontSize: 16,
                fontweight: FontWeight.w700,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_forward_ios),
              )
            ],
          )
        ],
      ),
    );

    //
    // Container(
    //   padding: EdgeInsets.all(5),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       CustomTextWidget(
    //         text: "Sponserd",
    //         fontSize: 20,
    //         fontweight: FontWeight.w500,
    //       ),
    //       Container(
    //         clipBehavior: Clip.hardEdge,
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(10),
    //         ),
    //         child: FittedBox(
    //           child: Image.asset(
    //             "lib/core/assets/images/product_images/home/sponserd.jpg",
    //           ),
    //           fit: BoxFit.fill,
    //         ),
    //       ),
    //       SizedBox(height: 10),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           CustomTextWidget(
    //             text: "up to 50% Off",
    //             fontSize: 16,
    //             fontweight: FontWeight.w700,
    //           ),
    //           IconButton(
    //             onPressed: () {},
    //             icon: Icon(Icons.arrow_forward_ios),
    //           )
    //         ],
    //       )
    //     ],
    //   ),
    // );
  }
}
