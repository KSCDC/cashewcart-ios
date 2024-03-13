import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as enc;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:internship_sample/controllers/app_controller.dart';

import 'package:internship_sample/core/base_url.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/core/end_points.dart';
import 'package:internship_sample/presentation/authentication/signin_screen.dart';
import 'package:internship_sample/presentation/main_page/main_page_screen.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  AppController controller = Get.put(AppController());

  bool isFailedLogin = false;

  registerUser(BuildContext context, String token, String name, String phoneNumber, String password) async {
    print(token);

    final dio = Dio();
    final params = {
      "token": token,
    };
    final formData = {
      "name": name,
      "phone_number": phoneNumber,
      "password": password,
      "password2": password,
    };
    print(params);
    print(formData);

    dio.options.connectTimeout = connectionTimeoutDuration;

    try {
      final response = await dio.post(
        "$baseUrl${ApiEndPoints.registerUser}",
        queryParameters: params,
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
      print("Reg error :$e");
      print("Reg error :${e.response}");
      if (e.type == DioExceptionType.connectionTimeout) {
        print("Connection timeout");
        Services().showCustomSnackBar(context, "Connection timeout. Please check your internet connection");
      } else {
        // final errorData = e.response!.data['errors'];
        // print("Error :$e");
        // print("Error: ${errorData}");
        // if (errorData['phone_number'] != null) {
        //   // print(errorData['phone_number'][0]);
        //   Services().showCustomSnackBar(context, errorData['phone_number'][0]);
        // }
        // if (errorData['email'] != null) {
        //   // print(errorData['email'][0]);
        //   Services().showCustomSnackBar(context, errorData['email'][0]);
        // }
      }
      return null;
    }
  }

  loginUser(BuildContext context, String email, String pasword) async {
    final formData = {
      "email": email,
      "password": pasword,
    };

    try {
      final dio = Dio();
      dio.options.connectTimeout = connectionTimeoutDuration;
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
      print(e.type);
      if (e.type == DioExceptionType.connectionTimeout) {
        print("Connection timeout");
        Services().showCustomSnackBar(context, "Connection timeout. Please check your internet connection");
      } else {
        final errorData = e.response!.data['errors'];
        print("Status code: ${e.response!.statusCode}");
        print("Error: $errorData");
        if (errorData['non_field_errors'] != null) {
          print(errorData['non_field_errors'][0]);
          Services().showCustomSnackBar(context, errorData['non_field_errors'][0]);
        }
      }
      return null;
    }
  }

  sendVerificationMail(BuildContext context, String mail) async {
    final formData = {
      "email": mail,
    };

    try {
      final dio = Dio();
      dio.options.connectTimeout = connectionTimeoutDuration;
      final response = await dio.post(
        "$baseUrl${ApiEndPoints.sendVerificationMail}",
        data: formData,
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
      if (e.type == DioExceptionType.connectionTimeout) {
        print("Connection timeout");
        Services().showCustomSnackBar(context, "Connection timeout. Please check your internet connection");
      }
      return null;
    }
  }

  verifyMail(String token) async {
    final params = {
      "token": token,
    };

    try {
      final dio = Dio();
      dio.options.connectTimeout = connectionTimeoutDuration;
      final response = await dio.post(
        "$baseUrl${ApiEndPoints.verifyMail}",
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
      if (e.type == DioExceptionType.connectionTimeout) {
        print("Connection timeout");
      }
      return null;
    }
  }

  changePassword(BuildContext context, String password, String confirmPassword) async {
    try {
      final dio = Dio();
      dio.options.connectTimeout = connectionTimeoutDuration;
      final formData = {
        "password": password,
        "password2": confirmPassword,
      };
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      final authToken = sharedPref.getString(ACCESSTOKEN);
      final response = await dio.post(
        "$baseUrl${ApiEndPoints.changePassword}",
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
      // print(e.response!.statusCode);
      if (e.type == DioExceptionType.connectionTimeout) {
        print("Connection timeout");
        Services().showCustomSnackBar(context, "Connection timeout. Please check your internet connection");
      }
      print("Error :${e.response!.data}");
      if (e.response!.statusCode == 401) {
        print("refresh token");
        final refreshedToken = await refreshAccessToken();
        if (refreshedToken != null) {
          changePassword(context, password, confirmPassword);
        }
      }
      return null;
    }
  }

  refreshAccessToken() async {
    log("refreshing access token");
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final refreshToken = sharedPref.getString(REFRESHTOKEN);
    if (refreshToken != null) {
      print("have email and password");
      try {
        print("refreshing token");
        final dio = Dio();
        dio.options.connectTimeout = connectionTimeoutDuration;

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
        if (e.type == DioExceptionType.connectionTimeout) {
          print("Connection timeout");
        } else {
          print("Error :${e.response!.data}");
          print("Error :${e.response!.statusCode}");
          if (e.response!.statusCode == 400 || e.response!.statusCode == 401) {
            log("Going to automatic relogin");
            final autoRelogin = await automaticRelogin();
            print(autoRelogin);
            if (autoRelogin == null) {
              log("failed trying of auto relogin");
            }
          }
        }
      }
      // if (email != null && encryptedPassword != null && !isFailedLogin) {

      return null;
    }
    // } else {
    //   return null;
    // }
  }

  automaticRelogin() async {
    print("Autologin\n.\n.");
    String? email = '';
    String? decrypted = '';

    try {
      final dio = Dio();
      dio.options.connectTimeout = connectionTimeoutDuration;
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      email = sharedPref.getString(EMAIL);
      final encryptedBase64 = sharedPref.getString(ENCRYPTEDPASSWORD);
      log("encrypted :$encryptedBase64");
      if (encryptedBase64 != null) {
        final encrypted = enc.Encrypted.fromBase64(encryptedBase64);
        final decrypter = enc.Encrypter(enc.AES(controller.key));
        decrypted = decrypter.decrypt(encrypted, iv: controller.iv);
        log("Decrypted :$decrypted");
      }
      final response = await dio.post(
        "$baseUrl${ApiEndPoints.loginUser}",
        data: {
          "email": email,
          "password": decrypted,
        },
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Login successful");
      } else {
        print("Unexpected status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      print("Error :$e");
      log("Auto login failed with mail:$email and password $decrypted");
      isFailedLogin = true;
      Get.to(() => SignInScreen());
      return null;
    } catch (e) {
      print("Error:$e");
    }
  }

  getAllProducts(String pageNo) async {
    try {
      print("$baseUrl${ApiEndPoints.getAllProducts}");
      controller.isAllProductsLoadingError.value = false;
      print("Getting products from api");
      final dio = Dio();
      final params = {
        "page": pageNo,
      };
      dio.options.connectTimeout = connectionTimeoutDuration;
      final response = await dio.get(
        "$baseUrl${ApiEndPoints.getAllProducts}",
        queryParameters: params,
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Staus 200");
        log(response.data.toString());
        return response;
      } else {
        print("Unexpected status code: ${response.statusCode}");
        return null;
      }
    } on DioException catch (e) {
      print("Error :$e");
      if (e.type == DioExceptionType.connectionTimeout) {
        print("Connection timeout");
        controller.isAllProductsLoadingError.value = true;
      }
      return null;
    }
  }

  getProductByCategory(String categoryParent, String categoryName) async {
    final params = {
      "product__category__parent__name": categoryParent,
      "product__category__name": categoryName,
    };

    try {
      final dio = Dio();
      dio.options.connectTimeout = connectionTimeoutDuration;
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
      if (e.type == DioExceptionType.connectionTimeout) {
        print("Connection timeout");
      }
      return null;
    }
  }

  getSponserdProducts(String pageNo) async {
    try {
      final dio = Dio();
       final params = {
        "page": pageNo,
      };
      dio.options.connectTimeout = connectionTimeoutDuration;
      final response = await dio.get(
        "$baseUrl${ApiEndPoints.getSponserdProducts}",
        queryParameters: params,
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

  getTrendingProducts(String pageNo) async {
    try {
      final dio = Dio();
      final params = {
        "page": pageNo,
      };
      dio.options.connectTimeout = connectionTimeoutDuration;
      final response = await dio.get(
        "$baseUrl${ApiEndPoints.getTrendingProducts}",
        queryParameters: params,
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

  getBestSellerProducts(String pageNo) async {
    try {
      final dio = Dio();
      final params = {
        "page": pageNo,
      };
      dio.options.connectTimeout = connectionTimeoutDuration;
      final response = await dio.get(
        "$baseUrl${ApiEndPoints.getBestSellerProducts}",
        queryParameters: params,
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

  searchProduct(String searchKey, int minPrice, int maxPrice) async {
    final params = {
      "search": searchKey,
      "min_price": minPrice,
      "max_price": maxPrice,
    };

    try {
      final dio = Dio();
      dio.options.connectTimeout = connectionTimeoutDuration;
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
      if (e.type == DioExceptionType.connectionTimeout) {
        print("Connection timeout");
        controller.isSearchProductError.value = true;
      }
      return null;
    }
  }

  getProductDetails(String id) async {
    try {
      final dio = Dio();
      dio.options.connectTimeout = connectionTimeoutDuration;
      print("Url : $baseUrl${ApiEndPoints.getProductDetails}$id");
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
      print("Error :${e.response}");
      if (e.type == DioExceptionType.connectionTimeout) {
        print("Connection timeout");
      }
      return null;
    }
  }

  getProductReviews(String id) async {
    try {
      final dio = Dio();
      dio.options.connectTimeout = connectionTimeoutDuration;
      final response = await dio.get(
        "$baseUrl${ApiEndPoints.reviews}$id/list/",
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

  getAverageStarRatings(String id) async {
    try {
      final dio = Dio();
      dio.options.connectTimeout = connectionTimeoutDuration;
      final response = await dio.get(
        "$baseUrl${ApiEndPoints.reviews}$id/average-rating/",
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
      dio.options.connectTimeout = connectionTimeoutDuration;
      final response = await dio.post(
        "$baseUrl${ApiEndPoints.reviews}$id/add-review/",
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
      if (e.type == DioExceptionType.connectionTimeout) {
        print("Connection timeout");
        Services().showCustomSnackBar(context, "Connection timeout. Please check your network connection");
      }
      print("Error :${e.response!.data}");
      // print("Error :${e.response!.data['error']}");
      Services().showCustomSnackBar(context, e.response!.data['error']);
      if (e.response!.statusCode == 401) {
        print("refresh token");
        final refreshedToken = await refreshAccessToken();
        if (refreshedToken != null) {
          addProductReview(context, id, reviewText, numberOfStars);
        }
      }
      return null;
    }
  }

  getProfileDetails() async {
    try {
      final dio = Dio();
      dio.options.connectTimeout = connectionTimeoutDuration;
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
        final refreshedToken = await refreshAccessToken();
        if (refreshedToken != null) {
          getProfileDetails();
        }
      }
      return null;
    }
  }

  getCartList() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final authToken = sharedPref.getString(ACCESSTOKEN);
    final email = await sharedPref.getString(EMAIL);
    final encryptedPassword = await sharedPref.getString(ENCRYPTEDPASSWORD);
    // if (email != null && encryptedPassword != null) {
    print("have email and password");
    try {
      final dio = Dio();
      dio.options.connectTimeout = connectionTimeoutDuration;
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
        print("refreshing token");
        final refreshedToken = await refreshAccessToken();
        if (refreshedToken != null) {
          print(refreshedToken);
          getCartList();
        }
      }
      return null;
    }
  }

  addProductToCart(BuildContext context, String productId) async {
    try {
      final dio = Dio();
      dio.options.connectTimeout = connectionTimeoutDuration;
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
        final refreshedToken = await refreshAccessToken();
        if (refreshedToken != null) {
          addProductToCart(context, productId);
        }
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
      dio.options.connectTimeout = connectionTimeoutDuration;
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
        final refreshedToken = await refreshAccessToken();
        if (refreshedToken != null) {
          removeFromCart(context, productId);
        }
      }
      return null;
    }
  }

  updateCartCount(String productId, int newCount) async {
    try {
      print("Trying to remove from cart:{$baseUrl${ApiEndPoints.updateCartCount}$productId/}");
      final dio = Dio();
      dio.options.connectTimeout = connectionTimeoutDuration;
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
        final refreshedToken = await refreshAccessToken();
        if (refreshedToken != null) {
          updateCartCount(productId, newCount);
        }
      }
      return null;
    }
  }

  createUserAddress(BuildContext context, String streetAddress, String city, String state, String postalCode, bool isDefaultAddress) async {
    final Map<String, dynamic> formData = {
      "street_address": streetAddress,
      "city": city,
      "state": state,
      "postal_code": postalCode,
      "is_default": isDefaultAddress,
    };

    try {
      final dio = Dio();
      dio.options.connectTimeout = connectionTimeoutDuration;
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
        // getUserAddresses();
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
        final refreshedToken = await refreshAccessToken();
        if (refreshedToken != null) {
          createUserAddress(context, streetAddress, city, state, postalCode, isDefaultAddress);
        }
      }
      if (e.response!.statusCode == 400) {
        Services().showCustomSnackBar(context, "Please fill all the fields!");
      }
      return null;
    }
  }

  getUserAddresses() async {
    try {
      final dio = Dio();
      dio.options.connectTimeout = connectionTimeoutDuration;
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
        final refreshedToken = await refreshAccessToken();
        if (refreshedToken != null) {
          getUserAddresses();
        }
      }
      return null;
    }
  }

  editUserAddress(BuildContext context, String id, String streetAddress, String city, String state, String postalCode, bool isDefaultAddress) async {
    try {
      final dio = Dio();
      dio.options.connectTimeout = connectionTimeoutDuration;
      final Map<String, dynamic> formData = {
        "street_address": streetAddress,
        "city": city,
        "state": state,
        "postal_code": postalCode,
        "is_default": isDefaultAddress,
      };
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      final authToken = sharedPref.getString(ACCESSTOKEN);
      final response = await dio.put(
        "$baseUrl${ApiEndPoints.address}$id/",
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
        Services().showCustomSnackBar(context, "Address updated successfully");
        return response;
      } else {
        print("Unexpected status code: ${response.statusCode}");
        return null;
      }
    } on DioException catch (e) {
      print("Error :$e");
      if (e.response!.statusCode == 401) {
        print("refresh token");
        final refreshedToken = await refreshAccessToken();
        if (refreshedToken != null) {
          getUserAddresses();
        }
      }
      return null;
    }
  }

  deleteUserAddress(String id) async {
    try {
      print("deleting address with id : $id");
      print("$baseUrl${ApiEndPoints.address}$id");
      final dio = Dio();
      dio.options.connectTimeout = connectionTimeoutDuration;
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      final authToken = sharedPref.getString(ACCESSTOKEN);
      final response = await dio.delete(
        "$baseUrl${ApiEndPoints.address}$id/",
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type': Headers.jsonContentType,
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 204) {
        log(response.data.toString());
        print("deleted address");

        return response;
      } else {
        print("Unexpected status code: ${response.statusCode}");
        return null;
      }
    } on DioException catch (e) {
      print("Error :$e");
      if (e.response!.statusCode == 401) {
        print("refresh token");
        final refreshedToken = await refreshAccessToken();
        if (refreshedToken != null) {
          deleteUserAddress(id);
        }
      }
      return null;
    }
  }
}
