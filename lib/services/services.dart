import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/main.dart';
import 'package:internship_sample/models/product_details_model.dart';
import 'package:internship_sample/presentation/authentication/signin_screen.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/shop/shop_screen.dart';
import 'package:internship_sample/presentation/widgets/add_or_edit_address.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/services/api_services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Services {
  AppController controller = Get.put(AppController());
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
      TextEditingController regionController,
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
            regionController: regionController,
            postalcodeController: postalcodeController,
            phoneNumberController: phoneNumberController,
            state: controller.state,
            district: controller.district),
        buttons: [
          DialogButton(
            onPressed: () async {
              final response;
              if (addNewAddress) {
                response = ApiServices().createUserAddress(
                    context, nameController.text, cityController.text, regionController.text, controller.district!, controller.state!, postalcodeController.text, phoneNumberController.text, false);
              } else {
                response = await ApiServices().editUserAddress(context, id, nameController.text, cityController.text, regionController.text, controller.district!, controller.state!,
                    postalcodeController.text, phoneNumberController.text, false);
              }
              // Close the dialog
              if (response != null) {
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
    final ProductDetailsModel productDetails = await controller.getProductDetails(productId);
    // Get.to(() => ShopScreen());

    // when using cupertino tabbar view for bottomnavbar, if we want persistent navbar then need to use navigatior instead of get.to
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShopScreen()));
    // controller.productDetailsList.add(controller.productDetails.value!);
    controller.getSimilarProducts(productDetails.name, productDetails.category.parentName);
    controller.getProductReviews(productId);
    // previousPageIndexes.add(bottomNavbarIndexNotifier.value);
    // bottomNavbarIndexNotifier.value = 4;
  }
}
