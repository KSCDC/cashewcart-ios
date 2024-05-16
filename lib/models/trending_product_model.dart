// To parse this JSON data, do
//
//     final trendingProductModel = trendingProductModelFromJson(jsonString);

import 'dart:convert';

List<TrendingProductModel> trendingProductModelFromJson(String str) => List<TrendingProductModel>.from(json.decode(str).map((x) => TrendingProductModel.fromJson(x)));

String trendingProductModelToJson(List<TrendingProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TrendingProductModel {
  int id;
  TrendingProductModelProduct product;
  DateTime createdAt;
  DateTime updatedAt;

  TrendingProductModel({
    required this.id,
    required this.product,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TrendingProductModel.fromJson(Map<String, dynamic> json) => TrendingProductModel(
        id: json["id"],
        product: TrendingProductModelProduct.fromJson(json["product"]),
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

class TrendingProductModelProduct {
  int productVariantId;
  ProductProduct product;
  String weightInGrams;
  String actualPrice;
  String sellingPrice;
  String cgstRate;
  String sgstRate;
  String sku;
  int stockQty;
  double discountPercentage;

  TrendingProductModelProduct({
    required this.productVariantId,
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

  factory TrendingProductModelProduct.fromJson(Map<String, dynamic> json) => TrendingProductModelProduct(
        productVariantId: json["product_id"],
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
        "product_variant_id": productVariantId,
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
  int productId;
  String name;
  String description;
  Category category;
  List<ProductImage> productImages;
  num averageRating;

  ProductProduct({
    required this.productId,
    required this.name,
    required this.description,
    required this.category,
    required this.productImages,
    required this.averageRating,
  });

  factory ProductProduct.fromJson(Map<String, dynamic> json) => ProductProduct(
        productId: json["product_id"],
        name: json["name"],
        description: json["description"],
        category: Category.fromJson(json["category"]),
        productImages: List<ProductImage>.from(json["product_images"].map((x) => ProductImage.fromJson(x))),
        averageRating: json["average_rating"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "name": name,
        "description": description,
        "category": category.toJson(),
        "product_images": List<dynamic>.from(productImages.map((x) => x.toJson())),
        // "average_rating": averageRating,
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
