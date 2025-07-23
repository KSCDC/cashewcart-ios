import 'dart:convert';
import 'dart:developer';

import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cashew_cart/core/constants.dart';
import 'package:cashew_cart/models/cart_product_model.dart';
import 'package:cashew_cart/models/orders_list_model.dart';
import 'package:cashew_cart/models/product_details_model.dart';
import 'package:cashew_cart/models/product_model.dart';
import 'package:cashew_cart/models/product_reviews_model.dart';
import 'package:cashew_cart/models/trending_product_model.dart';
import 'package:cashew_cart/models/user_address_model.dart';
import 'package:cashew_cart/presentation/main_page/main_page_screen.dart';
import 'package:cashew_cart/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:cashew_cart/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppController extends GetxController {
  String userName = "";
  String email = "";
  String phoneNo = "";
  RxInt currentSlideNumber = 0.obs;

  RxBool isLoggedIn = false.obs;

  final key = enc.Key.fromLength(32);
  final iv = enc.IV.fromLength(8);

  int mainPageIndex = 0;

  // String selectedProductId = "";
  RxBool isLoading = false.obs;

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

  RxBool isDisplayingTrendingModelList = false.obs;

  RxBool isAllProductsLoadingError = false.obs;
  RxBool isPlainCashewLoadingError = false.obs;
  RxBool isRoastedAndSaltedLoadingError = false.obs;
  RxBool isValueAddedLoadingError = false.obs;
  RxBool isSimilarProductsLoadingError = false.obs;
  RxBool isRelatedProductsLoadingError = false.obs;
  RxBool isBestSellersLoadingError = false.obs;
  RxBool isSponserdLoadingError = false.obs;
  RxBool isTrendingLoadingError = false.obs;
  RxBool isDisplayingTrendingModelListError = false.obs;

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
  RxList<TrendingProductModel> productDisplayList2 =
      <TrendingProductModel>[].obs;

  RxList<OrdersListModel> ordersList = <OrdersListModel>[].obs;
  var sortedSearchList;

  // Rxn<ProductReviewsModel> productReviews = Rxn<ProductReviewsModel>();

  RxList<ProductDetailsModel> productDetailsList = <ProductDetailsModel>[].obs;
  RxList<ProductModel> slidingProductsList = <ProductModel>[].obs;

  RxBool isAlreadyLoadedAllProducts = false.obs;
  bool isAlreadyLoadedcircleAvatarProducts = false;
  RxBool isAlreadyLoadedPlainCashews = false.obs;
  RxBool isAlreadyLoadedRoastedAndSaltedCashews = false.obs;
  RxBool isAlreadyLoadedValueAdded = false.obs;
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

  int ordersListPageNo = 1;

  registerNewUser(BuildContext context, String token, String name,
      String phoneNumber, String password) async {
    isLoading.value = true;
    final response = await ApiServices()
        .registerUser(context, token, name, phoneNumber, password);
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

  Future<bool> loginUser(BuildContext context, String email, String password,
      {bool loginAfterResettingPassword = false}) async {
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
      isLoading.value = false;
      return true;
    } else {
      isLoading.value = false;
      return false;
    }
  }

  getAllProducts() async {
    isAllProductsLoading.value = true;
    final response =
        await ApiServices().getAllProducts(allProductsPageNo.toString());
    if (response != null) {
      final List<dynamic> responseData = response.data;
      final List<ProductModel> productList = responseData
          .map((productData) => ProductModel.fromJson(productData))
          .toList();
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

      isAlreadyLoadedAllProducts.value = true;
    } else {
      isAllProductsLoadingError.value = true;
    }

    isAllProductsLoading.value = false;
  }

  getCircleAvatarProductList() async {
    // log("Getting circle list");
    isCircleAvatarProductsLoading.value = true;
    circleAvatarProductsList.clear();
    if (!isAlreadyLoadedPlainCashews.value) {
      await getProductsByCategory("PLAIN CASHEWS", "");
      // log("loaded plain");
    }
    if (!isAlreadyLoadedRoastedAndSaltedCashews.value) {
      await getProductsByCategory("ROASTED AND SALTED CASHEWS", "");
    }
    if (!isAlreadyLoadedValueAdded.value) {
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
    isCircleAvatarProductsLoading.value = false;

    // log("circle list :${circleAvatarProductsList}");
  }

  getTrendingProducts() async {
    log("getting trending");
    isTrendingLoading.value = true;
    isTrendingLoadingError.value = false;
    final response = await ApiServices()
        .getTrendingProducts(trendingProductsPageNo.toString());
    // log("trending: ${response.data}");
    if (response != null) {
      print("response not null");
      final List<dynamic> responseData = response.data;
      final List<TrendingProductModel> productList = responseData
          .map((productData) => TrendingProductModel.fromJson(productData))
          .toList();
      final Set<String> uniqueProductNames = {};

      final List<TrendingProductModel> newProductList =
          productList.where((product) {
        final isUnique = uniqueProductNames.add(product.product.name);
        return isUnique;
      }).toList();
      trending.value = newProductList.reversed.toList();
      // log("trending products:${trending.value}");

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
    final response =
        await ApiServices().getBestSellerProducts(bestSellersPageNo.toString());
    if (response != null) {
      final List<dynamic> responseData = response.data;
      final List<TrendingProductModel> productList = responseData
          .map((productData) => TrendingProductModel.fromJson(productData))
          .toList();
      final Set<String> uniqueProductNames = {};

      final List<TrendingProductModel> newProductList =
          productList.where((product) {
        final isUnique = uniqueProductNames.add(product.product.name);
        isAlreadyLoadedBestsellers = true;
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
    final response = await ApiServices()
        .getSponserdProducts(sponserdProductsPageNo.toString());
    if (response != null) {
      final List<dynamic> responseData = response.data;
      final List<TrendingProductModel> productList = responseData
          .map((productData) => TrendingProductModel.fromJson(productData))
          .toList();
      final Set<String> uniqueProductNames = {};

      final List<TrendingProductModel> newProductList =
          productList.where((product) {
        final isUnique = uniqueProductNames.add(product.product.name);

        isAlreadyLoadedSponserd = true;
        return isUnique;
      }).toList();
      sponserd.value = newProductList.reversed.toList();
    }
    isSponserdLoading.value = false;
  }

  getProductsByCategory(String category, String categoryName) async {
    // log("getting plain");

    if (category == "PLAIN CASHEWS") {
      isPlainCashewLoading.value = true;
      isPlainCashewLoadingError.value = false;
      isAlreadyLoadedPlainCashews.value = false;
      // log("storing plained");
      final response =
          await ApiServices().getProductByCategory(category, categoryName);

      if (response != null) {
        final List<dynamic> responseData = response.data;
        final List<ProductModel> productList = responseData
            .map((productData) => ProductModel.fromJson(productData))
            .toList();
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
        isAlreadyLoadedPlainCashews.value = true;
        //log("plain cas : ${plainCashews.value}");
      } else {
        log("loading error for plain");
        isPlainCashewLoadingError.value = true;
      }

      isPlainCashewLoading.value = false;
    } else if (category == "ROASTED AND SALTED CASHEWS") {
      isRoastedAndSaltedLoading.value = true;
      isRoastedAndSaltedLoadingError.value = false;
      isAlreadyLoadedRoastedAndSaltedCashews.value = false;
      // final response = await ApiServices().getProductByCategory(category, categoryName, roastedAndSaltedPageNo.toString());
      final response =
          await ApiServices().getProductByCategory(category, categoryName);

      print("storing roasted");

      if (response != null) {
        final List<dynamic> responseData = response.data;
        final List<ProductModel> productList = responseData
            .map((productData) => ProductModel.fromJson(productData))
            .toList();
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

        isAlreadyLoadedRoastedAndSaltedCashews.value = true;
      } else {
        isRoastedAndSaltedLoadingError.value = true;
      }

      isRoastedAndSaltedLoading.value = false;
    } else if (category == "VALUE ADDED CASHEW PRODUCTS") {
      isValueAddedLoading.value = true;
      isValueAddedLoadingError.value = false;
      isAlreadyLoadedValueAdded.value = false;
      final response =
          await ApiServices().getProductByCategory(category, categoryName);
      if (response != null) {
        final List<dynamic> responseData = response.data;
        final List<ProductModel> productList = responseData
            .map((productData) => ProductModel.fromJson(productData))
            .toList();
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

        isAlreadyLoadedValueAdded.value = true;
      } else {
        isValueAddedLoadingError.value = true;
      }

      isValueAddedLoading.value = false;
    }
  }

  getSimilarProducts(String productName, String productParentName) {
    similarProducts.clear();
    for (var item in allProducts) {
      log("${item.product.category.parentName} == ${productParentName}");
      if (item.product.category.parentName == productParentName &&
          item.product.name != productName) {
        log(" Adding ${item.product.name}");
        similarProducts.add(item);
      }
    }
    log("Similar products : ${similarProducts.toList()}");
  }

  createOrder(String shippingAddressId, String billingAddressId,
      BuildContext context) async {
    final response = await ApiServices()
        .placeOrder(shippingAddressId, billingAddressId, context);
    log(response.data.toString());
  }

  getOrdersList() async {
    isLoadingMyproducts.value = true;
    isMyOrdersError.value = false;
    log("my orders loading");
    final response =
        await ApiServices().getOrdersList(ordersListPageNo.toString());

    if (response != null) {
      final List<dynamic> responseData = response.data;
      final List<OrdersListModel> productList = responseData
          .map((productData) => OrdersListModel.fromJson(productData))
          .toList();
      log("orders count :${productList.length}");
      ordersList.value = productList;
    } else {
      isMyOrdersError.value = true;
    }
    isLoadingMyproducts.value = false;
  }
}
