import 'package:flutter/material.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/presentation/shop/shop_screen.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class BuyNowTile extends StatelessWidget {
  const BuyNowTile({
    super.key,
    required this.imagePath,
    required this.productName,
    required this.productDescription, required this.price,
  });
  final String imagePath;
  final String productName;
  final String productDescription;
  final String price;

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
                      image: AssetImage(imagePath),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextWidget(
                text: productName,
                fontSize: 16,
                fontweight: FontWeight.w500,
              ),
              CustomTextWidget(
                text: productDescription,
                fontSize: 10,
                fontweight: FontWeight.w400,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ShopScreen(
                          imageList: [imagePath],
                          productName: productName,
                          description: productDescription,
                          price: price,
                        ),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: kMainThemeColor,
                    side: BorderSide(width: 1, color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Container(
                    child: Row(
                      children: [
                        CustomTextWidget(
                          text: "Buy Now",
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
