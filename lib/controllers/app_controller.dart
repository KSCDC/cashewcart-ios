import 'dart:convert';
import 'dart:developer';

import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/models/cart_product_model.dart';
import 'package:internship_sample/models/orders_list_model.dart' as ordersModel;
import 'package:internship_sample/models/product_details_model.dart';
import 'package:internship_sample/models/product_model.dart';
import 'package:internship_sample/models/product_reviews_model.dart';
import 'package:internship_sample/models/trending_product_model.dart' as trendingModel;
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
  RxBool isError = false.obs;
  RxBool isLoadingCart = false.obs;
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

  Rx<ProductModel> allProducts = ProductModel(count: 0, next: null, previous: null, results: []).obs;
  Rx<ProductModel> plainCashews = ProductModel(count: 0, next: null, previous: null, results: []).obs;
  Rx<ProductModel> roastedAndSalted = ProductModel(count: 0, next: null, previous: null, results: []).obs;
  Rx<trendingModel.TrendingProductModel> trending = trendingModel.TrendingProductModel(count: 0, next: null, previous: null, results: []).obs;
  Rx<trendingModel.TrendingProductModel> bestSellers = trendingModel.TrendingProductModel(count: 0, next: null, previous: null, results: []).obs;
  Rx<trendingModel.TrendingProductModel> sponserd = trendingModel.TrendingProductModel(count: 0, next: null, previous: null, results: []).obs;
  Rx<ProductModel> valueAdded = ProductModel(count: 0, next: null, previous: null, results: []).obs;
  Rx<ProductModel> similarProducts = ProductModel(count: 0, next: null, previous: null, results: []).obs;
  Rx<ProductModel> relatedProducts = ProductModel(count: 0, next: null, previous: null, results: []).obs;
  Rx<ProductModel> productDisplayList = ProductModel(count: 0, next: null, previous: null, results: []).obs;
  Rx<trendingModel.TrendingProductModel> productDisplayList2 = trendingModel.TrendingProductModel(count: 0, next: null, previous: null, results: []).obs;
  Rx<CartProductModel> cartProducts = CartProductModel(count: 0, next: null, previous: null, results: []).obs;
  Rx<ProductModel> searchResults = ProductModel(count: 0, next: null, previous: null, results: []).obs;
  Rx<ordersModel.OrdersListModel> ordersList = ordersModel.OrdersListModel(count: 0, next: null, previous: null, results: []).obs;
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

  RxList<String> plainCashewSubCategories = ["All"].obs;
  RxString selectedPlainCashewCategory = "All".obs;
  RxList<String> roastedAndSaltedSubCategories = ["All"].obs;
  RxString selectedRoastedAndSaltedCategory = "All".obs;
  RxList<String> valueAddedSubCategories = ["All"].obs;
  RxString selectedValueAddedCategory = "All".obs;

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
      log(response.data.toString());
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
      final data = ProductModel.fromJson(response.data);

      print("results ${response.data['results']}");
      List<Results>? results = data.results;
      if (results != null) {
        List<Results> combinedResults = [];
        combinedResults.addAll(allProducts.value.results ?? []);
        combinedResults.addAll(results);
        allProducts.value.results = combinedResults;
        allProducts.update((val) {
          val!.count = data.count;
          val.next = response.data['next'];
          val.previous = response.data['previous'];
        });
        // allProducts.value.next = response.data['next'];
        // allProducts.value.previous = response.data['previous'];
      }

      isAlreadyLoadedAllProducts = true;

      log("All products count:${allProducts.value.count.toString()}");

      log("All products next:${response.data['next'].toString()}");
    } else {
      isAllProductsLoadingError.value = true;
    }

    isAllProductsLoading.value = false;
  }

  getTrendingProducts() async {
    isBestSellersLoading.value = true;
    isBestSellersLoadingError.value = false;
    final response = await ApiServices().getTrendingProducts(trendingProductsPageNo.toString());
    if (response != null) {
      final data = trendingModel.TrendingProductModel.fromJson(response.data);

      print("results ${response.data['results']}");
      List<trendingModel.Result>? results = data.results;

      List<trendingModel.Result> combinedResults = [];
      combinedResults.addAll(bestSellers.value.results ?? []);
      combinedResults.addAll(results);
      bestSellers.value.results = combinedResults;
      bestSellers.update((val) {
        val!.count = data.count;
        val.next = response.data['next'];
        val.previous = response.data['previous'];
      });

      isAlreadyLoadedBestsellers = true;
    } else {
      isBestSellersLoadingError.value = true;
    }

    print("best sellers :${bestSellers}");
    isBestSellersLoading.value = false;
  }

  getBestSellerProducts() async {
    isBestSellersLoading.value = true;
    isBestSellersLoading.value = false;
    final response = await ApiServices().getBestSellerProducts(bestSellersPageNo.toString());
    if (response != null) {
      final data = trendingModel.TrendingProductModel.fromJson(response.data);

      List<trendingModel.Result>? results = data.results;

      List<trendingModel.Result> combinedResults = [];

      combinedResults.addAll(bestSellers.value.results ?? []);

      combinedResults.addAll(results);

      bestSellers.value.results = combinedResults;
      bestSellers.update((val) {
        val!.count = data.count;
        val.next = response.data['next'];
        val.previous = response.data['previous'];
      });

      isAlreadyLoadedBestsellers = true;
    } else {
      isBestSellersLoadingError.value = true;
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
      final data = trendingModel.TrendingProductModel.fromJson(response.data);
      print("Sponserd next from res :${response.data['next']}");
      List<trendingModel.Result>? results = data.results;

      List<trendingModel.Result> combinedResults = [];
      combinedResults.addAll(sponserd.value.results ?? []);
      combinedResults.addAll(results);
      sponserd.value.results = combinedResults;
      sponserd.update((val) {
        val!.count = data.count;
        val.next = response.data['next'];
        val.previous = response.data['previous'];
      });
      print("Sponserd next from model :${sponserd.value.next}");
      isAlreadyLoadedSponserd = true;
    } else {
      isSponserdLoadingError.value = true;
    }

    isSponserdLoading.value = false;
  }

  getProductsByCategory(String category, String categoryName) async {
    // int count;
    // print(response.data);
    // print(data.count);

    if (category == "Plain Cashews") {
      isPlainCashewLoading.value = true;
      isPlainCashewLoadingError.value = false;
      final response = await ApiServices().getProductByCategory(category, categoryName, plainCashewsPageNo.toString());
      print("storing plained");
// print(response.data);
      if (response != null) {
        final data = ProductModel.fromJson(response.data);

        print("results ${response.data['results']}");
        List<Results>? results = data.results;
        if (results != null) {
          List<Results> combinedResults = [];
          combinedResults.addAll(plainCashews.value.results ?? []);
          combinedResults.addAll(results);
          plainCashews.value.results = combinedResults;
          plainCashews.update((val) {
            val!.count = data.count;
            val.next = response.data['next'];
            val.previous = response.data['previous'];
          });
          for (int i = 0; i < data.results!.length; i++) {
            final categoryName = data.results![i].product.category.name;
            if (!plainCashewSubCategories.contains(categoryName)) {
              plainCashewSubCategories.add(categoryName);
            }
          }
        }

        print("Categories in roasted :$plainCashewSubCategories");
        isAlreadyLoadedPlainCashews = true;
      } else {
        isPlainCashewLoadingError.value = true;
      }

      isPlainCashewLoading.value = false;
    } else if (category == "Roasted and Salted Cashews") {
      isRoastedAndSaltedLoading.value = true;
      isRoastedAndSaltedLoadingError.value = false;
      final response = await ApiServices().getProductByCategory(category, categoryName, roastedAndSaltedPageNo.toString());
      print("storing roasted");
// print(response.data);
      if (response != null) {
        final data = ProductModel.fromJson(response.data);

        print("results ${response.data['results']}");
        List<Results>? results = data.results;
        if (results != null) {
          List<Results> combinedResults = [];
          combinedResults.addAll(roastedAndSalted.value.results ?? []);
          combinedResults.addAll(results);
          roastedAndSalted.value.results = combinedResults;
          roastedAndSalted.update((val) {
            val!.count = data.count;
            val.next = response.data['next'];
            val.previous = response.data['previous'];
          });
          for (int i = 0; i < data.results!.length; i++) {
            final categoryName = data.results![i].product.category.name;
            if (!roastedAndSaltedSubCategories.contains(categoryName)) {
              roastedAndSaltedSubCategories.add(categoryName);
            }
          }
        }

        print("Categories in roasted :$roastedAndSaltedSubCategories");
        isAlreadyLoadedRoastedAndSaltedCashews = true;
      } else {
        isRoastedAndSaltedLoadingError.value = true;
      }

      isRoastedAndSaltedLoading.value = false;
    } else if (category == "Value Added") {
      isValueAddedLoading.value = true;
      isValueAddedLoadingError.value = false;
      final response = await ApiServices().getProductByCategory(category, categoryName, valueAddedPageNo.toString());
      if (response != null) {
        final data = ProductModel.fromJson(response.data);

        print("results ${response.data['results']}");
        List<Results>? results = data.results;
        if (results != null) {
          List<Results> combinedResults = [];
          combinedResults.addAll(valueAdded.value.results ?? []);
          combinedResults.addAll(results);
          valueAdded.value.results = combinedResults;
          valueAdded.update((val) {
            val!.count = data.count;
            val.next = response.data['next'];
            val.previous = response.data['previous'];
          });
          for (int i = 0; i < data.results!.length; i++) {
            final categoryName = data.results![i].product.category.name;
            if (!valueAddedSubCategories.contains(categoryName)) {
              valueAddedSubCategories.add(categoryName);
            }
          }
        }

        print("Categories in roasted :$valueAddedSubCategories");
        isAlreadyLoadedValueAdded = true;
      } else {
        isValueAddedLoadingError.value = true;
      }

      isValueAddedLoading.value = false;
    }
  }

  searchProducts(String searchKey) async {
    isLoading.value = true;

    final response = await ApiServices().searchProduct(searchKey, minSearchPrice.value, maxSearchPrice.value, searchResultPageNo.toString());

    if (response != null) {
      final data = ProductModel.fromJson(response.data);
      // searchResults.value = data;
      List<Results>? results = data.results;
      List<Results> combinedResults = [];
      if (results != null && results.isNotEmpty) {
        combinedResults.addAll(searchResults.value.results ?? []);
        combinedResults.addAll(results);
        searchResults.value.results = combinedResults;
        searchResults.update((val) {
          val!.count = data.count!;
          val.next = response.data['next'];
          val.previous = response.data['previous'];
        });
        if (sortProduct.value) {
          if (sortAscending.value) {
            searchResults.value.results!.sort((a, b) => double.parse(a.sellingPrice).compareTo(double.parse(b.sellingPrice)));
          } else {
            searchResults.value.results!.sort((a, b) => double.parse(b.sellingPrice).compareTo(double.parse(a.sellingPrice)));
          }
        }
        List<Results> updatedResults = List.from(searchResults.value.results ?? []);

        updatedResults.addAll(results);
        searchResults.value.results = updatedResults;

        haveSearchResult.value = true;
      } else {
        haveSearchResult.value = false;
      }

      searchResults.update((val) {
        val!.next = response.data['next'];
      });
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
      final data = await ProductReviewsModel.fromJson(response.data);
      productReviewsList.add(data);
    }
  }

  getSimilarProducts(ProductModel currentCategoryProducts, int selectedIndex) {
    print("list length before :${currentCategoryProducts.results!.length}");

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
    isError.value = false;
    final response = await ApiServices().getProfileDetails();

    if (response != null) {
      userName = response.data['name'];
      email = response.data['email'];
      phoneNo = response.data['phone_number'];
    } else {
      isError.value = true;
    }

    print(userName);
    isLoading.value = false;
  }

  getCartList() async {
    isLoadingCart.value = true;
    isError.value = false;
    final response = await ApiServices().getCartList();
    if (response != null) {
      final data = CartProductModel.fromJson(response.data);
      log(response.data.toString());
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

      // productReviews.value = productReviewsList;
    } else {
      isLoadingAddressError.value = true;
    }

    isLoadingAddress.value = false;
  }

  createOrder(String addressId) async {
    final response = await ApiServices().placeOrder(addressId);
    print(response.data.toString());
  }

  getOrdersList() async {
    isLoading.value = true;
    isError.value = true;
    final response = await ApiServices().getOrdersList(ordersListPageNo.toString());
    if (response != null) {
      final data = ordersModel.OrdersListModel.fromJson(response.data);

      print("results ${response.data['results']}");
      List<ordersModel.Result>? results = data.results;
      List<ordersModel.Result> combinedResults = [];
      if (results != null) {
        ordersList.value.results = [];
        combinedResults.addAll(ordersList.value.results ?? []);
        combinedResults.addAll(results);
        ordersList.value.results = combinedResults;
        ordersList.update((val) {
          val!.count = data.count;
          val.next = response.data['next'];
          val.previous = response.data['previous'];
        });
      }

      log("Orders count:${allProducts.value.count.toString()}");

      log("Orders next:${response.data['next'].toString()}");
    } else {
      isError.value = true;
    }

    isLoading.value = false;
  }
}
