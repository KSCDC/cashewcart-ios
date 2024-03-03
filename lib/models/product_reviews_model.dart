// To parse this JSON data, do
//
//     final productReviewsModel = productReviewsModelFromJson(jsonString);

import 'dart:convert';

ProductReviewsModel productReviewsModelFromJson(String str) => ProductReviewsModel.fromJson(json.decode(str));

String productReviewsModelToJson(ProductReviewsModel data) => json.encode(data.toJson());

class ProductReviewsModel {
  int id;
  int product;
  String userName;
  String reviewText;
  int stars;
  DateTime createdAt;

  ProductReviewsModel({
    required this.id,
    required this.product,
    required this.userName,
    required this.reviewText,
    required this.stars,
    required this.createdAt,
  });

  factory ProductReviewsModel.fromJson(Map<String, dynamic> json) => ProductReviewsModel(
        id: json["id"],
        product: json["product"],
        userName: json["user_name"],
        reviewText: json["review_text"],
        stars: json["stars"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product,
        "user_name": userName,
        "review_text": reviewText,
        "stars": stars,
        "created_at": createdAt.toIso8601String(),
      };
}
