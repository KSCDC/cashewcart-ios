// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  int productVariantId;
  Product product;
  String weightInGrams;
  String actualPrice;
  String sellingPrice;
  String cgstRate;
  String sgstRate;
  String sku;
  int stockQty;
  double discountPercentage;

  ProductModel({
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

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        productVariantId: json["product_variant_id"],
        product: Product.fromJson(json["product"]),
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

class Product {
  int productId;
  String name;
  String description;
  Category category;
  List<ProductImage> productImages;
  num averageRating;

  Product({
    required this.productId,
    required this.name,
    required this.description,
    required this.category,
    required this.productImages,
    required this.averageRating,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
        id: json["id"] ?? 0, // Use a default value if the id is null
        name: json["name"] ?? "", // Use a default value if the name is null
        parentName: json["parent_name"] ?? "", // Use a default value if the parentName is null
        children: json["children"] != null ? List<dynamic>.from(json["children"]) : [], // Use an empty list if children is null
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
