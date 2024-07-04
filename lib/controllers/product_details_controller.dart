import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cashew_cart/models/product_details_model.dart';
import 'package:cashew_cart/models/product_reviews_model.dart';
import 'package:cashew_cart/services/api_services.dart';

class ProductDetailsController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  // RxBool isLoadedProductDetails = false.obs;
  RxBool isReviewsLoading = false.obs;

  RxBool isReviewsLoadingError = false.obs;

  Rxn<ProductDetailsModel> productDetails = Rxn<ProductDetailsModel>();

  RxList<ProductReviewsModel> productReviewsList = <ProductReviewsModel>[].obs;

  int numOf1Stars = 0;
  int numOf2Stars = 0;
  int numOf3Stars = 0;
  int numOf4Stars = 0;
  int numOf5Stars = 0;

  RxDouble avgRating = 0.0.obs;

  getProductDetails(String id) async {
    isLoading.value = true;
    isError.value = false;
    final response = await ApiServices().getProductDetails(id);
    if (response != null) {
      final data = await ProductDetailsModel.fromJson(response.data);
      productDetails.value = data;
      // isAlreadyLoadedAllProducts = true;
    } else {
      isError.value = true;
    }
    isLoading.value = false;
    return productDetails.value;
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
      getProductReviews(productId);
    }
  }
}
