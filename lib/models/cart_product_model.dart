import 'dart:convert';

CartProductModel cartProductModelFromJson(String str) => CartProductModel.fromJson(json.decode(str));

String cartProductModelToJson(CartProductModel data) => json.encode(data.toJson());

class CartProductModel {
  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  CartProductModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory CartProductModel.fromJson(Map<String, dynamic> json) => CartProductModel(
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
  int purchaseCount;
  String mrp;
  String cgstPrice;
  String sgstPrice;
  String total;

  Result({
    required this.id,
    required this.product,
    required this.purchaseCount,
    required this.mrp,
    required this.cgstPrice,
    required this.sgstPrice,
    required this.total,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        product: ResultProduct.fromJson(json["product"]),
        purchaseCount: json["purchase_count"],
        mrp: json["mrp"],
        cgstPrice: json["cgst_price"],
        sgstPrice: json["sgst_price"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product.toJson(),
        "purchase_count": purchaseCount,
        "cgst_price": cgstPrice,
        "sgst_price": sgstPrice,
        "total": total,
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
  String hsn;
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
    required this.hsn,
    required this.stockQty,
    required this.discountPercentage,
  });

  factory ResultProduct.fromJson(Map<String, dynamic> json) => ResultProduct(
        id: json["product_variant_id"],
        product: ProductProduct.fromJson(json["product"]),
        weightInGrams: json["weight_in_grams"],
        actualPrice: json["actual_price"],
        sellingPrice: json["selling_price"],
        cgstRate: json["cgst_rate"],
        sgstRate: json["sgst_rate"],
        sku: json["sku"],
        hsn: json["hsn_acs"],
        stockQty: json["stock_qty"],
        discountPercentage: json["discount_percentage"]?.toDouble(),
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
        id: json["product_id"],
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
