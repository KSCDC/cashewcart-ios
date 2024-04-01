import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/models/user_address_model.dart';
import 'package:internship_sample/presentation/profile/widgets/profile_editing_textfield.dart';
import 'package:internship_sample/presentation/widgets/custom_appbar.dart';
import 'package:internship_sample/presentation/widgets/custom_elevated_button.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/services/api_services.dart';
import 'package:internship_sample/services/services.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _postalCodeController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _streetAddressContrller = TextEditingController();
  TextEditingController _regionController = TextEditingController();
  TextEditingController _districtController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _bankAccountNoController = TextEditingController();
  TextEditingController _accountHolderNameController = TextEditingController();
  TextEditingController _ifscCodeController = TextEditingController();

  // String? id;
  AppController controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    // just setting the first address in the list as default address for using if there is no default address
    UserAddressModel defaultAddress = controller.addressList[0];
    _bankAccountNoController.text = "204356XXXXXXX";

    _ifscCodeController.text = "SBIN00428";

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
              Center(
                child: Container(
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white.withOpacity(0),
                          child: const Icon(
                            Icons.person,
                            size: 100,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () {},
                          child: const CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 13,
                              backgroundColor: Color(0xFF4392F9),
                              child: Icon(
                                Icons.edit_outlined,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              kProfileScreenGap,

              //Personal details section

              Obx(() {
                // initial values of text fields
                _emailController.text = controller.email;
                _accountHolderNameController.text = controller.userName;
                _passwordController.text = "**********";
                if (controller.addressList.value.isNotEmpty) {
                  // id = controller.addressList[0].id.toString();

                  for (var address in controller.addressList) {
                    if (address.isDefault) {
                      defaultAddress = address;
                    }
                  }

                  _nameController.text = defaultAddress.name;
                  _streetAddressContrller.text = defaultAddress.streetAddress;
                  _regionController.text = defaultAddress.region;
                  _districtController.text = defaultAddress.district;
                  _stateController.text = defaultAddress.state;
                  _postalCodeController.text = defaultAddress.postalCode;
                  _phoneNumberController.text = defaultAddress.phoneNumber;
                }

                return controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          ProfileScreenSubHeading(text: "Personal Details"),
                          kProfileScreenGap,
                          ProfileEditingTextField(
                            hintText: "Email Address",
                            controller: _emailController,
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
                          ProfileEditingTextField(
                            hintText: "Name",
                            controller: _nameController,
                          ),
                          kProfileScreenGap,
                          ProfileEditingTextField(
                            hintText: "Street Address",
                            controller: _streetAddressContrller,
                          ),
                          kProfileScreenGap,
                          ProfileEditingTextField(
                            hintText: "Region",
                            controller: _regionController,
                          ),
                          kProfileScreenGap,
                          ProfileEditingTextField(
                            hintText: "District",
                            controller: _districtController,
                          ),
                          kProfileScreenGap,
                          ProfileEditingTextField(
                            hintText: "State",
                            controller: _stateController,
                          ),
                          kProfileScreenGap,
                          ProfileEditingTextField(
                            hintText: "Postal Code",
                            controller: _postalCodeController,
                          ),

                          kProfileScreenGap,
                          ProfileEditingTextField(
                            hintText: "Phone Number",
                            controller: _phoneNumberController,
                          ),
                        ],
                      );
              }),

              kProfileScreenGap,
              Divider(),
              kProfileScreenGap,

              //Bank account details section

              const ProfileScreenSubHeading(text: "Bank Account Details"),
              kProfileScreenGap,
              ProfileEditingTextField(
                hintText: "Bank Account Number",
                controller: _bankAccountNoController,
              ),
              kProfileScreenGap,
              ProfileEditingTextField(
                hintText: "Account Holder's Name",
                controller: _accountHolderNameController,
              ),
              kProfileScreenGap,
              ProfileEditingTextField(
                hintText: "IFSC Code",
                controller: _ifscCodeController,
              ),
              kProfileScreenGap,
              SizedBox(
                height: 55,
                width: double.infinity,
                child: GestureDetector(
                  onTap: () async {
                    await ApiServices().editUserAddress(context, defaultAddress.id.toString(), _nameController.text, _streetAddressContrller.text, _regionController.text, _districtController.text,
                        _stateController.text, _postalCodeController.text, _phoneNumberController.text, true);
                    controller.getUserAddresses();
                  },
                  child: CustomElevatedButton(label: "Save"),
                ),
              ),
              const SizedBox(height: 50),
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
                onTap: () {
                  if (_newPasswordController.text != _confirmNewPasswordController.text) {
                    Services().showCustomSnackBar(context, "Password and confirm password doesn't match");
                  } else if (_newPasswordController.text.length < 6) {
                    Services().showCustomSnackBar(context, "Password must contain atleast 6 characters");
                  } else {
                    final response = ApiServices().changePassword(context, _newPasswordController.text, _confirmNewPasswordController.text);
                    if (response != null) {
                      Services().showCustomSnackBar(context, "Password changed successfully");
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
