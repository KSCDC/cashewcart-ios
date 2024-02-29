import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/main.dart';
import 'package:internship_sample/presentation/checkout/checkout_screen.dart';
import 'package:internship_sample/presentation/cart/cart_screen.dart';
import 'package:internship_sample/presentation/home/home_screen.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/place_order/place_order_screen.dart';
import 'package:internship_sample/presentation/place_order/widgets/address_section.dart';
import 'package:internship_sample/presentation/shop/widgets/custom_styled_shop_page_button.dart';
import 'package:internship_sample/presentation/shop/widgets/custom_text_icon_button.dart';
import 'package:internship_sample/presentation/shop/widgets/review_tile.dart';
import 'package:internship_sample/presentation/shop/widgets/shop_product_details_tile.dart';
import 'package:internship_sample/presentation/widgets/custom_appbar.dart';
import 'package:internship_sample/presentation/widgets/custom_elevated_button.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/presentation/widgets/products_list_item_tile.dart';
import 'package:internship_sample/presentation/widgets/search_filter_bar.dart';
import 'package:internship_sample/presentation/widgets/sliding_product_tile.dart';

ValueNotifier<int> customerRatingNotifier = ValueNotifier(0);

class ShopScreen extends StatefulWidget {
  ShopScreen({
    super.key,
    //  this.productDetails,
  });

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final _scrollController = ScrollController();
  AppController controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    log("selected product details:${selectedProductDetails.toString()}");
    final List<String> imageList = [''];
    final String productName = selectedProductDetails!.name;
    final String description = selectedProductDetails!.description;
    // selectedProductDetails['category'][0]['description'];
    final String price = selectedProductDetails!.productVariants[0].actualPrice;
    final String offerPrice = selectedProductDetails!.productVariants[0].sellingPrice;
    final screenSize = MediaQuery.of(context).size;
    // print("previous page index $previousPageIndex");

    List similarProductsList = getSimilarProductsList();
    List relatedProductsList = getRelatedProductsList();

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            bottomNavbarIndexNotifier.value = previousPageIndexes.last;
            previousPageIndexes.removeLast();
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SlidingProductTile(
              imagePath: imageList,
              count: imageList.length,
            ),

            // product details
            ShopProductDetailsTile(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ValueListenableBuilder(
                  valueListenable: sizeSelectNotifier,
                  builder: (context, value, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // add to cart button
                        GestureDetector(
                          onTap: () {
                            int stock = selectedProductDetails!.productVariants[value].stockQty;
                            if (stock > 0) {
                              final cartProduct = {
                                'product': selectedProductDetails,
                                'category': value,
                                'count': 1,
                              };
                              if (cartProductsList.isEmpty) {
                                cartProductsList.add(cartProduct);
                              } else {
                                // log("list ->${cartProductsList.toString()}");
                                int flag = 0;
                                for (int i = 0; i < cartProductsList.length; i++) {
                                  print("working");
                                  String nameInCartProductList = cartProductsList[i]['product']['name'];
                                  String nameOfCartProduct = "";
                                  int categoryInCartProductList = cartProductsList[i]['category'];
                                  // String categoryOfCartProduct = selectedProductDetails['category'][value]['weight'];
                                  print("categories -> ${cartProductsList[i]['product']['name']} ------  ${cartProductsList[i]['category']}");
                                  if (nameInCartProductList == nameOfCartProduct && categoryInCartProductList == value) {
                                    log("item already exist :${nameInCartProductList}-${nameOfCartProduct},${categoryInCartProductList}------${value}");
                                    int count = cartProductsList[i]['count'];
                                    // print(count);
                                    cartProductsList[i]['count'] = count + 1;
                                    flag = 1;
                                    // log("count now :${item['count']}");
                                  }
                                }
                                if (flag == 0) {
                                  log("item not exist :");
                                  cartProductsList.add(cartProduct);
                                }
                              }

                              cartCountNotifier.value++;
                              const snackBar = SnackBar(
                                content: Text('Product added to cart'),
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(20),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                          },
                          child: const CustomStyledShopPageButton(
                            gradientColors: [
                              Color(0xFF3F92FF),
                              Color(0xFF0B3689),
                            ],
                            icon: Icons.shopping_cart_outlined,
                            label: "Add to cart",
                          ),
                        ),
                        kWidth,

                        // buy now button
                        GestureDetector(
                          onTap: () {
                            productCountNotifier.value = 1;
                            // int stock = selectedProductDetails!.productVariants[i].stockQty;
                            int stock = 1;
                            if (stock > 0) {
                              final buyingProduct = {
                                'product': selectedProductDetails,
                                'category': value,
                                'count': 1,
                              };
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => PlaceOrderScreen(
                                    // imagePath: imageList[0],
                                    // productName: productName,
                                    // productDescription: description,
                                    // price: selectedProductDetails['category'][value]['offerPrice'],
                                    productDetails: buyingProduct,
                                  ),
                                ),
                              );
                            }
                          },
                          child: const CustomStyledShopPageButton(
                            gradientColors: [
                              Color(0xFF71F9A9),
                              Color(0xFF31B769),
                            ],
                            icon: Icons.touch_app_outlined,
                            label: "Buy Now",
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFCCD5),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextWidget(
                            text: "Delivery",
                            fontweight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          CustomTextWidget(
                            text: "Within 4 Days",
                            fontSize: 21,
                            fontweight: FontWeight.w600,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: screenSize.width * 0.48,
                  child: CustomTextIconButton(
                    onPressed: () {},
                    icon: Icons.remove_red_eye_outlined,
                    label: "Nearest Store",
                    textAndIconColor: Colors.black,
                    textAndIconSize: 14,
                  ),
                ),
              ],
            ),
            kHeight,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CustomTextWidget(
                    text: "Ratings and Reviews",
                    fontSize: 20,
                    fontweight: FontWeight.w600,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        CustomTextWidget(
                          text: "12 Ratings and 1 review",
                          fontSize: 15,
                          fontweight: FontWeight.w600,
                        ),
                        CustomTextWidget(text: "Average rating : 4.2"),
                        kHeight,
                        Container(
                          height: 40,
                          width: 110,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey, // Set the border color
                              width: 1, // Set the border width
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: GestureDetector(
                              onTap: () async {
                                await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      insetAnimationDuration: Duration(milliseconds: 1000),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        width: screenSize.width * 0.9,
                                        height: screenSize.width * 0.8,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              ValueListenableBuilder(
                                                valueListenable: customerRatingNotifier,
                                                builder: (context, value, _) {
                                                  return RatingStars();
                                                },
                                              ),
                                              kHeight,
                                              CustomTextWidget(text: "Enter your review here"),
                                              TextField(
                                                maxLines: 4, // Set to null for an unlimited number of lines
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: CustomElevatedButton(
                                                  label: "Submit",
                                                  fontSize: 16,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: CustomTextWidget(text: "Rate Product"),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 100,
                      width: 1,
                      color: Colors.grey,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DisplayStars(
                          numberOfStars: 5,
                          rating: 8,
                        ),
                        DisplayStars(
                          numberOfStars: 4,
                          rating: 2,
                        ),
                        DisplayStars(
                          numberOfStars: 3,
                          rating: 1,
                        ),
                        DisplayStars(
                          numberOfStars: 2,
                          rating: 1,
                        ),
                        DisplayStars(
                          numberOfStars: 1,
                          rating: 0,
                        ),
                      ],
                    )
                  ],
                ),
                kHeight,
                ReviewTile(rating: 5, review: "Great quality product", reviewerName: "Pratheep Kumar"),
                ReviewTile(rating: 4, review: "Good product", reviewerName: "Arun"),
              ],
            ),
            kHeight,
            const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomTextWidget(
                text: "Similar To",
                fontSize: 20,
                fontweight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SearchFilterBar(
                heading: "${similarProductsList.length.toString()}+",
              ),
            ),

            Container(
              height: 250,
              child: Obx(
                () {
                  if (controller.valueAdded.value.count != 0) {
                    return controller.isValueAddedLoading.value
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              final productDetails = controller.valueAdded.value.results[index];

                              return GestureDetector(
                                onTap: () async {
                                  final String productId = controller.valueAdded.value.results[index].product.id.toString();
                                  // currentCategoryProducts = controller.roastedAndSalted.value;
                                  await controller.getProductDetails(productId);
                                  selectedProductDetails = controller.productDetails.value;
                                  print(selectedProductDetails!.name);

                                  previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                                  bottomNavbarIndexNotifier.value = 4;
                                },
                                child: ProductsListItemTile(
                                  productDetails: productDetails,
                                ),
                              );
                            },
                            itemCount: controller.valueAdded.value.count,
                            scrollDirection: Axis.horizontal,
                          );
                  } else {
                    return Center(
                      child: CustomTextWidget(text: "Value added products not available right now."),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomTextWidget(
                text: "ALL FEATURED PRODUCTS",
                fontSize: 18,
                fontweight: FontWeight.w600,
              ),
            ),
            Container(
              height: 250,
              child: Obx(
                () => controller.isSimilarProductsLoading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          final productDetails = controller.similarProducts.value.results[index];

                          return GestureDetector(
                            onTap: () async {
                              final String productId = controller.similarProducts.value.results[index].product.id.toString();

                              await controller.getProductDetails(productId);
                              selectedProductDetails = controller.productDetails.value;
                              print(selectedProductDetails!.name);

                              previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                              bottomNavbarIndexNotifier.value = 4;
                            },
                            child: ProductsListItemTile(
                              productDetails: productDetails,
                            ),
                          );
                        },
                        itemCount: controller.similarProducts.value.count - 1,
                        scrollDirection: Axis.horizontal,
                      ),
              ),
            ),
            kHeight,

            //related products

            const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomTextWidget(
                text: "Related To",
                fontSize: 20,
                fontweight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SearchFilterBar(
                heading: "${relatedProductsList.length.toString()}+",
              ),
            ),

            Container(
              height: 250,
              child: Obx(
                () {
                  if (controller.valueAdded.value.count != 0) {
                    return controller.isValueAddedLoading.value
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              final productDetails = controller.valueAdded.value.results[index];

                              return GestureDetector(
                                onTap: () async {
                                  final String productId = controller.valueAdded.value.results[index].product.id.toString();
                                  // currentCategoryProducts = controller.roastedAndSalted.value;
                                  await controller.getProductDetails(productId);
                                  selectedProductDetails = controller.productDetails.value;
                                  print(selectedProductDetails!.name);

                                  previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                                  bottomNavbarIndexNotifier.value = 4;
                                },
                                child: ProductsListItemTile(
                                  productDetails: productDetails,
                                ),
                              );
                            },
                            itemCount: controller.valueAdded.value.count,
                            scrollDirection: Axis.horizontal,
                          );
                  } else {
                    return Center(
                      child: CustomTextWidget(text: "Value added products not available right now."),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomTextWidget(
                text: "ALL FEATURED PRODUCTS",
                fontSize: 18,
                fontweight: FontWeight.w600,
              ),
            ),
            Container(
              height: 250,
              child: Obx(
                () => controller.isAllProductsLoading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          final productDetails = controller.allProducts.value.results[index];

                          return GestureDetector(
                            onTap: () async {
                              final String productId = controller.allProducts.value.results[index].product.id.toString();

                              await controller.getProductDetails(productId);
                              selectedProductDetails = controller.productDetails.value;
                              print(selectedProductDetails!.name);

                              previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                              bottomNavbarIndexNotifier.value = 4;
                            },
                            child: ProductsListItemTile(
                              productDetails: productDetails,
                            ),
                          );
                        },
                        itemCount: controller.allProducts.value.count,
                        scrollDirection: Axis.horizontal,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List getSimilarProductsList() {
    if (cashewsPlaneList.contains(selectedProductDetails)) {
      List productsList = List.from(cashewsPlaneList);
      productsList.remove(selectedProductDetails);
      return productsList + roastedCashewsList + valueAddedProducts;
    } else if (roastedCashewsList.contains(selectedProductDetails)) {
      List productsList = List.from(roastedCashewsList);
      productsList.remove(selectedProductDetails);
      return productsList + cashewsPlaneList + valueAddedProducts;
    } else {
      List productsList = List.from(valueAddedProducts);
      productsList.remove(selectedProductDetails);
      return productsList + cashewsPlaneList + roastedCashewsList;
    }
  }

  List getRelatedProductsList() {
    if (cashewsPlaneList.contains(selectedProductDetails)) {
      List relatedProductsList = allFeaturedProductsList.where((element) => !cashewsPlaneList.contains(element)).toList();

      return relatedProductsList;
    } else if (roastedCashewsList.contains(selectedProductDetails)) {
      List relatedProductsList = allFeaturedProductsList.where((element) => !roastedCashewsList.contains(element)).toList();

      return relatedProductsList;
    } else {
      List relatedProductsList = allFeaturedProductsList.where((element) => !valueAddedProducts.contains(element)).toList();

      return relatedProductsList;
    }
  }
}

class RatingStars extends StatelessWidget {
  RatingStars({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 1; i <= 5; i++)
          GestureDetector(
            onTap: () {
              customerRatingNotifier.value = i;
            },
            child: Icon(
              Icons.star,
              color: customerRatingNotifier.value < i ? Colors.grey : Color(0xFFF7B305),
              size: 35,
            ),
          ),
      ],
    );
  }
}

class DisplayStars extends StatelessWidget {
  const DisplayStars({
    super.key,
    required this.numberOfStars,
    required this.rating,
  });
  final int numberOfStars;
  final int rating;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 20,
          child: CustomTextWidget(
            text: rating.toString(),
          ),
        ),
        for (int i = 0; i < numberOfStars; i++)
          Icon(
            Icons.star,
            color: Color(0xFFF7B305),
            size: 18,
          ),
      ],
    );
  }
}
