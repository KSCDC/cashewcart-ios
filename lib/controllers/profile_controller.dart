import 'package:get/get.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/models/user_address_model.dart';
import 'package:internship_sample/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  RxBool isLoadingProfile = false.obs;
  RxBool isError = false.obs;
  RxBool isLoadingAddress = false.obs;
  RxBool isLoadingAddressError = false.obs;
  RxString userName = "".obs;
  RxString email = "".obs;
  RxString phoneNo = "".obs;
  String? state = null;
  String? district = null;

  RxList<UserAddressModel> addressList = <UserAddressModel>[].obs;

  getProfileDetails() async {
    isLoadingProfile.value = true;
    isError.value = false;
    final response = await ApiServices().getProfileDetails();
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    if (response != null) {
      userName.value = response.data['name'];
      email.value = response.data['email'];
      phoneNo.value = response.data['phone_number'];
      sharedPref.setString(PHONE, phoneNo.value);
    } else {
      isError.value = true;
    }

    print(userName);
    isLoadingProfile.value = false;
  }

  getUserAddresses() async {
    print("getting addresses");
    isLoadingAddress.value = true;
    isLoadingAddressError.value = false;
    // productReviewsList.clear();
    final List<UserAddressModel> tempList = [];
    final response = await ApiServices().getUserAddresses();

    if (response != null) {
      final List<dynamic> responseData = response.data;
      print(responseData);
      for (final item in responseData) {
        final address = UserAddressModel.fromJson(item);
        tempList.add(address);
      }

      addressList.value = tempList;
      state = addressList[0].state;
      district = addressList[0].district;
    } else {
      isLoadingAddressError.value = true;
    }

    isLoadingAddress.value = false;
  }
}
