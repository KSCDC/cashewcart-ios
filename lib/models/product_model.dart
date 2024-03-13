class ProductModel {
  ProductModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });
    int? count;
  String? next;
  String? previous;
  List<Results>? results;

  ProductModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = null;
    previous = null;
    results = List.from(json['results']).map((e) => Results.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['count'] = count;
    _data['next'] = next;
    _data['previous'] = previous;
    _data['results'] = results!.map((e) => e.toJson()).toList();
    return _data;
  }

  ProductModel copyWith({
    int? count,
    dynamic next,
    dynamic previous,
    List<Results>? results,
  }) {
    return ProductModel(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? List.from(this.results!),
    );
  }
}

class Results {
  Results({
    required this.id,
    required this.product,
    required this.weightInGrams,
    required this.actualPrice,
    required this.sellingPrice,
    required this.sku,
    required this.stockQty,
  });
  late final int id;
  late final Product product;
  late final String weightInGrams;
  late final String actualPrice;
  late final String sellingPrice;
  late final String sku;
  late final int stockQty;

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = Product.fromJson(json['product']);
    weightInGrams = json['weight_in_grams'];
    actualPrice = json['actual_price'];
    sellingPrice = json['selling_price'];
    sku = json['sku'];
    stockQty = json['stock_qty'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['product'] = product.toJson();
    _data['weight_in_grams'] = weightInGrams;
    _data['actual_price'] = actualPrice;
    _data['selling_price'] = sellingPrice;
    _data['sku'] = sku;
    _data['stock_qty'] = stockQty;
    return _data;
  }
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.productImages,
  });
  late final int id;
  late final String name;
  late final String description;
  late final Category category;
  late final List<dynamic> productImages;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    category = Category.fromJson(json['category']);
    productImages = List.castFrom<dynamic, dynamic>(json['product_images']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['description'] = description;
    _data['category'] = category.toJson();
    _data['product_images'] = productImages;
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
  late final String? parentName;
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
