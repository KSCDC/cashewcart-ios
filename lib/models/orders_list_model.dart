import 'dart:convert';

List<OrdersListModel> ordersListModelFromJson(String str) => List<OrdersListModel>.from(json.decode(str).map((x) => OrdersListModel.fromJson(x)));

String ordersListModelToJson(List<OrdersListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrdersListModel {
  int orderId;
  int user;
  String invoiceNumber;
  String shippingName;
  String shippingPhoneNumber;
  String shippingStreetAddress;
  String shippingRegion;
  String shippingDistrict;
  String shippingState;
  String shippingPostalCode;
  String billingName;
  String billingStreetAddress;
  String billingRegion;
  String billingDistrict;
  String billingState;
  String billingPostalCode;
  String billingPhoneNumber;
  String paymentMethod;
  String paymentStatus;
  DateTime createdAt;
  num subTotalAmount;
  num deliveryAdditionalAmount;
  num totalAmount;
  String status;
  List<Item> items;

  OrdersListModel({
    required this.orderId,
    required this.user,
    required this.invoiceNumber,
    required this.shippingName,
    required this.shippingPhoneNumber,
    required this.shippingStreetAddress,
    required this.shippingRegion,
    required this.shippingDistrict,
    required this.shippingState,
    required this.shippingPostalCode,
    required this.billingName,
    required this.billingStreetAddress,
    required this.billingRegion,
    required this.billingDistrict,
    required this.billingState,
    required this.billingPostalCode,
    required this.billingPhoneNumber,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.createdAt,
    required this.subTotalAmount,
    required this.deliveryAdditionalAmount,
    required this.totalAmount,
    required this.status,
    required this.items,
  });

  factory OrdersListModel.fromJson(Map<String, dynamic> json) => OrdersListModel(
        orderId: json["order_id"],
        user: json["user"],
        invoiceNumber: json["invoice_number"],
        shippingName: json["shipping_name"],
        shippingPhoneNumber: json["shipping_phone_number"],
        shippingStreetAddress: json["shipping_street_address"],
        shippingRegion: json["shipping_region"],
        shippingDistrict: json["shipping_district"],
        shippingState: json["shipping_state"],
        shippingPostalCode: json["shipping_postal_code"],
        billingName: json["billing_name"],
        billingStreetAddress: json["billing_street_address"],
        billingRegion: json["billing_region"],
        billingDistrict: json["billing_district"],
        billingState: json["billing_state"],
        billingPostalCode: json["billing_postal_code"],
        billingPhoneNumber: json["billing_phone_number"],
        paymentMethod: json["payment_method"],
        paymentStatus: json["payment_status"],
        createdAt: DateTime.parse(json["created_at"]),
        subTotalAmount: json["sub_total_amount"],
        deliveryAdditionalAmount: json["delivery_additional_amount"],
        totalAmount: json["total_amount"],
        status: json["status"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "user": user,
        "invoice_number": invoiceNumber,
        "shipping_name": shippingName,
        "shipping_phone_number": shippingPhoneNumber,
        "shipping_street_address": shippingStreetAddress,
        "shipping_region": shippingRegion,
        "shipping_district": shippingDistrict,
        "shipping_state": shippingState,
        "shipping_postal_code": shippingPostalCode,
        "billing_name": billingName,
        "billing_street_address": billingStreetAddress,
        "billing_region": billingRegion,
        "billing_district": billingDistrict,
        "billing_state": billingState,
        "billing_postal_code": billingPostalCode,
        "billing_phone_number": billingPhoneNumber,
        "payment_method": paymentMethod,
        "payment_status": paymentStatus,
        "created_at": createdAt.toIso8601String(),
        "sub_total_amount": subTotalAmount,
        "delivery_additional_amount": deliveryAdditionalAmount,
        "total_amount": totalAmount,
        "status": status,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  ItemProduct product;
  int purchaseCount;
  String cgstPrice;
  String sgstPrice;
  String mrp;
  String total;

  Item({
    required this.product,
    required this.purchaseCount,
    required this.cgstPrice,
    required this.sgstPrice,
    required this.mrp,
    required this.total,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        product: ItemProduct.fromJson(json["product"]),
        purchaseCount: json["purchase_count"],
        cgstPrice: json["cgst_price"],
        sgstPrice: json["sgst_price"],
        mrp: json["mrp"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "product": product.toJson(),
        "purchase_count": purchaseCount,
        "cgst_price": cgstPrice,
        "sgst_price": sgstPrice,
        "mrp": mrp,
        "total": total,
      };
}

class ItemProduct {
  int productVariantId;
  ProductProduct product;
  String weightInGrams;
  String actualPrice;
  String sellingPrice;
  String cgstRate;
  String sgstRate;
  String sku;
  int stockQty;
  num discountPercentage;

  ItemProduct({
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

  factory ItemProduct.fromJson(Map<String, dynamic> json) => ItemProduct(
        productVariantId: json["product_variant_id"],
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

  ProductProduct({
    required this.productId,
    required this.name,
    required this.description,
    required this.category,
    required this.productImages,
  });

  factory ProductProduct.fromJson(Map<String, dynamic> json) => ProductProduct(
        productId: json["product_id"],
        name: json["name"],
        description: json["description"],
        category: Category.fromJson(json["category"]),
        productImages: List<ProductImage>.from(json["product_images"].map((x) => ProductImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "name": name,
        "description": description,
        "category": category.toJson(),
        "product_images": List<dynamic>.from(productImages.map((x) => x.toJson())),
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
        parentName: json["parent_name"] ?? "",
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
