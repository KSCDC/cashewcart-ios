import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:internship_sample/core/base_url.dart';
import 'package:internship_sample/core/end_points.dart';
import 'package:internship_sample/presentation/main_page/main_page_screen.dart';
import 'package:internship_sample/services/services.dart';

class ApiServices {
  get endpoint => null;

  registerUser(BuildContext context, String name, String email, String phoneNumber, String pasword) async {
    final Map<String, dynamic> postData = {
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
        data: postData,
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );

      if (response.statusCode == 201) {
        print("Registration successful");
        Services().showCustomSnackBar(context, "Account created successfully");
        return response;
        
      } else {
        print("Unexpected status code: ${response.statusCode}");
        return null;
      }
    } on DioException catch (e) {
      final errorData = e.response!.data['errors'];
      print("Error :$e");
      print("Error: ${errorData}");
      if (errorData['phone_number'] != null) {
        print(errorData['phone_number'][0]);
        Services().showCustomSnackBar(context, errorData['phone_number'][0]);
      }
      if (errorData['email'] != null) {
        print(errorData['email'][0]);
        Services().showCustomSnackBar(context, errorData['email'][0]);
      }
      return null;
    }
  }
}
