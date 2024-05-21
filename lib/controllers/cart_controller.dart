import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_sample/models/cart_product_model.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/services/api_services.dart';

class CartController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;

    Rx<CartProductModel> cartProducts = CartProductModel(count: 0, next: null, previous: null, results: []).obs;


  getCartList() async {
    isLoading.value = true;
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

    isLoading.value = false;
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
}
