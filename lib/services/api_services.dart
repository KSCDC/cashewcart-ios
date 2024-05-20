import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as enc;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:internship_sample/controllers/app_controller.dart';

import 'package:internship_sample/core/base_url.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/core/end_points.dart';
import 'package:internship_sample/presentation/authentication/signin_screen.dart';
import 'package:internship_sample/presentation/main_page/main_page_screen.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
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
        // log(response.data.toString());
        return response;
      } else {
        print("Unexpected status code: ${response.statusCode}");
        return null;
      }
    } on DioException catch (e) {
      print("Error :${e.response!.data}");
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
        // log(response.data.toString());
        return response;
      } else {
        print("Unexpected status code: ${response.statusCode}");
        return null;
      }
    } on DioException catch (e) {
      print("Error :${e.response!.data}");
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
        // log(response.data.toString());

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
    //log("refreshing access token");
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
          // log(response.data.toString());
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
            //log("Going to automatic relogin");
            final autoRelogin = await automaticRelogin();
            print(autoRelogin);
            // if (autoRelogin == null) {
            //   //log("failed trying of auto relogin");
            // }
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
      final keyString = sharedPref.getString('ENCRYPTION_KEY');
      final ivString = sharedPref.getString('ENCRYPTION_IV');

      // decoding the stored key for decrypting password
      final keyBytes = base64.decode(keyString!);
      final ivBytes = base64.decode(ivString!);
      final key = enc.Key(keyBytes);
      final iv = enc.IV(ivBytes);
      //log("encrypted :$encryptedBase64");
      if (encryptedBase64 != null) {
        final encrypted = enc.Encrypted.fromBase64(encryptedBase64);
        final decrypter = enc.Encrypter(enc.AES(key));
        //log("decrypting");
        decrypted = decrypter.decrypt(encrypted, iv: iv);
        //log("Decrypted :$decrypted");
      }
      print("Email : $email, password: $decrypted");
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
        final accessToken = response.data['token']['access'];
        final refreshToken = response.data['token']['refresh'];
        print("access token :$accessToken\nrefresh token :$refreshToken");
        SharedPreferences sharedPref = await SharedPreferences.getInstance();
        sharedPref.setString(ACCESSTOKEN, accessToken);
        sharedPref.setString(REFRESHTOKEN, refreshToken);
      } else {
        print("Unexpected status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      print("Error :$e");
      //log("Auto login failed with mail:$email");
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
        // log(response.data.toString());
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

  getProductByCategory(String categoryParent, String categoryName, String pageNo) async {
    // log("Getting by cat");
    final params = {
      "product__category__parent__name": categoryParent,
      "product__category__name": categoryName,
      "page": pageNo,
    };
    //log("calling $baseUrl${ApiEndPoints.filterProduct}");
    // log(categoryParent);
    // log(categoryName);
    // print(pageNo);
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
      print("resposne :${response.data}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        // log(response.data.toString());
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

  searchProduct(String searchKey, int minPrice, int maxPrice, String pageNo) async {
    final params = {
      "search": searchKey,
      "min_price": minPrice,
      "max_price": maxPrice,
      "page": pageNo,
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
        // log(response.data.toString());
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
        // log(response.data.toString());
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
        // log(response.data.toString());
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
        // log(response.data.toString());
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
        // log(response.data.toString());
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
        // log(response.data.toString());
        cartCountNotifier.value++;
        final snackBar = SnackBar(
          content: SizedBox(
            height: 35.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextWidget(
                  text: "Product added to cart",
                  fontColor: Colors.white,
                ),
                TextButton(
                  onPressed: () {
                    // bottomNavbarIndexNotifier.value = 2;
                    Get.to(() => MainPageScreen());
                  },
                  child: CustomTextWidget(
                    text: "Go to Cart",
                    fontColor: kMainThemeColor,
                  ),
                )
              ],
            ),
          ),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(20),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
        if (e.response!.data["errors"]["non_field_errors"] != null) {
          // Services().showCustomSnackBar(context, "message");
          final snackBar = SnackBar(
            content: SizedBox(
              height: 35.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 220.w,
                    child: CustomTextWidget(
                      text: e.response!.data["errors"]["non_field_errors"][0].toString(),
                      fontColor: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // bottomNavbarIndexNotifier.value = 2;
                      Get.to(() => MainPageScreen());
                    },
                    child: CustomTextWidget(
                      text: "Go to Cart",
                      fontColor: kMainThemeColor,
                    ),
                  )
                ],
              ),
            ),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(20),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
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
        // log(response.data.toString());
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
        // log(response.data.toString());
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

  createUserAddress(BuildContext context, String name, String streetAddress, String region, String district, String state, String postalCode, String phoneNumber, bool isDefaultAddress) async {
    final Map<String, dynamic> formData = {
      "name": name,
      "street_address": streetAddress,
      "region": region,
      "district": district,
      "state": state,
      "postal_code": postalCode,
      "phone_number": phoneNumber,
      "is_default": isDefaultAddress,
    };
    print("\n$streetAddress\n$region\n$district\n$state\n$state\n$postalCode\n");

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
      print("Error :${e.response!.data}");
      if (e.response!.statusCode == 401) {
        print("refresh token");
        final refreshedToken = await refreshAccessToken();
        if (refreshedToken != null) {
          createUserAddress(context, name, streetAddress, region, district, state, postalCode, phoneNumber, isDefaultAddress);
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
        // log(response.data.toString());
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

  editUserAddress(
      BuildContext context, String id, String name, String streetAddress, String region, String district, String state, String postalCode, String phoneNumber, bool isDefaultAddress) async {
    try {
      //log("Editing address id $id");
      final dio = Dio();
      dio.options.connectTimeout = connectionTimeoutDuration;
      final Map<String, dynamic> formData = {
        "name": name,
        "street_address": streetAddress,
        "region": region,
        "district": district,
        "state": state,
        "postal_code": postalCode,
        "phone_number": phoneNumber,
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
        // log(response.data.toString());
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
        // log(response.data.toString());
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

  placeOrder(String shippingAddressId, String billingAddressId) async {
    try {
      final dio = Dio();
      dio.options.connectTimeout = connectionTimeoutDuration;
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      final authToken = sharedPref.getString(ACCESSTOKEN);
      final params = {
        "shipping_address": shippingAddressId,
        "billing_address": billingAddressId,
      };
      final response = await dio.post(
        "$baseUrl${ApiEndPoints.placeOrder}",
        queryParameters: params,
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type': Headers.jsonContentType,
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 204) {
        // log(response.data.toString());

        return response;
      } else {
        print("Unexpected status code: ${response.statusCode}");
        return null;
      }
    } on DioException catch (e) {
      print("Error :${e.response}");
      if (e.response!.statusCode == 401) {
        print("refresh token");
        final refreshedToken = await refreshAccessToken();
        if (refreshedToken != null) {
          placeOrder(shippingAddressId, billingAddressId);
        }
      }
      return null;
    }
  }

  payment(String orderId) async {
    try {
      final dio = Dio();
      dio.options.connectTimeout = connectionTimeoutDuration;
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      final authToken = sharedPref.getString(ACCESSTOKEN);

      final response = await dio.post(
        "$baseUrl${ApiEndPoints.payment}$orderId/",
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type': Headers.jsonContentType,
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 204) {
        // log(response.data.toString());

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
          payment(orderId);
        }
      }
      return null;
    }
  }

  verifyPayment(String signature, String orderId, String paymentId) async {
    final Map<String, dynamic> formData = {
      "razorpay_signature": signature,
      "razorpay_order_id": orderId,
      "razorpay_payment_id": paymentId,
    };

    try {
      final dio = Dio();
      dio.options.connectTimeout = connectionTimeoutDuration;

      final response = await dio.post(
        "$baseUrl${ApiEndPoints.verifyPayment}",
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // log(response.data.toString());
        return response;
      } else {
        print("Unexpected status code: ${response.statusCode}");
        return null;
      }
    } on DioException catch (e) {
      print("Error :${e.response}");

      return null;
    }
  }

  getOrdersList(String pageNo) async {
    try {
      // controller.isError.value = false;

      final dio = Dio();
      final params = {
        "page": pageNo,
      };
      dio.options.connectTimeout = connectionTimeoutDuration;
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      final authToken = sharedPref.getString(ACCESSTOKEN);
      final response = await dio.get(
        "$baseUrl${ApiEndPoints.ordersList}",
        queryParameters: params,
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type': Headers.jsonContentType,
          },
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
      if (e.type == DioExceptionType.connectionTimeout) {
        print("Connection timeout");
        // controller.isError.value = true;
      }
      if (e.response!.statusCode == 401) {
        print("refresh token");
        final refreshedToken = await refreshAccessToken();
        if (refreshedToken != null) {
          getOrdersList(pageNo);
        }
      }
      return null;
    }
  }
}
