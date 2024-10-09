import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cashew_cart/controllers/app_controller.dart';
import 'package:cashew_cart/controllers/profile_controller.dart';
import 'package:cashew_cart/core/colors.dart';
import 'package:cashew_cart/core/constants.dart';
import 'package:cashew_cart/models/user_address_model.dart';
import 'package:cashew_cart/presentation/place_order/widgets/address_section.dart';
import 'package:cashew_cart/presentation/profile/widgets/profile_editing_textfield.dart';
import 'package:cashew_cart/presentation/shop/widgets/custom_text_icon_button.dart';
import 'package:cashew_cart/presentation/widgets/custom_appbar.dart';
import 'package:cashew_cart/presentation/widgets/custom_elevated_button.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';
import 'package:cashew_cart/services/api_services.dart';
import 'package:cashew_cart/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as enc;

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  TextEditingController _emailController = TextEditingController();
  TextEditingController _accountPhoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _postalCodeController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _streetAddressContrller = TextEditingController();
  TextEditingController _regionController = TextEditingController();
  TextEditingController _districtController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _accountHolderNameController = TextEditingController();
  ValueNotifier<bool> useSameAddressNotifier = ValueNotifier(true);
  ValueNotifier<int> deliveryAddressRadioNotifier = ValueNotifier(0);
  ValueNotifier<int> billingAddressRadioNotifier = ValueNotifier(0);

  // String? id;
  // AppController controller = Get.put(AppController());
  ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: CustomAppBar(
        title: "Profile",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Center(
              //   child: Container(
              //     child: Stack(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.only(right: 10),
              //           child: CircleAvatar(
              //             radius: 50,
              //             backgroundColor: Colors.white.withOpacity(0),
              //             child: const Icon(
              //               Icons.person,
              //               size: 100,
              //             ),
              //           ),
              //         ),
              //         Positioned(
              //           right: 0,
              //           bottom: 0,
              //           child: GestureDetector(
              //             onTap: () {},
              //             child: const CircleAvatar(
              //               radius: 16,
              //               backgroundColor: Colors.white,
              //               child: CircleAvatar(
              //                 radius: 13,
              //                 backgroundColor: Color(0xFF4392F9),
              //                 child: Icon(
              //                   Icons.edit_outlined,
              //                   size: 18,
              //                   color: Colors.white,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              kProfileScreenGap,

              //Personal details section

              Obx(() {
                UserAddressModel? defaultAddress;
                // initial values of text fields
                _emailController.text = profileController.email.value;
                _accountPhoneNumberController.text = profileController.phoneNo.value;
                _accountHolderNameController.text = profileController.userName.value;
                _passwordController.text = "**********";
                if (profileController.addressList.isNotEmpty) {
                  // id = profileController.addressList[0].id.toString();
                  // UserAddressModel defaultAddress = profileController.addressList[0];
                  for (var address in profileController.addressList) {
                    if (address.isDefault) {
                      defaultAddress = address;
                      _nameController.text = defaultAddress.name;
                      _streetAddressContrller.text = defaultAddress.streetAddress;
                      _regionController.text = defaultAddress.region;
                      _districtController.text = defaultAddress.district;
                      _stateController.text = defaultAddress.state;
                      _postalCodeController.text = defaultAddress.postalCode;
                      _phoneNumberController.text = defaultAddress.phoneNumber;
                    }
                  }
                }

                return
                    // profileController.isLoadingAddress.value
                    //     ? const Center(
                    //         child: CircularProgressIndicator(),
                    //       )
                    //     :
                    Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileScreenSubHeading(text: "Personal Details"),
                    kProfileScreenGap,
                    ProfileEditingTextField(
                      hintText: "Name",
                      controller: _accountHolderNameController,
                      enabled: false,
                    ),
                    ProfileEditingTextField(
                      hintText: "Email Address",
                      controller: _emailController,
                      enabled: false,
                    ),
                    kProfileScreenGap,
                    ProfileEditingTextField(
                      prefix: Text("+91 "),
                      hintText: "Phone Number",
                      controller: _accountPhoneNumberController,
                      enabled: false,
                    ),
                    kProfileScreenGap,
                    ProfileEditingTextField(
                      hintText: "Password",
                      controller: _passwordController,
                      obscureText: true,
                      enabled: false,
                    ),
                    kHeight,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showPasswordEditingPopup(context);
                          },
                          child: const CustomTextWidget(
                            text: "Change Password",
                            fontSize: 12,
                            fontColor: kMainThemeColor,
                            fontweight: FontWeight.w500,
                            underline: true,
                          ),
                        )
                      ],
                    ),
                    kProfileScreenGap,
                    Divider(),
                    kProfileScreenGap,

                    //Buisiness address details section

                    ProfileScreenSubHeading(text: "Address Details"),
                    kProfileScreenGap,
                    if (profileController.addressList.isNotEmpty)
                      ValueListenableBuilder(
                          valueListenable: useSameAddressNotifier,
                          builder: (context, newValue, _) {
                            return Row(
                              children: [
                                SizedBox(
                                  // width: screenSize.width * 0.75,
                                  child: CustomTextWidget(
                                    text: "Use same Delivery Address\nand Billing Address :",
                                    fontweight: FontWeight.w600,
                                  ),
                                ),
                                // Default value
                                Spacer(),

                                Checkbox(
                                  value: newValue,
                                  onChanged: (bool? value) {
                                    useSameAddressNotifier.value = value ?? true; // Update the isChecked variable
                                  },
                                )
                              ],
                            );
                          }),

                    // Obx(() {
                    //   if (profileController.addressList.isEmpty) {
                    //     useSameAddressNotifier.value = false;
                    //     return CustomTextWidget(text: "No saved addresses!");
                    //   } else {
                    kHeight,
                    AddressSection(
                      screenSize: screenSize,
                      heading: "Delivery Address",
                      selectedRadioNotifier: deliveryAddressRadioNotifier,
                    ),
                    //   }
                    // }),
                    kHeight,
                    ValueListenableBuilder(
                        valueListenable: useSameAddressNotifier,
                        builder: (context, hide, _) {
                          if (hide) {
                            return SizedBox();
                          } else {
                            return AddressSection(
                              screenSize: screenSize,
                              heading: "Billing Address",
                              selectedRadioNotifier: billingAddressRadioNotifier,
                            );
                          }
                        }),
                    SizedBox(height: 5),

                    // add new address button
                    Center(
                      child: CustomTextIconButton(
                        onPressed: () async {
                          TextEditingController _nameContrller = TextEditingController();
                          TextEditingController _streetAddressContrller = TextEditingController();
                          TextEditingController _regionController = TextEditingController();
                          // TextEditingController _districtController = TextEditingController();
                          // TextEditingController _stateController = TextEditingController();
                          TextEditingController _postalcodeController = TextEditingController();
                          TextEditingController _phoneNumberController = TextEditingController();
                          profileController.state = "Kerala";
                          profileController.district = null;

                          await Services().showAddressEditBottomSheet(
                            true,
                            context,
                            "",
                            "ADD ADDRESS",
                            "ADD",
                            _nameContrller,
                            _streetAddressContrller,
                            _regionController,
                            _postalcodeController,
                            _phoneNumberController,
                          );
                          profileController.getUserAddresses();
                        },
                        icon: Icons.add,
                        label: "Add address",
                        textAndIconColor: Colors.black,
                        textAndIconSize: 12,
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                );
              }),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void showPasswordEditingPopup(BuildContext context) {
    TextEditingController _currentPasswordController = TextEditingController();
    TextEditingController _newPasswordController = TextEditingController();
    TextEditingController _confirmNewPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            title: Text('Popup Title'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ProfileEditingTextField(
                  hintText: "Current Password",
                  controller: _currentPasswordController,
                ),
                ProfileEditingTextField(
                  hintText: "New Password",
                  controller: _newPasswordController,
                ),
                ProfileEditingTextField(
                  hintText: "Confirm New Password",
                  controller: _confirmNewPasswordController,
                ),
              ],
            ),
            actions: [
              GestureDetector(
                onTap: () async {
                  String _decrypted = '';
                  if (_newPasswordController.text != _confirmNewPasswordController.text) {
                    Services().showCustomSnackBar(context, "Password and confirm password doesn't match");
                  } else if (_newPasswordController.text.length < 8) {
                    Services().showCustomSnackBar(context, "Password must contain atleast 8 characters");
                  } else {
                    SharedPreferences sharedPref = await SharedPreferences.getInstance();

                    // email = sharedPref.getString(EMAIL);
                    final encryptedBase64 = sharedPref.getString(ENCRYPTEDPASSWORD);
                    final keyString = sharedPref.getString('ENCRYPTION_KEY');
                    final ivString = sharedPref.getString('ENCRYPTION_IV');

                    // decoding the stored key for decrypting password
                    final keyBytes = base64.decode(keyString!);
                    final ivBytes = base64.decode(ivString!);
                    final key = enc.Key(keyBytes);
                    final iv = enc.IV(ivBytes);
                    if (encryptedBase64 != null) {
                      final encrypted = enc.Encrypted.fromBase64(encryptedBase64);
                      final decrypter = enc.Encrypter(enc.AES(key));
                      _decrypted = decrypter.decrypt(encrypted, iv: iv);
                    }
                    if (_decrypted != _currentPasswordController.text) {
                      Services().showCustomSnackBar(context, "Current password is incorrect");
                    } else {
                      final response = ApiServices().changePassword(context, _newPasswordController.text, _confirmNewPasswordController.text);
                      if (response != null) {
                        Services().showCustomSnackBar(context, "Password changed successfully");
                      }
                    }
                  }
                  Get.back();
                },
                child: CustomElevatedButton(label: "Update"),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ProfileScreenSubHeading extends StatelessWidget {
  const ProfileScreenSubHeading({
    super.key,
    required this.text,
  });

  final String text;
  @override
  Widget build(BuildContext context) {
    return CustomTextWidget(
      text: text,
      fontSize: 18,
      fontweight: FontWeight.w600,
    );
  }
}
