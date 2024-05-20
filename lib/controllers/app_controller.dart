import 'dart:convert';
import 'dart:developer';

import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/models/cart_product_model.dart';
import 'package:internship_sample/models/orders_list_model.dart';
import 'package:internship_sample/models/product_details_model.dart';
import 'package:internship_sample/models/product_model.dart';
import 'package:internship_sample/models/product_reviews_model.dart';
import 'package:internship_sample/models/trending_product_model.dart';
import 'package:internship_sample/models/user_address_model.dart';
import 'package:internship_sample/presentation/main_page/main_page_screen.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppController extends GetxController {
  String userName = "";
  String email = "";
  String phoneNo = "";
  String? state = null;
  String? district = null;
  int numOf1Stars = 0;
  int numOf2Stars = 0;
  int numOf3Stars = 0;
  int numOf4Stars = 0;
  int numOf5Stars = 0;
  final key = enc.Key.fromLength(32);
  final iv = enc.IV.fromLength(8);

  RxDouble avgRating = 0.0.obs;
  RxInt minSearchPrice = 0.obs;
  RxInt maxSearchPrice = 5000.obs;
  // String selectedProductId = "";
  RxBool isLoading = false.obs;
  RxBool isLoadingProfile = false.obs;
  RxBool isError = false.obs;
  RxBool isMyOrdersError = false.obs;
  RxBool isLoadingCart = false.obs;
  RxBool isLoadingMyproducts = false.obs;
  RxBool isAllProductsLoading = false.obs;
  RxBool isCircleAvatarProductsLoading = false.obs;
  RxBool isPlainCashewLoading = false.obs;
  RxBool isRoastedAndSaltedLoading = false.obs;
  RxBool isValueAddedLoading = false.obs;
  RxBool isSimilarProductsLoading = false.obs;
  RxBool isRelatedProductsLoading = false.obs;
  RxBool isBestSellersLoading = false.obs;
  RxBool isSponserdLoading = false.obs;
  RxBool isTrendingLoading = false.obs;
  RxBool isReviewsLoading = false.obs;
  RxBool isDisplayingTrendingModelList = false.obs;
  RxBool isLoadingAddress = false.obs;
  RxBool isAllProductsLoadingError = false.obs;
  RxBool isPlainCashewLoadingError = false.obs;
  RxBool isRoastedAndSaltedLoadingError = false.obs;
  RxBool isValueAddedLoadingError = false.obs;
  RxBool isSimilarProductsLoadingError = false.obs;
  RxBool isRelatedProductsLoadingError = false.obs;
  RxBool isBestSellersLoadingError = false.obs;
  RxBool isSponserdLoadingError = false.obs;
  RxBool isTrendingLoadingError = false.obs;
  RxBool isReviewsLoadingError = false.obs;
  RxBool isDisplayingTrendingModelListError = false.obs;
  RxBool isLoadingAddressError = false.obs;
  RxBool isSearchProductError = false.obs;
  RxBool sortProduct = false.obs;
  RxBool sortAscending = false.obs;

  RxString dropdownValue = 'Default'.obs;
  RxList<ProductModel> allProducts = <ProductModel>[].obs;
  RxList<ProductModel> circleAvatarProductsList = <ProductModel>[].obs;
  RxList<ProductModel> plainCashews = <ProductModel>[].obs;
  RxList<ProductModel> roastedAndSalted = <ProductModel>[].obs;
  RxList<TrendingProductModel> bestSellers = <TrendingProductModel>[].obs;
  RxList<TrendingProductModel> trending = <TrendingProductModel>[].obs;
  RxList<TrendingProductModel> sponserd = <TrendingProductModel>[].obs;
  RxList<ProductModel> valueAdded = <ProductModel>[].obs;
  RxList<ProductModel> similarProducts = <ProductModel>[].obs;
  RxList<ProductModel> relatedProducts = <ProductModel>[].obs;
  RxList<ProductModel> productDisplayList = <ProductModel>[].obs;
  RxList<TrendingProductModel> productDisplayList2 = <TrendingProductModel>[].obs;
  Rx<CartProductModel> cartProducts = CartProductModel(count: 0, next: null, previous: null, results: []).obs;
  RxList<ProductModel> searchResults = <ProductModel>[].obs;
  RxList<OrdersListModel> ordersList = <OrdersListModel>[].obs;
  var sortedSearchList;
  RxBool haveSearchResult = false.obs;

  Rxn<ProductDetailsModel> productDetails = Rxn<ProductDetailsModel>();
  // Rxn<ProductReviewsModel> productReviews = Rxn<ProductReviewsModel>();
  RxList<ProductReviewsModel> productReviewsList = <ProductReviewsModel>[].obs;
  RxList<UserAddressModel> addressList = <UserAddressModel>[].obs;

  RxList<ProductDetailsModel> productDetailsList = <ProductDetailsModel>[].obs;
  RxList<ProductModel> slidingProductsList = <ProductModel>[].obs;

  bool isAlreadyLoadedAllProducts = false;
  bool isAlreadyLoadedcircleAvatarProducts = false;
  bool isAlreadyLoadedPlainCashews = false;
  bool isAlreadyLoadedRoastedAndSaltedCashews = false;
  bool isAlreadyLoadedValueAdded = false;
  bool isAlreadyLoadedTrending = false;
  bool isAlreadyLoadedBestsellers = false;
  bool isAlreadyLoadedSponserd = false;

  RxList<String> plainCashewSubCategories = ["All"].obs;
  RxString selectedPlainCashewCategory = "All".obs;
  RxList<String> roastedAndSaltedSubCategories = ["All"].obs;
  RxString selectedRoastedAndSaltedCategory = "All".obs;
  RxList<String> valueAddedSubCategories = ["All"].obs;
  RxString selectedValueAddedCategory = "All".obs;

  // These page nos was used for implementing pagination. Later the pagination was removed

  int allProductsPageNo = 1;
  int trendingProductsPageNo = 1;
  int sponserdProductsPageNo = 1;
  int bestSellersPageNo = 1;
  int plainCashewsPageNo = 1;
  int roastedAndSaltedPageNo = 1;
  int valueAddedPageNo = 1;
  int searchResultPageNo = 1;
  int ordersListPageNo = 1;

  registerNewUser(BuildContext context, String token, String name, String phoneNumber, String password) async {
    isLoading.value = true;
    final response = await ApiServices().registerUser(context, token, name, phoneNumber, password);
    if (response == null) {
      isLoading.value = false;
    } else {
      final accessToken = response.data['token']['access'];
      final refreshToken = response.data['token']['refresh'];
      print("access token :$accessToken\nrefresh token :$refreshToken");
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      sharedPref.setString(ACCESSTOKEN, accessToken);
      sharedPref.setString(REFRESHTOKEN, refreshToken);

      final keyString = base64.encode(key.bytes);
      final ivString = base64.encode(iv.bytes);
      await sharedPref.setString('ENCRYPTION_KEY', keyString);
      await sharedPref.setString('ENCRYPTION_IV', ivString);
      final encrypter = enc.Encrypter(enc.AES(key));
      final encrypted = encrypter.encrypt(password, iv: iv);

      final encryptedBase64 = base64.encode(encrypted.bytes);

      await sharedPref.setString(EMAIL, email);
      await sharedPref.setString(ENCRYPTEDPASSWORD, encryptedBase64);
      print("Encrypted:$encryptedBase64");
      isLoading.value = false;
      Get.offAll(() => MainPageScreen());
    }
  }

  loginUser(BuildContext context, String email, String password) async {
    isLoading.value = true;
    final response = await ApiServices().loginUser(context, email, password);

    if (response != null) {
      // log(response.data.toString());
      final accessToken = response.data['token']['access'];
      final refreshToken = response.data['token']['refresh'];
      print("access token :$accessToken\nrefresh token :$refreshToken");
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      sharedPref.setString(ACCESSTOKEN, accessToken);
      sharedPref.setString(REFRESHTOKEN, refreshToken);

      //converting key and iv to string for storingg in shared preferences
      final keyString = base64.encode(key.bytes);
      final ivString = base64.encode(iv.bytes);
      await sharedPref.setString('ENCRYPTION_KEY', keyString);
      await sharedPref.setString('ENCRYPTION_IV', ivString);
      final encrypter = enc.Encrypter(enc.AES(key));
      final encrypted = encrypter.encrypt(password, iv: iv);

      final encryptedBase64 = base64.encode(encrypted.bytes);
      await sharedPref.setString(EMAIL, email);
      await sharedPref.setString(ENCRYPTEDPASSWORD, encryptedBase64);
      print("Encrypted:$encryptedBase64");

      Get.offAll(() => MainPageScreen());
    }
    isLoading.value = false;
  }

  getAllProducts() async {
    isAllProductsLoading.value = true;
    final response = await ApiServices().getAllProducts(allProductsPageNo.toString());
    if (response != null) {
      final List<dynamic> responseData = response.data;
      final List<ProductModel> productList = responseData.map((productData) => ProductModel.fromJson(productData)).toList();
      allProducts.clear;

      final Set<String> uniqueProductNames = {};

      final List<ProductModel> newProductList = productList.where((product) {
        final isUnique = uniqueProductNames.add(product.product.name);
        return isUnique;
      }).toList();
      slidingProductsList.value = newProductList.where((item) {
        return item.product.newProduct == true;
      }).toList();
      log("Length of productList :${productList.length}");
      log("Length of sliding :${slidingProductsList.length}");
      log("Length of temp :${newProductList.length}");
      print(productList[0].product.name);
      // allProducts.value = productList;
      allProducts.value = newProductList.reversed.toList();

      // productList.shuffle();

      isAlreadyLoadedAllProducts = true;
    } else {
      isAllProductsLoadingError.value = true;
    }

    isAllProductsLoading.value = false;
  }

  getCircleAvatarProductList() async {
    log("Getting circle list");
    circleAvatarProductsList.clear();
    if (!isAlreadyLoadedPlainCashews) {
      await getProductsByCategory("PLAIN CASHEWS", "");
      log("loaded plain");
    }
    if (!isAlreadyLoadedRoastedAndSaltedCashews) {
      await getProductsByCategory("ROASTED AND SALTED CASHEWS", "");
    }
    if (!isAlreadyLoadedValueAdded) {
      await getProductsByCategory("VALUE ADDED CASHEW PRODUCTS", "");
    }
    if (plainCashews.isNotEmpty) {
      circleAvatarProductsList.add(plainCashews[0]);
    }
    if (roastedAndSalted.isNotEmpty) {
      circleAvatarProductsList.add(roastedAndSalted[0]);
    }
    if (valueAdded.isNotEmpty) {
      circleAvatarProductsList.addAll(valueAdded);
    }

    log("circle list :${circleAvatarProductsList}");
  }

  getTrendingProducts() async {
    log("getting trending");
    isTrendingLoading.value = true;
    isTrendingLoadingError.value = false;
    final response = await ApiServices().getTrendingProducts(trendingProductsPageNo.toString());
    // log("trending: ${response.data}");
    if (response != null) {
      print("response not null");
      final List<dynamic> responseData = response.data;
      final List<TrendingProductModel> productList = responseData.map((productData) => TrendingProductModel.fromJson(productData)).toList();
      final Set<String> uniqueProductNames = {};

      final List<TrendingProductModel> newProductList = productList.where((product) {
        final isUnique = uniqueProductNames.add(product.product.name);
        return isUnique;
      }).toList();
      trending.value = newProductList.reversed.toList();
      log("trending products:${trending.value}");

      isAlreadyLoadedTrending = true;
    } else {
      isTrendingLoadingError.value = true;
    }

    print("best sellers :${bestSellers}");
    isTrendingLoading.value = false;
  }

  getBestSellerProducts() async {
    isBestSellersLoading.value = true;
    isBestSellersLoading.value = false;
    final response = await ApiServices().getBestSellerProducts(bestSellersPageNo.toString());
    if (response != null) {
      final List<dynamic> responseData = response.data;
      final List<TrendingProductModel> productList = responseData.map((productData) => TrendingProductModel.fromJson(productData)).toList();
      final Set<String> uniqueProductNames = {};

      final List<TrendingProductModel> newProductList = productList.where((product) {
        final isUnique = uniqueProductNames.add(product.product.name);
        return isUnique;
      }).toList();
      bestSellers.value = newProductList.reversed.toList();
    }
    print("best sellers :${bestSellers}");
    isBestSellersLoading.value = false;
  }

  getSponserdProducts() async {
    print("Getting sponserd products");
    isSponserdLoading.value = true;
    isSponserdLoadingError.value = false;
    final response = await ApiServices().getSponserdProducts(sponserdProductsPageNo.toString());
    if (response != null) {
      final List<dynamic> responseData = response.data;
      final List<TrendingProductModel> productList = responseData.map((productData) => TrendingProductModel.fromJson(productData)).toList();
      final Set<String> uniqueProductNames = {};

      final List<TrendingProductModel> newProductList = productList.where((product) {
        final isUnique = uniqueProductNames.add(product.product.name);
        return isUnique;
      }).toList();
      sponserd.value = newProductList.reversed.toList();
    }
    isSponserdLoading.value = false;
  }

  getProductsByCategory(String category, String categoryName) async {
    // log("getting plain");
    final response = await ApiServices().getProductByCategory(category, categoryName, plainCashewsPageNo.toString());
    log(response.data.toString());
    if (category == "PLAIN CASHEWS") {
      isPlainCashewLoading.value = true;
      isPlainCashewLoadingError.value = false;
      // log("storing plained");
      print(response.data);
      if (response != null) {
        final List<dynamic> responseData = response.data;
        final List<ProductModel> productList = responseData.map((productData) => ProductModel.fromJson(productData)).toList();
        final Set<String> uniqueProductNames = {};

        final List<ProductModel> newProductList = productList.where((product) {
          final isUnique = uniqueProductNames.add(product.product.name);
          return isUnique;
        }).toList();
        plainCashews.value = newProductList.reversed.toList();
        for (int i = 0; i < productList.length; i++) {
          final categoryName = productList[i].product.category.name;
          if (!plainCashewSubCategories.contains(categoryName)) {
            plainCashewSubCategories.add(categoryName);
          }
        }
        // }

        print("Categories in roasted :$plainCashewSubCategories");
        isAlreadyLoadedPlainCashews = true;
        //log("plain cas : ${plainCashews.value}");
      } else {
        isPlainCashewLoadingError.value = true;
      }

      isPlainCashewLoading.value = false;
    } else if (category == "ROASTED AND SALTED CASHEWS") {
      isRoastedAndSaltedLoading.value = true;
      isRoastedAndSaltedLoadingError.value = false;
      // final response = await ApiServices().getProductByCategory(category, categoryName, roastedAndSaltedPageNo.toString());
      print("storing roasted");

      if (response != null) {
        final List<dynamic> responseData = response.data;
        final List<ProductModel> productList = responseData.map((productData) => ProductModel.fromJson(productData)).toList();
        final Set<String> uniqueProductNames = {};

        final List<ProductModel> newProductList = productList.where((product) {
          final isUnique = uniqueProductNames.add(product.product.name);
          return isUnique;
        }).toList();
        roastedAndSalted.value = newProductList.reversed.toList();

        for (int i = 0; i < productList.length; i++) {
          final categoryName = productList[i].product.category.name;
          if (!roastedAndSaltedSubCategories.contains(categoryName)) {
            roastedAndSaltedSubCategories.add(categoryName);
          }
        }

        isAlreadyLoadedRoastedAndSaltedCashews = true;
      } else {
        isRoastedAndSaltedLoadingError.value = true;
      }

      isRoastedAndSaltedLoading.value = false;
    } else if (category == "VALUE ADDED CASHEW PRODUCTS") {
      isValueAddedLoading.value = true;
      isValueAddedLoadingError.value = false;
      // final response = await ApiServices().getProductByCategory(category, categoryName, valueAddedPageNo.toString());
      if (response != null) {
        final List<dynamic> responseData = response.data;
        final List<ProductModel> productList = responseData.map((productData) => ProductModel.fromJson(productData)).toList();
        final Set<String> uniqueProductNames = {};

        final List<ProductModel> newProductList = productList.where((product) {
          final isUnique = uniqueProductNames.add(product.product.name);
          return isUnique;
        }).toList();
        valueAdded.value = newProductList.reversed.toList();

        for (int i = 0; i < productList.length; i++) {
          final categoryName = productList[i].product.category.name;
          if (!valueAddedSubCategories.contains(categoryName)) {
            valueAddedSubCategories.add(categoryName);
          }
        }

        isAlreadyLoadedValueAdded = true;
      } else {
        isValueAddedLoadingError.value = true;
      }

      isValueAddedLoading.value = false;
    }
  }

  searchProducts(String searchKey) async {
    print("Search key: $searchKey");
    isLoading.value = true;
    haveSearchResult.value = false;
    // searchResults.value.results = [];
    final response = await ApiServices().searchProduct(searchKey, minSearchPrice.value, maxSearchPrice.value, searchResultPageNo.toString());

    if (response != null) {
      final List<dynamic> responseData = response.data;
      final List<ProductModel> productList = responseData.map((productData) => ProductModel.fromJson(productData)).toList();
      final Set<String> uniqueProductNames = {};

      final List<ProductModel> newProductList = productList.where((product) {
        final isUnique = uniqueProductNames.add(product.product.name);
        return isUnique;
      }).toList();
      searchResults.value = newProductList.reversed.toList();
      if (sortProduct.value) {
        if (sortAscending.value) {
          searchResults.sort((a, b) => double.parse(a.sellingPrice).compareTo(double.parse(b.sellingPrice)));
        } else {
          searchResults.sort((a, b) => double.parse(b.sellingPrice).compareTo(double.parse(a.sellingPrice)));
        }
      }

      haveSearchResult.value = true;
    } else {
      haveSearchResult.value = false;
    }

    isLoading.value = false;
  }

  getProductDetails(String id) async {
    isLoading.value = true;
    isError.value = false;
    final response = await ApiServices().getProductDetails(id);
    if (response != null) {
      final data = await ProductDetailsModel.fromJson(response.data);
      productDetails.value = data;
      isAlreadyLoadedAllProducts = true;
    } else {
      isError.value = true;
    }
    isLoading.value = false;
    return productDetails.value;
  }

  getProductReviews(String productId) async {
    isReviewsLoading.value = true;
    isReviewsLoadingError.value = false;
    productReviewsList.clear();
    final List<ProductReviewsModel> tempList = [];
    final response = await ApiServices().getProductReviews(productId);
    final avgRatingResponse = await ApiServices().getAverageStarRatings(productId);
    if (avgRatingResponse != null) {
      print("avg ratings :${avgRatingResponse.data['average_rating']}");
      avgRating.value = avgRatingResponse.data['average_rating'].toDouble();
    }
    if (response != null) {
      final List<dynamic> responseData = response.data;
      numOf1Stars = 0;
      numOf2Stars = 0;
      numOf3Stars = 0;
      numOf4Stars = 0;
      numOf5Stars = 0;
      for (final item in responseData) {
        final review = ProductReviewsModel.fromJson(item);
        tempList.add(review);
        switch (review.stars) {
          case 1:
            numOf1Stars++;
            break;
          case 2:
            numOf2Stars++;
            break;
          case 3:
            numOf3Stars++;
            break;
          case 4:
            numOf4Stars++;
            break;
          case 5:
            numOf5Stars++;
            break;
          default:
            print('Invalid number of stars');
        }
      }

      productReviewsList.value = tempList;

      // productReviews.value = productReviewsList;
    } else {
      isReviewsLoadingError.value = true;
    }

    isReviewsLoading.value = false;
  }

  addProductReview(BuildContext context, String productId, String reviewText, int numberOfStars) async {
    final List<ProductReviewsModel> tempList = [];
    final response = await ApiServices().addProductReview(context, productId, reviewText, numberOfStars);

    if (response != null) {
      // final review = ProductReviewsModel.fromJson(item);
      getProductReviews(productId);
    }
  }

  getSimilarProducts(String productName, String productParentName) {
    similarProducts.clear();
    for (var item in allProducts) {
      if (item.product.category.parentName == productParentName && item.product.name != productName) {
        log("${item.product.name} == ${productName}");
        similarProducts.add(item);
      }
    }
    log("Similar products count : ${similarProducts.length}");
  }

  getProfileDetails() async {
    isLoadingProfile.value = true;
    isError.value = false;
    final response = await ApiServices().getProfileDetails();
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    if (response != null) {
      userName = response.data['name'];
      email = response.data['email'];
      phoneNo = response.data['phone_number'];
      sharedPref.setString(PHONE, phoneNo);
    } else {
      isError.value = true;
    }

    print(userName);
    isLoadingProfile.value = false;
  }

  getCartList() async {
    isLoadingCart.value = true;
    isError.value = false;
    final response = await ApiServices().getCartList();
    if (response != null) {
      final data = CartProductModel.fromJson(response.data);
      // log(response.data.toString());
      cartProducts.value = data;
      cartCountNotifier.value = data.count;
    } else {
      isError.value = true;
    }

    isLoadingCart.value = false;
  }

  addProductToCart(BuildContext context, String productId) async {
    // isLoading.value = true;
    isError.value = false;
    final response = await ApiServices().addProductToCart(context, productId);
    if (response == null) {
      isError.value = true;
    }
    // isLoading.value = true;
  }

  removeProductFromCart(BuildContext context, String productId) async {
    isLoading.value = true;
    isError.value = false;
    final response = await ApiServices().removeFromCart(context, productId);
    if (response == null) {
      isError.value = true;
    } else {
      getCartList();
    }
    isLoading.value = false;
  }

  getUserAddresses() async {
    print("getting addresses");
    isLoadingAddress.value = true;
    isLoadingAddressError.value = false;
    productReviewsList.clear();
    final List<UserAddressModel> tempList = [];
    final response = await ApiServices().getUserAddresses();

    if (response != null) {
      final List<dynamic> responseData = response.data;
      print(responseData);
      for (final item in responseData) {
        final address = UserAddressModel.fromJson(item);
        tempList.add(address);
      }

      addressList.value = tempList;
      state = addressList[0].state;
      district = addressList[0].district;
    } else {
      isLoadingAddressError.value = true;
    }

    isLoadingAddress.value = false;
  }

  createOrder(String shippingAddressId, String billingAddressId) async {
    final response = await ApiServices().placeOrder(shippingAddressId, billingAddressId);
    print(response.data.toString());
  }

  getOrdersList() async {
    isLoadingMyproducts.value = true;
    isMyOrdersError.value = false;
    log("my orders loading");
    final response = await ApiServices().getOrdersList(ordersListPageNo.toString());

    if (response != null) {
      final List<dynamic> responseData = response.data;
      final List<OrdersListModel> productList = responseData.map((productData) => OrdersListModel.fromJson(productData)).toList();
      log("orders count :${productList.length}");
      ordersList.value = productList;
    } else {
      isMyOrdersError.value = true;
    }
    isLoadingMyproducts.value = false;
  }
}
