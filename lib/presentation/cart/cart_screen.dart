import 'package:flutter/material.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/main.dart';
import 'package:internship_sample/presentation/cart/widgets/cart_product_list_tile.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/place_order/multiple_item_place_order_screen.dart';
import 'package:internship_sample/presentation/widgets/custom_appbar.dart';
import 'package:internship_sample/presentation/widgets/custom_elevated_button.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

List cartProductsList = [];
ValueNotifier<double> grantTotalNotifier = ValueNotifier(0);

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double grandTotal = getGrandTotal();
    final screenSize = MediaQuery.of(context).size;
    grantTotalNotifier.value = 0;

    print("building");
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            bottomNavbarIndexNotifier.value = previousPageIndexes.last;
            if (previousPageIndexes.length > 1) {
              previousPageIndexes.removeLast();
            }
          },
          child: Icon(Icons.arrow_back_ios_rounded),
        ),
        centerTitle: true,
        title: CustomTextWidget(
          text: "Cart",
          fontSize: 18,
          fontweight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kHeight,
              const CustomTextWidget(
                text: "Shopping List",
                fontweight: FontWeight.w600,
              ),
              kHeight,
              if (cartProductsList.isEmpty)
                Center(
                  child: CustomTextWidget(
                    text: "You dont have any items in your kart",
                    fontSize: 16,
                  ),
                ),
              Container(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        kHeight,
                        CartProductsListTile(
                          productDetails: cartProductsList[index],
                          // callSetState: callSetState,
                        ),
                      ],
                    );
                  },
                  itemCount: cartProductsList.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                ),
              ),
              kHeight,
              if (cartProductsList.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomTextWidget(
                      text: "Grant Total : ",
                      fontweight: FontWeight.w600,
                    ),
                    CustomTextWidget(
                      text: grandTotal.toStringAsFixed(2),
                      fontweight: FontWeight.w600,
                    )
                  ],
                ),
              kHeight,
              if (cartProductsList.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    if (grandTotal <= 500) {
                      const snackBar = SnackBar(
                        content: Text('Minimum order amount is Rs 500 and above'),
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(20),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MultipleItemPlaceOrderScreen(productList: cartProductsList),
                        ),
                      );
                    }
                  },
                  child: CustomElevatedButton(
                    label: "Buy Now",
                    fontSize: 16,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  double getGrandTotal() {
    double grandTotal = 0;
    print("grand total fn");
    for (int i = 0; i < cartProductsList.length; i++) {
      final int selectedCategory = cartProductsList[i]['category'];
      final String price = cartProductsList[i]['product']['category'][selectedCategory]['offerPrice'];
      final int count = cartProductsList[i]['count'];
      final double total = double.parse(price) * count;
      print("prices are ${price} * ${count}== ${total}");
      grandTotal = grandTotal + total;
    }
    return grandTotal;
  }
}
