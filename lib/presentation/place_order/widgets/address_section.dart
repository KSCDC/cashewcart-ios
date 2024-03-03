import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/presentation/shop/widgets/custom_text_icon_button.dart';
import 'package:internship_sample/presentation/widgets/custom_elevated_button.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

ValueNotifier<int> productCountNotifier = ValueNotifier(1);
ValueNotifier<int> selectedRadioNotifier = ValueNotifier(0);
List<TextEditingController> deliveryAddressControllers = [];
ValueNotifier<bool> isAddressEditableNotifier = ValueNotifier(false);

class AddressSection extends StatelessWidget {
  AddressSection({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;
  AppController controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    deliveryAddressControllers.clear();
    for (int i = 0; i < controller.addressList.length; i++) {
      deliveryAddressControllers.add(
        TextEditingController(
          text:
              "${controller.addressList[i].streetAddress}, ${controller.addressList[i].city}, ${controller.addressList[i].state}, ${controller.addressList[i].postalCode}, ${controller.addressList[i].country}",
        ),
      );
    }
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
              Spacer(),
              ValueListenableBuilder(
                  valueListenable: isAddressEditableNotifier,
                  builder: (context, value, _) {
                    return value
                        ? GestureDetector(
                            onTap: () {
                              isAddressEditableNotifier.value = false;
                            },
                            child: Icon(
                              Icons.done_rounded,
                              color: kMainThemeColor,
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              isAddressEditableNotifier.value = true;
                            },
                            child: Icon(
                              Icons.edit_note_rounded,
                              color: kMainThemeColor,
                            ),
                          );
                  }),
            ],
          ),
        ),
        Column(
          children: List.generate(
            deliveryAddressControllers.length,
            (index) {
              return ValueListenableBuilder(
                valueListenable: isAddressEditableNotifier,
                builder: (context, value, _) {
                  print("edit $value");
                  return Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: screenSize.width * 0.32,
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
                                CustomTextWidget(
                                  text: "Address :${index + 1}",
                                  fontSize: 12,
                                  fontweight: FontWeight.w500,
                                ),
                                kHeight,
                                TextField(
                                  controller: deliveryAddressControllers[index],
                                  style: TextStyle(fontSize: 14),
                                  maxLines: 2,
                                  enabled: value,
                                  decoration: InputDecoration(
                                    border: value ? OutlineInputBorder() : InputBorder.none,
                                  ),
                                ),
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
                                  // Allow changing the selected address when the radio button is tapped
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
              );
            },
          ),
        ),
      ],
    );
  }
}
