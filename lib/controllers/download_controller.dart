import 'package:get/get.dart';
import 'package:cashew_cart/models/product_model.dart';
import 'package:cashew_cart/services/api_services.dart';

class DownloadController extends GetxController {
  RxBool isLoading = false.obs;

  downloadInvoice(String orderId) async {
    try {
      isLoading.value = true;
      await ApiServices().getInvoice(orderId);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }
}
