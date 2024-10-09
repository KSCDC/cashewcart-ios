import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cashew_cart/controllers/app_controller.dart';
import 'package:cashew_cart/controllers/profile_controller.dart';
import 'package:cashew_cart/core/colors.dart';
import 'package:cashew_cart/core/constants.dart';
import 'package:cashew_cart/presentation/shop/widgets/custom_text_icon_button.dart';
import 'package:cashew_cart/presentation/widgets/custom_elevated_button.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';
import 'package:cashew_cart/services/api_services.dart';
import 'package:cashew_cart/services/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddressSection extends StatelessWidget {
  AddressSection({
    super.key,
    required this.screenSize,
    required this.heading,
    required this.selectedRadioNotifier,
  });

  final Size screenSize;
  final String heading;
  final ValueNotifier<int> selectedRadioNotifier;
  AppController controller = Get.put(AppController());
  ProfileController profileController = Get.put(ProfileController());
  TextEditingController _nameController = TextEditingController();
  TextEditingController _streetAddressController = TextEditingController();
  TextEditingController _regionController = TextEditingController();
  TextEditingController _districtController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _postalcodeController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          // height: screenSize.width * 0.32,
          width: screenSize.width * 0.8,
          child: Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 15,
              ),
              kWidth,
              CustomTextWidget(
                text: heading,
                fontweight: FontWeight.w600,
              ),
            ],
          ),
        ),
        Obx(() {
          return Column(
            children: List.generate(
              profileController.addressList.length,
              (index) {
                final currentAddress = profileController.addressList[index];

                return Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // height: screenSize.width * 0.32,
                        padding: EdgeInsets.all(10),
                        width: screenSize.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomTextWidget(
                                    text: "Address :${index + 1}",
                                    fontSize: 12,
                                    fontweight: FontWeight.w600,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      showDeleteWarning(context, index);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                              kHeight,
                              GestureDetector(
                                onTap: () {
                                  _nameController.text = currentAddress.name;
                                  _streetAddressController.text = currentAddress.streetAddress;
                                  _regionController.text = currentAddress.region;
                                  profileController.district = currentAddress.district;
                                  profileController.state = currentAddress.state;
                                  _postalcodeController.text = currentAddress.postalCode;
                                  _phoneNumberController.text = currentAddress.phoneNumber;
                                  Services().showAddressEditBottomSheet(
                                    false,
                                    context,
                                    currentAddress.id.toString(),
                                    "EDIT ADDRESS",
                                    "EDIT",
                                    _nameController,
                                    _streetAddressController,
                                    _regionController,
                                    _postalcodeController,
                                    _phoneNumberController,
                                  );
                                },
                                child: CustomTextWidget(
                                  text:
                                      "${currentAddress.name},\n${currentAddress.region},\n${currentAddress.streetAddress},\n${currentAddress.district} (Dt), ${currentAddress.state} state,\nPin: ${currentAddress.postalCode}\nPh: ${currentAddress.phoneNumber}",
                                ),
                                // child: CustomTextWidget(
                                //   text: "${currentAddress.streetAddress}, ${currentAddress.region}, ${currentAddress.district}, ${currentAddress.state}, ${currentAddress.postalCode}",
                                // ),
                              ),
                              kHeight,
                            ],
                          ),
                        ),
                      ),
                      // Radio button
                      ValueListenableBuilder(
                        valueListenable: selectedRadioNotifier,
                        builder: (context, checkboxValue, _) {
                          return Container(
                            height: 20,
                            width: 20,
                            child: Radio(
                              value: index,
                              groupValue: checkboxValue,
                              onChanged: (int? newValue) {
                                if (newValue != null) {
                                  checkboxValue = newValue;

                                  selectedRadioNotifier.value = newValue;
                                } else {
                                  checkboxValue = -1;
                                  selectedRadioNotifier.value = 0;
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }

  showDeleteWarning(BuildContext context, int index) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Warning",
      desc: "This address will be deleted",
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
            "Delete",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () async {
            final adderssId = profileController.addressList[index].id.toString();
            await ApiServices().deleteUserAddress(adderssId);
            Navigator.of(context).pop();
            profileController.getUserAddresses();
          },
          gradient: LinearGradient(colors: [
            Colors.red,
            Color.fromARGB(255, 244, 86, 75),
          ]),
        )
      ],
    ).show();
  }
}
