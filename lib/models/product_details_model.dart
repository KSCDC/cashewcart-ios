class ProductDetailsModel {
  ProductDetailsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.productImages,
    required this.productVariants,
  });
  late final int id;
  late final String name;
  late final String description;
  late final Category category;
  late final List<dynamic> productImages;
  late final List<ProductVariants> productVariants;

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    category = Category.fromJson(json['category']);
    productImages = List.castFrom<dynamic, dynamic>(json['product_images']);
    productVariants = List.from(json['product_variants']).map((e) => ProductVariants.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['description'] = description;
    _data['category'] = category.toJson();
    _data['product_images'] = productImages;
    _data['product_variants'] = productVariants.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.parentName,
    required this.children,
  });
  late final int id;
  late final String name;
  late final String parentName;
  late final List<dynamic> children;

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentName = json['parent_name'];
    children = List.castFrom<dynamic, dynamic>(json['children']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['parent_name'] = parentName;
    _data['children'] = children;
    return _data;
  }
}

class ProductVariants {
  ProductVariants({
    required this.id,
    required this.weightInGrams,
    required this.actualPrice,
    required this.sellingPrice,
    required this.sku,
    required this.stockQty,
    required this.isAvailable,
  });
  late final int id;
  late final String weightInGrams;
  late final String actualPrice;
  late final String sellingPrice;
  late final String sku;
  late final int stockQty;
  late final bool isAvailable;

  ProductVariants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    weightInGrams = json['weight_in_grams'];
    actualPrice = json['actual_price'];
    sellingPrice = json['selling_price'];
    sku = json['sku'];
    stockQty = json['stock_qty'];
    isAvailable = json['is_available'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['weight_in_grams'] = weightInGrams;
    _data['actual_price'] = actualPrice;
    _data['selling_price'] = sellingPrice;
    _data['sku'] = sku;
    _data['stock_qty'] = stockQty;
    _data['is_available'] = isAvailable;
    return _data;
  }
}
