import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constatns.dart';
import 'package:internship_sample/presentation/cart/widgets/cart_product_list_tile.dart';
import 'package:internship_sample/presentation/home/home_screen.dart';
import 'package:internship_sample/presentation/place_order/multiple_item_place_order_screen.dart';
import 'package:internship_sample/presentation/widgets/custom_appbar.dart';
import 'package:internship_sample/presentation/widgets/custom_elevated_button.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

List cartProductsList = [];
ValueNotifier<double> grantTotalNotifier = ValueNotifier(0);
ValueNotifier<bool> isAddressEditableNotifier = ValueNotifier(false);

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _textEditingController = TextEditingController(text: "216 St Paul's Rd, London N1 2LL, UK, \nContact :  +44-784232 ");
    double grandTotal = getGrandTotal();
    final screenSize = MediaQuery.of(context).size;
    grantTotalNotifier.value = 0;
    // print("cart product item :${cartProductsList[0]['weight']}");
    //
    print("building");
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
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
              const Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 15,
                  ),
                  kWidth,
                  CustomTextWidget(
                    text: "Delivery Address",
                    fontweight: FontWeight.w600,
                  ),
                ],
              ),
              kHeight,
              ValueListenableBuilder(
                  valueListenable: isAddressEditableNotifier,
                  builder: (context, value, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: screenSize.width * 0.32,
                          width: screenSize.width * 0.8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextWidget(
                                      text: "Address :",
                                      fontSize: 12,
                                      fontweight: FontWeight.w500,
                                    ),
                                    kHeight,
                                    TextField(
                                      controller: _textEditingController,
                                      style: TextStyle(fontSize: 14),
                                      maxLines: 2,
                                      enabled: value,
                                      decoration: InputDecoration(
                                        border: value ? OutlineInputBorder() : InputBorder.none,
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: -5,
                                  right: -2,
                                  child: GestureDetector(
                                    onTap: () {
                                      isAddressEditableNotifier.value = true;
                                    },
                                    child: Icon(Icons.edit_note_rounded),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (value)
                          GestureDetector(
                            onTap: () {
                              isAddressEditableNotifier.value = false;
                            },
                            child: Container(
                              height: screenSize.width * 0.1,
                              width: screenSize.width * 0.1,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.done_rounded,
                                ),
                              ),
                            ),
                          )
                      ],
                    );
                  }),
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
                    // final int selectedCategory = cartProductsList[index]['category'];
                    // final String price = cartProductsList[index]['product']['category'][selectedCategory]['offerPrice'];
                    // final int count = cartProductsList[index]['count'];
                    // final double total = double.parse(price) * count;
                    // print("prices are ${price} * ${count}== ${total}");
                    // grantTotalNotifier.value = grantTotalNotifier.value + total;
                    return Column(
                      children: [
                        kHeight,
                        CartProductsListTile(
                          productDetails: cartProductsList[index],
                          callSetState: callSetState,
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

  getGrandTotal() {
    double grandTotal = 0;
    log("grand total fn");
    for (int i = 0; i < cartProductsList.length; i++) {
      final int selectedCategory = cartProductsList[i]['category'];
      final String price = cartProductsList[i]['product']['category'][selectedCategory]['offerPrice'];
      final int count = cartProductsList[i]['count'];
      final double total = double.parse(price) * count;
      print("prices are ${price} * ${count}== ${total}");
      grandTotal = grandTotal + total;
    }
    // log("GTOT:${grantTotalNotifier.value}");
    return grandTotal;
  }

  callSetState() {
    setState(() {});
  }
}
