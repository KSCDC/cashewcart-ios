import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/controllers/product_details_controller.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/main.dart';
import 'package:internship_sample/models/product_details_model.dart';
import 'package:internship_sample/models/trending_product_model.dart';
import 'package:internship_sample/presentation/authentication/signin_screen.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/shop/shop_screen.dart';
import 'package:internship_sample/presentation/widgets/add_or_edit_address.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/services/api_services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Services {
  AppController controller = Get.put(AppController());
  ProductDetailsController productDetailsController = Get.put(ProductDetailsController());
  void showCustomSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: CustomTextWidget(
        text: message,
        fontColor: Colors.white,
      ),
      // behavior: SnackBarBehavior.floating,
      // margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  showAddressEditPopup(
      bool addNewAddress,
      BuildContext context,
      String id,
      String heading,
      String buttonLabel,
      TextEditingController nameController,
      TextEditingController cityController,
      TextEditingController addressController,
      // TextEditingController districtController,
      // TextEditingController stateController,
      TextEditingController postalcodeController,
      TextEditingController phoneNumberController) {
    return Alert(
        context: context,
        title: heading,
        content: AddOrEditAddress(
            nameController: nameController,
            cityController: cityController,
            addressController: addressController,
            postalcodeController: postalcodeController,
            phoneNumberController: phoneNumberController,
            state: controller.state,
            district: controller.district),
        buttons: [
          DialogButton(
            onPressed: () async {
              final response;
              if (addNewAddress) {
                response = await ApiServices().createUserAddress(
                    context, nameController.text, cityController.text, addressController.text, controller.district!, controller.state!, postalcodeController.text, phoneNumberController.text, false);
              } else {
                response = await ApiServices().editUserAddress(context, id, nameController.text, cityController.text, addressController.text, controller.district!, controller.state!,
                    postalcodeController.text, phoneNumberController.text, false);
              }

              if (response != null) {
                Services().showCustomSnackBar(context, addNewAddress ? "Address added successfully" : "Address edited successfully");
                controller.getUserAddresses();
                Navigator.pop(context);
              }
            },
            color: kMainThemeColor,
            child: Text(
              buttonLabel,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  showLoginAlert(BuildContext context, String description) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "NO ACCESS",
      desc: description,
      buttons: [
        DialogButton(
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "Login",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Get.to(() => SignInScreen()),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0),
          ]),
        )
      ],
    ).show();
  }

  getProductDetailsAndGotoShopScreen(BuildContext context, String productId) async {
    context.loaderOverlay.show();
    final ProductDetailsModel productDetails = await productDetailsController.getProductDetails(productId);
    final Random _random = Random();
    int randomIndex;
    randomIndex = _random.nextInt(3);
    context.loaderOverlay.hide();

    print("rand index ======================= $randomIndex");
    // when using cupertino tabbar view for bottomnavbar, if we want persistent navbar then need to use navigatior instead of get.to
    final List<TrendingProductModel> randomProductList;

    switch (randomIndex) {
      case 0:
        randomProductList = controller.trending;
        break;
      case 1:
        randomProductList = controller.sponserd;
        break;
      case 2:
        randomProductList = controller.bestSellers;
        break;
      default:
        randomProductList = controller.bestSellers;
    }
    print("Random number \n::::\n:::\n:: $randomIndex");
    controller.getSimilarProducts(productDetails.name, productDetails.category.parentName);
    productDetailsController.getProductReviews(productId);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ShopScreen(
          randomIndex: randomIndex,
          randomProductList: randomProductList,
          productDetails: productDetails,
        ),
      ),
    );

    // controller.productDetailsList.add(controller.productDetails.value!);

    // previousPageIndexes.add(bottomNavbarIndexNotifier.value);
    // bottomNavbarIndexNotifier.value = 4;
  }
}
