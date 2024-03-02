import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/models/product_details_model.dart';
import 'package:internship_sample/models/product_model.dart';
import 'package:internship_sample/presentation/main_page/main_page_screen.dart';
import 'package:internship_sample/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppController extends GetxController {
  String userName = "";
  String email = "";
  String phoneNo = "";
  // String selectedProductId = "";
  RxBool isLoading = false.obs;
  RxBool isAllProductsLoading = false.obs;
  RxBool isPlainCashewLoading = false.obs;
  RxBool isRoastedAndSaltedLoading = false.obs;
  RxBool isValueAddedLoading = false.obs;
  RxBool isSimilarProductsLoading = false.obs;
  Rx<ProductModel> allProducts = ProductModel(count: 0, next: null, previous: null, results: []).obs;
  Rx<ProductModel> plainCashews = ProductModel(count: 0, next: null, previous: null, results: []).obs;
  Rx<ProductModel> roastedAndSalted = ProductModel(count: 0, next: null, previous: null, results: []).obs;
  Rx<ProductModel> valueAdded = ProductModel(count: 0, next: null, previous: null, results: []).obs;
  Rx<ProductModel> similarProducts = ProductModel(count: 0, next: null, previous: null, results: []).obs;
  Rx<ProductModel> productDisplayList = ProductModel(count: 0, next: null, previous: null, results: []).obs;
  Rx<ProductModel> cartProducts = ProductModel(count: 0, next: null, previous: null, results: []).obs;
  Rx<ProductModel> searchResults = ProductModel(count: 0, next: null, previous: null, results: []).obs;

  Rxn<ProductDetailsModel> productDetails = Rxn<ProductDetailsModel>();

  bool isAlreadyLoadedAllProducts = false;
  bool isAlreadyLoadedPlainCashews = false;
  bool isAlreadyLoadedRoastedAndSaltedCashews = false;
  bool isAlreadyLoadedValueAdded = false;

  List<String> plainCashewSubCategories = ["All"];
  RxString selectedPlainCashewCategory = "All".obs;
  List<String> roastedAndSaltedSubCategories = ["All"];
  RxString selectedRoastedAndSaltedCategory = "All".obs;
  List<String> valueAddedSubCategories = ["All"];
  RxString selectedValueAddedCategory = "All".obs;

  registerNewUser(BuildContext context, String name, String email, String phoneNumber, String pasword) async {
    isLoading.value = true;
    final response = await ApiServices().registerUser(context, name, email, phoneNumber, pasword);
    if (response == null) {
      isLoading.value = false;
    } else {
      final accessToken = response.data['token']['access'];
      final refreshToken = response.data['token']['refresh'];
      print("access token :$accessToken\nrefresh token :$refreshToken");
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      sharedPref.setString(ACCESSTOKEN, accessToken);
      sharedPref.setString(REFRESHTOKEN, refreshToken);
      isLoading.value = false;
      Get.offAll(() => MainPageScreen());
    }
  }

  loginUser(BuildContext context, String email, String pasword) async {
    isLoading.value = true;
    final response = await ApiServices().loginUser(context, email, pasword);
    if (response != null) {
      log(response.data.toString());
      final accessToken = response.data['token']['access'];
      final refreshToken = response.data['token']['refresh'];
      print("access token :$accessToken\nrefresh token :$refreshToken");
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      sharedPref.setString(ACCESSTOKEN, accessToken);
      sharedPref.setString(REFRESHTOKEN, refreshToken);

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

  getProductsByCategory(String category, String categoryName) async {
    // print(response.data);
    // print(data.count);
    if (category == "Plain Cashews") {
      isPlainCashewLoading.value = true;
      final response = await ApiServices().getProductByCategory(category, categoryName);
      final data = ProductModel.fromJson(response.data);
      plainCashews.value = data;
      for (int i = 0; i < data.count; i++) {
        final categoryName = data.results[i].product.category.name;
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
        final categoryName = data.results[i].product.category.name;
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
        final categoryName = data.results[i].product.category.name;
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
    final response = await ApiServices().searchProduct(searchKey);
    if (response != null) {
      final data = ProductModel.fromJson(response.data);
      searchResults.value = data;
    } else {}

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

  getSimilarProducts(ProductModel currentCategoryProducts, int selectedIndex) {
    print("list length before :${currentCategoryProducts.results.length}");
    // currentCategoryProducts.copyWith()
    if (currentCategoryProducts.results.isNotEmpty) {
      var temp = currentCategoryProducts.copyWith(results: List.from(currentCategoryProducts.results));
      temp.results.removeAt(selectedIndex);
      print("list length after :${temp.results.length}");
      similarProducts.value = temp;
    }
    print("original list length after :${currentCategoryProducts.results.length}");
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
    isLoading.value = true;
    final response = await ApiServices().getCartList();
    if (response != null) {
      final data = ProductModel.fromJson(response.data);
      log(response.data.toString());
    }

    isLoading.value = false;
  }

  addProductToCart(String productId) async {
    final response = await ApiServices().addProductToCart(productId);
  }
}
