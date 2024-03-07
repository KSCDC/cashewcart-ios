import 'dart:convert';
import 'dart:developer';

import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/models/cart_product_model.dart';
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
  RxBool isAllProductsLoading = false.obs;
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
  RxBool sortProduct = false.obs;
  RxBool sortAscending = false.obs;

  RxString dropdownValue = 'All Featured Products'.obs;

  Rx<ProductModel> allProducts = ProductModel(count: 0, next: null, previous: null, results: []).obs;
  Rx<ProductModel> plainCashews = ProductModel(count: 0, next: null, previous: null, results: []).obs;
  Rx<ProductModel> roastedAndSalted = ProductModel(count: 0, next: null, previous: null, results: []).obs;
  Rx<TrendingProductModel> trending = TrendingProductModel(count: 0, next: null, previous: null, results: []).obs;
  Rx<TrendingProductModel> bestSellers = TrendingProductModel(count: 0, next: null, previous: null, results: []).obs;
  Rx<TrendingProductModel> sponserd = TrendingProductModel(count: 0, next: null, previous: null, results: []).obs;
  Rx<ProductModel> valueAdded = ProductModel(count: 0, next: null, previous: null, results: []).obs;
  Rx<ProductModel> similarProducts = ProductModel(count: 0, next: null, previous: null, results: []).obs;
  Rx<ProductModel> relatedProducts = ProductModel(count: 0, next: null, previous: null, results: []).obs;
  Rx<ProductModel> productDisplayList = ProductModel(count: 0, next: null, previous: null, results: []).obs;
  Rx<TrendingProductModel> productDisplayList2 = TrendingProductModel(count: 0, next: null, previous: null, results: []).obs;
  Rx<CartProductModel> cartProducts = CartProductModel(count: 0, next: null, previous: null, results: []).obs;
  Rx<ProductModel> searchResults = ProductModel(count: 0, next: null, previous: null, results: []).obs;
  var sortedSearchList;
  RxBool haveSearchResult = false.obs;

  Rxn<ProductDetailsModel> productDetails = Rxn<ProductDetailsModel>();
  // Rxn<ProductReviewsModel> productReviews = Rxn<ProductReviewsModel>();
  RxList<ProductReviewsModel> productReviewsList = <ProductReviewsModel>[].obs;
  RxList<UserAddressModel> addressList = <UserAddressModel>[].obs;

  bool isAlreadyLoadedAllProducts = false;
  bool isAlreadyLoadedPlainCashews = false;
  bool isAlreadyLoadedRoastedAndSaltedCashews = false;
  bool isAlreadyLoadedValueAdded = false;
  bool isAlreadyLoadedTrending = false;
  bool isAlreadyLoadedBestsellers = false;
  bool isAlreadyLoadedSponserd = false;

  List<String> plainCashewSubCategories = ["All"];
  RxString selectedPlainCashewCategory = "All".obs;
  List<String> roastedAndSaltedSubCategories = ["All"];
  RxString selectedRoastedAndSaltedCategory = "All".obs;
  List<String> valueAddedSubCategories = ["All"];
  RxString selectedValueAddedCategory = "All".obs;

  registerNewUser(BuildContext context, String name, String email, String phoneNumber, String password) async {
    isLoading.value = true;
    final response = await ApiServices().registerUser(context, name, email, phoneNumber, password);
    if (response == null) {
      isLoading.value = false;
    } else {
      final accessToken = response.data['token']['access'];
      final refreshToken = response.data['token']['refresh'];
      print("access token :$accessToken\nrefresh token :$refreshToken");
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      sharedPref.setString(ACCESSTOKEN, accessToken);
      sharedPref.setString(REFRESHTOKEN, refreshToken);

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
      log(response.data.toString());
      final accessToken = response.data['token']['access'];
      final refreshToken = response.data['token']['refresh'];
      print("access token :$accessToken\nrefresh token :$refreshToken");
      SharedPreferences sharedPref = await SharedPreferences.getInstance();

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
    final response = await ApiServices().getAllProducts();
    if (response != null) {
      final data = ProductModel.fromJson(response.data);
      allProducts.value = data;
      isAlreadyLoadedAllProducts = true;
    }

    isAllProductsLoading.value = false;
  }

  getTrendingProducts() async {
    isTrendingLoading.value = true;
    final response = await ApiServices().getTrendingProducts();
    if (response != null) {
      final data = TrendingProductModel.fromJson(response.data);
      trending.value = data;
      isAlreadyLoadedTrending = true;
    }

    isTrendingLoading.value = false;
  }

  getBestSellerProducts() async {
    isBestSellersLoading.value = true;
    final response = await ApiServices().getBestSellerProducts();
    if (response != null) {
      final data = TrendingProductModel.fromJson(response.data);
      bestSellers.value = data;
      isAlreadyLoadedBestsellers = true;
    }
    print("best sellers :${bestSellers}");
    isBestSellersLoading.value = false;
  }

  getSponserdProducts() async {
    isSponserdLoading.value = true;
    final response = await ApiServices().getSponserdProducts();
    if (response != null) {
      final data = TrendingProductModel.fromJson(response.data);
      sponserd.value = data;
      isAlreadyLoadedSponserd = true;
    }

    isSponserdLoading.value = false;
  }

  getProductsByCategory(String category, String categoryName) async {
    // print(response.data);
    // print(data.count);
    if (category == "Plain Cashews") {
      isPlainCashewLoading.value = true;
      final response = await ApiServices().getProductByCategory(category, categoryName);
      final data = ProductModel.fromJson(response.data);
      plainCashews.value = data;
      for (int i = 0; i < data.count; i++) {
        final categoryName = data.results![i].product.category.name;
        if (!plainCashewSubCategories.contains(categoryName)) {
          plainCashewSubCategories.add(categoryName);
        }
      }
      print("Categories in plain :$plainCashewSubCategories");
      isAlreadyLoadedPlainCashews = true;
      isPlainCashewLoading.value = false;
    } else if (category == "Roasted and salted") {
      print("storing roasted");
      isRoastedAndSaltedLoading.value = true;
      final response = await ApiServices().getProductByCategory(category, categoryName);
      // print(response.data);
      final data = ProductModel.fromJson(response.data);
      roastedAndSalted.value = data;
      for (int i = 0; i < data.count; i++) {
        final categoryName = data.results![i].product.category.name;
        if (!roastedAndSaltedSubCategories.contains(categoryName)) {
          roastedAndSaltedSubCategories.add(categoryName);
        }
      }
      print("Categories in roasted :$roastedAndSaltedSubCategories");
      isAlreadyLoadedRoastedAndSaltedCashews = true;
      isRoastedAndSaltedLoading.value = false;
    } else if (category == "Value Added") {
      isValueAddedLoading.value = true;
      final response = await ApiServices().getProductByCategory(category, categoryName);
      final data = ProductModel.fromJson(response.data);
      valueAdded.value = data;
      for (int i = 0; i < data.count; i++) {
        final categoryName = data.results![i].product.category.name;
        if (!valueAddedSubCategories.contains(categoryName)) {
          valueAddedSubCategories.add(categoryName);
        }
      }
      print("Categories in roasted :$valueAddedSubCategories");
      isAlreadyLoadedValueAdded = true;
      isValueAddedLoading.value = false;
    }
  }

  searchProducts(String searchKey) async {
    isLoading.value = true;
    final response = await ApiServices().searchProduct(searchKey, minSearchPrice.value, maxSearchPrice.value);
    if (response != null) {
      final data = ProductModel.fromJson(response.data);
      searchResults.value = data;
      List<Results> result = data.results!;

      if (sortProduct.value) {
        if (sortAscending.value) {
          result.sort((a, b) => double.parse(a.sellingPrice).compareTo(double.parse(b.sellingPrice)));
        } else {
          result.sort((a, b) => double.parse(b.sellingPrice).compareTo(double.parse(a.sellingPrice)));
        }
        searchResults.value.results = result;
      }

      haveSearchResult.value = true;
    } else {
      haveSearchResult.value = false;
    }

    isLoading.value = false;
  }

  getProductDetails(String id) async {
    isLoading.value = true;
    final response = await ApiServices().getProductDetails(id);
    if (response != null) {
      final data = await ProductDetailsModel.fromJson(response.data);
      productDetails.value = data;
      isAlreadyLoadedAllProducts = true;
    }

    isLoading.value = false;
  }

  getProductReviews(String productId) async {
    isReviewsLoading.value = true;
    productReviewsList.clear();
    final List<ProductReviewsModel> tempList = [];
    final response = await ApiServices().getProductReviews(productId);
    final avgRatingResponse = await ApiServices().getAverageStarRatings(productId);
    if (avgRatingResponse != null) {
      print("avg ratings :${avgRatingResponse.data['average_rating']}");
      avgRating.value = avgRatingResponse.data['average_rating'];
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
    }

    isReviewsLoading.value = false;
  }

  addProductReview(BuildContext context, String productId, String reviewText, int numberOfStars) async {
    final List<ProductReviewsModel> tempList = [];
    final response = await ApiServices().addProductReview(context, productId, reviewText, numberOfStars);

    if (response != null) {
      // final review = ProductReviewsModel.fromJson(item);
      final data = await ProductReviewsModel.fromJson(response.data);
      productReviewsList.add(data);
      // }

      // productReviewsList = productReviewsList + tempList;

      // productReviews.value = productReviewsList;
    }
  }

  getSimilarProducts(ProductModel currentCategoryProducts, int selectedIndex) {
    print("list length before :${currentCategoryProducts.results!.length}");
    // currentCategoryProducts.copyWith()
    if (currentCategoryProducts.results!.isNotEmpty) {
      var temp = currentCategoryProducts.copyWith(results: List.from(currentCategoryProducts.results!));
      temp.results!.removeAt(selectedIndex);
      print("list length after :${temp.results!.length}");
      similarProducts.value = temp;
    }
    print("original list length after :${currentCategoryProducts.results!.length}");
  }

  getProfileDetails() async {
    isLoading.value = true;
    final response = await ApiServices().getProfileDetails();

    if (response != null) {
      userName = response.data['name'];
      email = response.data['email'];
      phoneNo = response.data['phone_number'];
    }

    print(userName);
    isLoading.value = false;
  }

  getCartList() async {
    // isLoading.value = true;

    final response = await ApiServices().getCartList();
    if (response != null) {
      final data = CartProductModel.fromJson(response.data);
      log(response.data.toString());
      cartProducts.value = data;
      cartCountNotifier.value = data.count;
    }

    // isLoading.value = false;
  }

  addProductToCart(BuildContext context, String productId) async {
    await ApiServices().addProductToCart(context, productId);
  }

  removeProductFromCart(BuildContext context, String productId) async {
    await ApiServices().removeFromCart(context, productId);
    getCartList();
  }

  getUserAddresses() async {
    print("getting addresses");
    isLoading.value = true;
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

      // productReviews.value = productReviewsList;
    }
    print("city----${addressList.value[0].city}");

    isLoading.value = false;
  }
}
