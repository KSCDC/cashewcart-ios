import 'package:get/get.dart';
import 'package:internship_sample/models/product_model.dart';
import 'package:internship_sample/services/api_services.dart';

class SearchResultController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSearchMode = false.obs;
  RxBool haveSearchResult = false.obs;

  RxInt minSearchPrice = 0.obs;
  RxInt maxSearchPrice = 5000.obs;

  RxBool isSearchProductError = false.obs;
  RxBool sortProduct = false.obs;
  RxBool sortAscending = false.obs;

  RxList<ProductModel> searchResults = <ProductModel>[].obs;

  searchProducts(String searchKey) async {
    print("Search key: $searchKey");
    isLoading.value = true;
    haveSearchResult.value = false;
    // searchResults.value.results = [];
    final response = await ApiServices().searchProduct(searchKey, minSearchPrice.value, maxSearchPrice.value);

    if (response != null) {
      final List<dynamic> responseData = response.data;
      final List<ProductModel> productList = responseData.map((productData) => ProductModel.fromJson(productData)).toList();
      final Set<String> uniqueProductNames = {};

      final List<ProductModel> newProductList = productList.where((product) {
        final isUnique = uniqueProductNames.add(product.product.name);
        return isUnique;
      }).toList();
      searchResults.value = newProductList.reversed.toList();
      if (sortProduct.value) {
        if (sortAscending.value) {
          searchResults.sort((a, b) => double.parse(a.sellingPrice).compareTo(double.parse(b.sellingPrice)));
        } else {
          searchResults.sort((a, b) => double.parse(b.sellingPrice).compareTo(double.parse(a.sellingPrice)));
        }
      }

      haveSearchResult.value = true;
    } else {
      haveSearchResult.value = false;
    }

    isLoading.value = false;
  }
}
