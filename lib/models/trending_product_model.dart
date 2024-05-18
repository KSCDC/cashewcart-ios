// To parse this JSON data, do
//
//     final trendingProductModel = trendingProductModelFromJson(jsonString);

import 'dart:convert';

TrendingProductModel trendingProductModelFromJson(String str) => TrendingProductModel.fromJson(json.decode(str));

String trendingProductModelToJson(TrendingProductModel data) => json.encode(data.toJson());

class TrendingProductModel {
  int id;
  Product product;
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
        product: Product.fromJson(json["product"]),
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

class Product {
  int productId;
  String metaTagTitle;
  String metaTagDescription;
  String name;
  String description;
  bool newProduct;
  Category category;
  List<ProductImage> productImages;
  num averageRating;

  Product({
    required this.productId,
    required this.metaTagTitle,
    required this.metaTagDescription,
    required this.name,
    required this.description,
    required this.newProduct,
    required this.category,
    required this.productImages,
    required this.averageRating,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["product_id"],
        metaTagTitle: json["meta_tag_title"],
        metaTagDescription: json["meta_tag_description"],
        name: json["name"],
        description: json["description"],
        newProduct: json["new_product"],
        category: Category.fromJson(json["category"]),
        productImages: List<ProductImage>.from(json["product_images"].map((x) => ProductImage.fromJson(x))),
        averageRating: json["average_rating"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "meta_tag_title": metaTagTitle,
        "meta_tag_description": metaTagDescription,
        "name": name,
        "description": description,
        "new_product": newProduct,
        "category": category.toJson(),
        "product_images": List<dynamic>.from(productImages.map((x) => x.toJson())),
        "average_rating": averageRating,
      };
}

class Category {
  int id;
  String name;
  String parentName;
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
