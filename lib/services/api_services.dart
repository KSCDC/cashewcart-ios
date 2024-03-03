import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:internship_sample/core/base_url.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/core/end_points.dart';
import 'package:internship_sample/presentation/main_page/main_page_screen.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  registerUser(BuildContext context, String name, String email, String phoneNumber, String pasword) async {
    final Map<String, dynamic> formData = {
      "name": name,
      "email": email,
      "phone_number": phoneNumber,
      "password": pasword,
      "password2": pasword,
    };

    try {
      final dio = Dio();

      final response = await dio.post(
        "$baseUrl${ApiEndPoints.registerUser}",
        data: formData,
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Registration successful");
        Services().showCustomSnackBar(context, "Account created successfully");
        return response;
      } else {
        print("Unexpected status code: ${response.statusCode}");
        return null;
      }
    } on DioException catch (e) {
      final errorData = e.response!.data['errors'];
      // print("Error :$e");
      print("Error: ${errorData}");
      if (errorData['phone_number'] != null) {
        // print(errorData['phone_number'][0]);
        Services().showCustomSnackBar(context, errorData['phone_number'][0]);
      }
      if (errorData['email'] != null) {
        // print(errorData['email'][0]);
        Services().showCustomSnackBar(context, errorData['email'][0]);
      }
      return null;
    }
  }

  loginUser(BuildContext context, String email, String pasword) async {
    final Map<String, dynamic> formData = {
      "email": email,
      "password": pasword,
    };

    try {
      final dio = Dio();

      final response = await dio.post(
        "$baseUrl${ApiEndPoints.loginUser}",
        data: formData,
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Login successful");
        Services().showCustomSnackBar(context, "Login successful");

        return response;
      } else {
        print("Unexpected status code: ${response.statusCode}");
        return null;
      }
    } on DioException catch (e) {
      final errorData = e.response!.data['errors'];
      // print("Error :$e");
      print("Error: ${errorData}");
      if (errorData['non_field_errors'] != null) {
        print(errorData['non_field_errors'][0]);
        Services().showCustomSnackBar(context, errorData['non_field_errors'][0]);
      }
      return null;
    }
  }

  refreshAccessToken() async {
    try {
      print("refreshing token");
      final dio = Dio();
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      final refreshToken = sharedPref.getString(REFRESHTOKEN);
      final response = await dio.post(
        "$baseUrl${ApiEndPoints.refreshAccessToken}",
        options: Options(
          headers: {
            'Content-Type': Headers.jsonContentType,
          },
        ),
        data: {"refresh": refreshToken},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        final accessToken = response.data['access'];

        sharedPref.setString(ACCESSTOKEN, accessToken);
        print("new token:${accessToken}");
        return response;
      } else {
        print("Unexpected status code: ${response.statusCode}");
        return null;
      }
    } on DioException catch (e) {
      print("Error :${e.response!.data}");

      return null;
    }
  }

  getAllProducts() async {
    try {
      final dio = Dio();

      final response = await dio.get(
        "$baseUrl${ApiEndPoints.getAllProducts}",
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // log(response.data.toString());
        return response;
      } else {
        print("Unexpected status code: ${response.statusCode}");
        return null;
      }
    } on DioException catch (e) {
      print("Error :$e");

      return null;
    }
  }

  getProductByCategory(String categoryParent, String categoryName) async {
    final params = <String, dynamic>{
      "product__category__parent__name": categoryParent,
      "product__category__name": categoryName,
    };

    try {
      final dio = Dio();

      final response = await dio.get(
        "$baseUrl${ApiEndPoints.filterProduct}",
        queryParameters: params,
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        return response;
      } else {
        print("Unexpected status code: ${response.statusCode}");
        return null;
      }
    } on DioException catch (e) {
      print("Error :$e");

      return null;
    }
  }

  searchProduct(String searchKey) async {
    final params = <String, dynamic>{
      "search": searchKey,
    };

    try {
      final dio = Dio();

      final response = await dio.get(
        "$baseUrl${ApiEndPoints.filterProduct}",
        queryParameters: params,
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        return response;
      } else {
        print("Unexpected status code: ${response.statusCode}");
        return null;
      }
    } on DioException catch (e) {
      print("Error :$e");

      return null;
    }
  }

  getProductDetails(String id) async {
    try {
      final dio = Dio();

      final response = await dio.get(
        "$baseUrl${ApiEndPoints.getProductDetails}$id",
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        return response;
      } else {
        print("Unexpected status code: ${response.statusCode}");
        return null;
      }
    } on DioException catch (e) {
      print("Error :$e");

      return null;
    }
  }

  getProductReviews(String id) async {
    try {
      final dio = Dio();

      final response = await dio.get(
        "$baseUrl${ApiEndPoints.reviewseviews}$id/list/",
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        return response;
      } else {
        print("Unexpected status code: ${response.statusCode}");
        return null;
      }
    } on DioException catch (e) {
      print("Error :$e");

      return null;
    }
  }

  addProductReview(BuildContext context, String id, String reviewText, int numberOfStars) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final authToken = sharedPref.getString(ACCESSTOKEN);
    final Map<String, dynamic> formData = {
      "review_text": reviewText,
      "stars": numberOfStars,
    };
    try {
      final dio = Dio();

      final response = await dio.post(
        "$baseUrl${ApiEndPoints.reviewseviews}$id/add-review/",
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type': Headers.jsonContentType,
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        return response;
      } else {
        print("Unexpected status code: ${response.statusCode}");
        return null;
      }
    } on DioException catch (e) {
      print("Error :${e.response!.data}");
      // print("Error :${e.response!.data['error']}");
      Services().showCustomSnackBar(context, e.response!.data['error']);
      if (e.response!.statusCode == 401) {
        print("refresh token");
        refreshAccessToken();
        addProductReview(context, id, reviewText, numberOfStars);
      }
      return null;
    }
  }

  getProfileDetails() async {
    try {
      final dio = Dio();
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      final authToken = sharedPref.getString(ACCESSTOKEN);
      final response = await dio.get(
        "$baseUrl${ApiEndPoints.userProfile}",
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type': Headers.jsonContentType,
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        return response;
      } else {
        print("Unexpected status code: ${response.statusCode}");
        return null;
      }
    } on DioException catch (e) {
      print("Error :$e");
      if (e.response!.statusCode == 401) {
        print("refresh token");
        refreshAccessToken();
        getProfileDetails();
      }
      return null;
    }
  }

  getCartList() async {
    try {
      final dio = Dio();
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      final authToken = sharedPref.getString(ACCESSTOKEN);
      final response = await dio.get(
        "$baseUrl${ApiEndPoints.listCart}",
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type': Headers.jsonContentType,
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        return response;
      } else {
        print("Unexpected status code: ${response.statusCode}");
        return null;
      }
    } on DioException catch (e) {
      print("Error :$e");
      if (e.response!.statusCode == 401) {
        print("refresh token");
        refreshAccessToken();
        getCartList();
      }
      return null;
    }
  }

  addProductToCart(BuildContext context, String productId) async {
    try {
      final dio = Dio();
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      final authToken = sharedPref.getString(ACCESSTOKEN);
      final response = await dio.post(
        "$baseUrl${ApiEndPoints.addOrRemoveFromCart}$productId/",
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type': Headers.jsonContentType,
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        cartCountNotifier.value++;
        Services().showCustomSnackBar(context, "Product added to cart");
        return response;
      } else {
        print("Unexpected status code: ${response.statusCode}");
        return null;
      }
    } on DioException catch (e) {
      print(e.response!.statusCode);
      print("Error :${e.response!.data}");
      if (e.response!.statusCode == 401) {
        print("refresh token");
        refreshAccessToken();
        addProductToCart(context, productId);
      } else {
        Services().showCustomSnackBar(context, e.response!.data['errors']['non_field_errors'][0]);
      }
      return null;
    }
  }

  removeFromCart(BuildContext context, String productId) async {
    try {
      print("Trying to remove from cart:{$baseUrl${ApiEndPoints.addOrRemoveFromCart}$productId/}");
      final dio = Dio();
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      final authToken = sharedPref.getString(ACCESSTOKEN);
      final response = await dio.delete(
        "$baseUrl${ApiEndPoints.addOrRemoveFromCart}$productId/",
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type': Headers.jsonContentType,
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        Services().showCustomSnackBar(context, response.data['message']);
        return response;
      } else {
        print("Unexpected status code: ${response.statusCode}");
        return null;
      }
    } on DioException catch (e) {
      print(e.response!.statusCode);
      print("Error :${e.response!.data}");
      if (e.response!.statusCode == 401) {
        print("refresh token");
        refreshAccessToken();
        removeFromCart(context, productId);
      }
      return null;
    }
  }

  updateCartCount(String productId, int newCount) async {
    try {
      print("Trying to remove from cart:{$baseUrl${ApiEndPoints.updateCartCount}$productId/}");
      final dio = Dio();
      final Map<String, dynamic> formData = {
        "purchase_count": newCount,
      };
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      final authToken = sharedPref.getString(ACCESSTOKEN);
      final response = await dio.patch(
        "$baseUrl${ApiEndPoints.updateCartCount}$productId/",
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type': Headers.jsonContentType,
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        // Services().showCustomSnackBar(response.data['message']);
        getCartList();
        return response;
      } else {
        print("Unexpected status code: ${response.statusCode}");
        return null;
      }
    } on DioException catch (e) {
      print(e.response!.statusCode);
      print("Error :${e.response!.data}");
      if (e.response!.statusCode == 401) {
        print("refresh token");
        refreshAccessToken();
        updateCartCount(productId, newCount);
      }
      return null;
    }
  }

  createUserAddress(String streetAddress, String city, String state, String postalCode, bool isDefaultAddress) async {
    final Map<String, dynamic> formData = {
      "street_address": streetAddress,
      "city": city,
      "state": state,
      "postal_code": postalCode,
      "is_default": isDefaultAddress,
    };

    try {
      final dio = Dio();
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      final authToken = sharedPref.getString(ACCESSTOKEN);
      final response = await dio.post(
        "$baseUrl${ApiEndPoints.address}",
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type': Headers.jsonContentType,
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Address saved");
        // Services().showCustomSnackBar(context, "Login successful");
        print(response.data);
        getUserAddresses();
        return response;
      } else {
        print("Unexpected status code: ${response.statusCode}");
        return null;
      }
    } on DioException catch (e) {
      // final errorData = e.response!.data['errors'];
      print("Error :$e");
      if (e.response!.statusCode == 401) {
        print("refresh token");
        refreshAccessToken();
        createUserAddress(streetAddress, city, state, postalCode, isDefaultAddress);
      }
      return null;
    }
  }

  getUserAddresses() async {
    try {
      final dio = Dio();
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      final authToken = sharedPref.getString(ACCESSTOKEN);
      final response = await dio.get(
        "$baseUrl${ApiEndPoints.address}",
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type': Headers.jsonContentType,
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        return response;
      } else {
        print("Unexpected status code: ${response.statusCode}");
        return null;
      }
    } on DioException catch (e) {
      print("Error :$e");
      if (e.response!.statusCode == 401) {
        print("refresh token");
        refreshAccessToken();
        getUserAddresses();
      }
      return null;
    }
  }
}
