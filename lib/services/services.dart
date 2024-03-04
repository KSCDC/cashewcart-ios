import 'package:flutter/material.dart';
import 'package:internship_sample/services/api_services.dart';

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

  void showAddressPopup(BuildContext context) {
    final TextEditingController streetController = TextEditingController();
    final TextEditingController cityController = TextEditingController();
    final TextEditingController stateController = TextEditingController();
    final TextEditingController postalCodeController = TextEditingController();
    // final TextEditingController countryController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          // width: MediaQuery.of(context).size.width * 0.9,
          child: AlertDialog(
            title: Text('Add Address'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: streetController,
                  decoration: InputDecoration(hintText: 'Street Address'),
                ),
                TextField(
                  controller: cityController,
                  decoration: InputDecoration(hintText: 'City'),
                ),
                TextField(
                  controller: stateController,
                  decoration: InputDecoration(hintText: 'State'),
                ),
                TextField(
                  controller: postalCodeController,
                  decoration: InputDecoration(hintText: 'Postal Code'),
                ),
                // TextField(
                //   controller: countryController,
                //   decoration: InputDecoration(hintText: 'Country'),
                // ),
                TextButton(
                  onPressed: () {
                    // Save the values from text controllers
                    String street = streetController.text;
                    String city = cityController.text;
                    String state = stateController.text;
                    String postalCode = postalCodeController.text;
                    // String country = countryController.text;

                    // Do something with the values
                    print('Street: $street');
                    print('City: $city');
                    print('State: $state');
                    print('Postal Code: $postalCode');
                    // print('Country: $country');
                    final response = ApiServices().createUserAddress(context, street, city, state, postalCode, false);
                    // Close the dialog
                    if (response != null) {
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
