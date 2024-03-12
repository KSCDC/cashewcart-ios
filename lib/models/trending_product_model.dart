// To parse this JSON data, do
//
//     final trendingProductModel = trendingProductModelFromJson(jsonString);

import 'dart:convert';

TrendingProductModel trendingProductModelFromJson(String str) => TrendingProductModel.fromJson(json.decode(str));

String trendingProductModelToJson(TrendingProductModel data) => json.encode(data.toJson());

class TrendingProductModel {
  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  TrendingProductModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory TrendingProductModel.fromJson(Map<String, dynamic> json) => TrendingProductModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  int id;
  ResultProduct product;
  DateTime createdAt;
  DateTime updatedAt;

  Result({
    required this.id,
    required this.product,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        product: ResultProduct.fromJson(json["product"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class ResultProduct {
  int id;
  ProductProduct product;
  String weightInGrams;
  String actualPrice;
  String sellingPrice;
  String cgstRate;
  String sgstRate;
  String sku;
  int stockQty;
  double discountPercentage;

  ResultProduct({
    required this.id,
    required this.product,
    required this.weightInGrams,
    required this.actualPrice,
    required this.sellingPrice,
    required this.cgstRate,
    required this.sgstRate,
    required this.sku,
    required this.stockQty,
    required this.discountPercentage,
  });

  factory ResultProduct.fromJson(Map<String, dynamic> json) => ResultProduct(
        id: json["id"],
        product: ProductProduct.fromJson(json["product"]),
        weightInGrams: json["weight_in_grams"],
        actualPrice: json["actual_price"],
        sellingPrice: json["selling_price"],
        cgstRate: json["cgst_rate"],
        sgstRate: json["sgst_rate"],
        sku: json["sku"],
        stockQty: json["stock_qty"],
        discountPercentage: json["discount_percentage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product.toJson(),
        "weight_in_grams": weightInGrams,
        "actual_price": actualPrice,
        "selling_price": sellingPrice,
        "cgst_rate": cgstRate,
        "sgst_rate": sgstRate,
        "sku": sku,
        "stock_qty": stockQty,
        "discount_percentage": discountPercentage,
      };
}

class ProductProduct {
  int id;
  String name;
  String description;
  Category category;
  List<ProductImage> productImages;

  ProductProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.productImages,
  });

  factory ProductProduct.fromJson(Map<String, dynamic> json) => ProductProduct(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        category: Category.fromJson(json["category"]),
        productImages: List<ProductImage>.from(json["product_images"].map((x) => ProductImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "category": category.toJson(),
        "product_images": List<dynamic>.from(productImages.map((x) => x.toJson())),
      };
}

class Category {
  int id;
  String name;
  String? parentName;
  List<dynamic> children;

  Category({
    required this.id,
    required this.name,
    required this.parentName,
    required this.children,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        parentName: json["parent_name"],
        children: List<dynamic>.from(json["children"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "parent_name": parentName,
        "children": List<dynamic>.from(children.map((x) => x)),
      };
}

class ProductImage {
  String productImage;
  int displayOrder;
  bool isCoverImage;

  ProductImage({
    required this.productImage,
    required this.displayOrder,
    required this.isCoverImage,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        productImage: json["product_image"],
        displayOrder: json["display_order"],
        isCoverImage: json["is_cover_image"],
      );

  Map<String, dynamic> toJson() => {
        "product_image": productImage,
        "display_order": displayOrder,
        "is_cover_image": isCoverImage,
      };
}
