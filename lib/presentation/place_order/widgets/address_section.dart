import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/presentation/shop/widgets/custom_text_icon_button.dart';
import 'package:internship_sample/presentation/widgets/custom_elevated_button.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/services/api_services.dart';
import 'package:internship_sample/services/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

ValueNotifier<int> selectedRadioNotifier = ValueNotifier(0);

class AddressSection extends StatelessWidget {
  AddressSection({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;
  AppController controller = Get.put(AppController());
  TextEditingController _streetAddressConrller = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _postalcodeController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
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
                text: "Delivery Address",
                fontweight: FontWeight.w600,
              ),
              // SizedBox(width: 20),
              // Spacer(),
              // ValueListenableBuilder(
              //     valueListenable: isAddressEditableNotifier,
              //     builder: (context, value, _) {
              //       return value
              //           ? GestureDetector(
              //               onTap: () {
              //                 isAddressEditableNotifier.value = false;
              //               },
              //               child: Icon(
              //                 Icons.done_rounded,
              //                 color: kMainThemeColor,
              //               ),
              //             )
              //           : GestureDetector(
              //               onTap: () {
              //                 isAddressEditableNotifier.value = true;
              //               },
              //               child: Icon(
              //                 Icons.edit_note_rounded,
              //                 color: kMainThemeColor,
              //               ),
              //             );
              //     }),
            ],
          ),
        ),
        Column(
          children: List.generate(
            controller.addressList.length,
            (index) {
              final currentAddress = controller.addressList[index];

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
                                  onTap: () {
                                    final adderssId = controller.addressList[index].id.toString();
                                    ApiServices().deleteUserAddress(adderssId);
                                    // ApiServices().getUserAddresses();
                                    controller.getUserAddresses();
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
                                _streetAddressConrller.text = currentAddress.streetAddress;
                                _cityController.text = currentAddress.city;
                                _postalcodeController.text = currentAddress.postalCode;
                                _stateController.text = currentAddress.state;
                                Services().showAddressEditPopup(
                                    false, context, currentAddress.id.toString(), "EDIT ADDRESS", "EDIT", _streetAddressConrller, _cityController, _postalcodeController, _stateController);
                              },
                              child: CustomTextWidget(
                                text: "${currentAddress.streetAddress}, ${currentAddress.city}, ${currentAddress.postalCode}, ${currentAddress.state}, ${currentAddress.country}",
                              ),
                            ),
                            kHeight,
                          ],
                        ),
                      ),
                    ),
                    // Checkbox
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
                                // isAddressEditableNotifier.value = false;
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
        ),
      ],
    );
  }
}
