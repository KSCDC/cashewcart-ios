import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/presentation/authentication/signin_screen.dart';
import 'package:internship_sample/services/api_services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Services {
  void showCustomSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  showAddressEditPopup(bool addNewAddress, BuildContext context, String id, String heading, String buttonLabel, TextEditingController streetAddressConrller, TextEditingController cityController,
      TextEditingController postalcodeController, TextEditingController stateController) {
    return Alert(
        context: context,
        title: heading,
        content: Column(
          children: <Widget>[
            TextField(
              controller: streetAddressConrller,
              decoration: InputDecoration(
                labelText: 'Street Address',
              ),
            ),
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                labelText: 'City',
              ),
            ),
            TextField(
              controller: postalcodeController,
              decoration: InputDecoration(
                labelText: 'Postal Code',
              ),
            ),
            TextField(
              controller: stateController,
              decoration: InputDecoration(
                labelText: 'State',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () async {
              final response;
              if (addNewAddress) {
                response = ApiServices().createUserAddress(context, streetAddressConrller.text, cityController.text, stateController.text, postalcodeController.text, false);
              } else {
                response = await ApiServices().editUserAddress(context, id, streetAddressConrller.text, cityController.text, stateController.text, postalcodeController.text, false);
              }
              // Close the dialog
              if (response != null) {
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
}
