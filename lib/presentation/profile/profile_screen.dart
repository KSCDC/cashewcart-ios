import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/presentation/profile/widgets/profile_editing_textfield.dart';
import 'package:internship_sample/presentation/widgets/custom_appbar.dart';
import 'package:internship_sample/presentation/widgets/custom_elevated_button.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/services/api_services.dart';
import 'package:internship_sample/services/services.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  // ValueNotifier dropdownItemNotifier = ValueNotifier("N1 2LL");

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _pinCodeController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _bankAccountNoController = TextEditingController();
  TextEditingController _accountHolderNameController = TextEditingController();
  TextEditingController _ifscCodeController = TextEditingController();
  AppController controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
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
                      const Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage("lib/core/assets/images/avatar.jpeg"),
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
                  _pinCodeController.text = controller.addressList[0].postalCode;
                  _addressController.text = controller.addressList[0].streetAddress;
                  _cityController.text = controller.addressList[0].region;
                  // _countryController.text = controller.addressList.value[0].country;
                }

                return controller.isLoading.value
                    ? Center(
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
                                child: CustomTextWidget(
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

                          ProfileScreenSubHeading(text: "Business Address Details"),
                          kProfileScreenGap,
                          ProfileEditingTextField(
                            hintText: "Pincode",
                            controller: _pinCodeController,
                          ),
                          kProfileScreenGap,
                          ProfileEditingTextField(
                            hintText: "Address",
                            controller: _addressController,
                          ),
                          kProfileScreenGap,
                          ProfileEditingTextField(
                            hintText: "City",
                            controller: _cityController,
                          ),
                          kProfileScreenGap,
                          const CustomTextWidget(
                            text: "States",
                            fontweight: FontWeight.w400,
                          ),
                          kHeight,
                          DropdownButtonFormField(
                            items: statesList.map((String state) {
                              return new DropdownMenuItem(
                                value: state,
                                child: Text(state),
                              );
                            }).toList(),
                            onChanged: (newValue) {},
                            value: "N1 2LL",
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  color: Color(0xffA8A8A9),
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  width: 1,
                                ),
                              ),
                            ),
                            icon: Icon(Icons.keyboard_arrow_down_sharp),
                          ),
                          kProfileScreenGap,
                          ProfileEditingTextField(
                            hintText: "Country",
                            controller: _countryController,
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
                    ApiServices().editUserAddress(context, controller.addressList[0].id.toString(), _addressController.text, _cityController.text, "kerala", _pinCodeController.text, true);
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
