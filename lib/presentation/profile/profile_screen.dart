import 'package:flutter/material.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constatns.dart';
import 'package:internship_sample/presentation/profile/widgets/profile_editing_textfield.dart';
import 'package:internship_sample/presentation/widgets/custom_appbar.dart';
import 'package:internship_sample/presentation/widgets/custom_elevated_button.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    //initial values of text fields
    _emailController.text = "aashifa@gmail.com";
    _passwordController.text = "asdasdasdasdad";
    _pinCodeController.text = "450116";
    _addressController.text = "216 St Paul's Rd, ";
    _cityController.text = "London";
    _countryController.text = "United Kingdom";
    _bankAccountNoController.text = "204356XXXXXXX";
    _accountHolderNameController.text = "Abhiraj Sisodiya";
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
                          child:const CircleAvatar(
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
              ),
              kHeight,
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomTextWidget(
                    text: "Change Password",
                    fontSize: 12,
                    fontColor: kMainThemeColor,
                    fontweight: FontWeight.w500,
                    underline: true,
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
                decoration:const InputDecoration(
                  enabledBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: Color(0xffA8A8A9),
                      width: 1,
                    ),
                  ),
                  focusedBorder:  OutlineInputBorder(
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

              kProfileScreenGap,
              Divider(),
              kProfileScreenGap,

              //Bank account details section

             const ProfileScreenSubHeading(text: "Bank Account Details"),
              kProfileScreenGap,
              ProfileEditingTextField(
                hintText: "Bank Account Number",
                controller: _cityController,
              ),
              kProfileScreenGap,
              ProfileEditingTextField(
                hintText: "Account Holder's Name",
                controller: _cityController,
              ),
              kProfileScreenGap,
              ProfileEditingTextField(
                hintText: "IFSC Code",
                controller: _cityController,
              ),
              kProfileScreenGap,
             const SizedBox(
                height: 55,
                width: double.infinity,
                child: CustomElevatedButton(label: "Save"),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
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
