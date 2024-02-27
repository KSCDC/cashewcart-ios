import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/presentation/main_page/main_page_screen.dart';
import 'package:internship_sample/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppController extends GetxController {
  RxBool isLoading = false.obs;

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
      Get.to(() => MainPageScreen());
    }
  }

  loginUser(BuildContext context, String email, String pasword) async {
    isLoading.value = true;
    final response = await ApiServices().loginUser(context, email, pasword);
    if (response == null) {
      isLoading.value = false;
    } else {
      log(response.data.toString());
      final accessToken = response.data['token']['access'];
      final refreshToken = response.data['token']['refresh'];
      print("access token :$accessToken\nrefresh token :$refreshToken");
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      sharedPref.setString(ACCESSTOKEN, accessToken);
      sharedPref.setString(REFRESHTOKEN, refreshToken);
      isLoading.value = false;
      Get.to(() => MainPageScreen());
    }
  }
}
