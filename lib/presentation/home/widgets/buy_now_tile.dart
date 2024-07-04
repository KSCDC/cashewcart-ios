import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:cashew_cart/controllers/app_controller.dart';
import 'package:cashew_cart/core/base_url.dart';
import 'package:cashew_cart/core/colors.dart';
import 'package:cashew_cart/core/constants.dart';
import 'package:cashew_cart/main.dart';
import 'package:cashew_cart/models/product_model.dart';
import 'package:cashew_cart/presentation/home/home_screen.dart';
import 'package:cashew_cart/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:cashew_cart/presentation/shop/shop_screen.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';
import 'package:cashew_cart/services/services.dart';

class BuyNowTile extends StatelessWidget {
  BuyNowTile({
    super.key,
    required this.productDetails,
  });
  final List<ProductModel> productDetails;
  AppController controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    String imagePath = '';
    String productName = '';
    String productDescription = '';
    if (productDetails.isNotEmpty) {
      imagePath = productDetails[0].product.productImages.isNotEmpty
          ? "${productDetails[0].product.productImages[0].productImage}"
          : "https://t3.ftcdn.net/jpg/05/04/28/96/240_F_504289605_zehJiK0tCuZLP2MdfFBpcJdOVxKLnXg1.jpg";
      productName = productDetails[0].product.name;
      productDescription = productDetails[0].product.description;
    }

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
                image: AssetImage("lib/core/assets/images/home/yellow_bar.jpg"),
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

                child: SvgPicture.asset("lib/core/assets/images/home/star_bg.svg"),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: 130,
                  height: 150,
                  // color: Colors.black,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("$baseUrl$imagePath"),
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
              SizedBox(
                width: 210,
                child: CustomTextWidget(
                  text: productName,
                  fontSize: 16,
                  fontweight: FontWeight.w500,
                ),
              ),
              kHeight,
              SizedBox(
                width: 200,
                child: CustomTextWidget(
                  text: productDescription,
                  fontSize: 10,
                  fontweight: FontWeight.w400,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextButton(
                  onPressed: () async {
                    final String productId = productDetails[0].product.productId.toString();
                    Services().getProductDetailsAndGotoShopScreen(context, productId);
                    // await controller.getProductDetails(productId);
                    // controller.getProductReviews(productId);
                    // controller.productDetailsList.add(controller.productDetails.value!);
                    // previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                    // bottomNavbarIndexNotifier.value = 4;
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
