import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cashew_cart/controllers/app_controller.dart';
import 'package:cashew_cart/controllers/profile_controller.dart';
import 'package:cashew_cart/core/constants.dart';
import 'package:cashew_cart/core/states_and_districts.dart';
import 'package:cashew_cart/models/states_and_districts_model.dart';
import 'package:cashew_cart/presentation/authentication/widgets/custom_icon_text_field.dart';
import 'package:cashew_cart/presentation/authentication/widgets/custom_password_text_field.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';

class AddOrEditAddress extends StatefulWidget {
  AddOrEditAddress({
    super.key,
    required this.nameController,
    required this.cityController,
    required this.addressController,
    required this.postalcodeController,
    required this.phoneNumberController,
    required this.state,
    required this.district,
    required this.formKey,
  });
  final TextEditingController nameController;
  final TextEditingController cityController;
  final TextEditingController addressController;
  // final TextEditingController districtController;
  // final TextEditingController stateController;
  final TextEditingController postalcodeController;
  final TextEditingController phoneNumberController;
  String? state;
  String? district;
  List<String>? districts;
  final formKey;

  @override
  State<AddOrEditAddress> createState() => _AddOrEditAddressState();
}

List states = [];
// List<String> get _stateList => statesAndDistrictsList['states']!.map<String>((state) => state['state']).toList();

// List<String>? get _districtList => _selectedState == null ? null : statesAndDistrictsList['states']!.firstWhere((state) => state['state'] == _selectedState)['districts'];
List statesList = [];
List<StatesAndDistrictsModel> models = [];

class _AddOrEditAddressState extends State<AddOrEditAddress> {
  @override
  void initState() {
    super.initState();
    // List<Map<String, dynamic>> states = statesAndDistrictsList['states'].map<Map<String, dynamic>>((stateData) => stateData as Map<String, dynamic>).toList();

    // for (var item in statesAndDistrictsList) {
    //   statesList = item["state"];
    // }
    models = statesAndDistrictsList.map((map) => StatesAndDistrictsModel.fromJson(map)).toList();
    log(models[0].state);
  }

  AppController controller = Get.put(AppController());
  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    log("value of district in controler: ${profileController.district}");
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: widget.nameController,
            decoration: InputDecoration(
              labelText: 'Name',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your Name';
              } else if (value.length < 3) {
                return 'Name must have atleast 3 characters';
              }
              return null;
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: widget.addressController,
            decoration: InputDecoration(
              labelText: 'Address',
            ),
            validator: (value) {
              if (value == null || value.trim() == "") {
                return 'Please enter your Address';
              }
              return null;
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: widget.cityController,
            decoration: InputDecoration(
              labelText: 'Post Office/City/Town',
            ),
            validator: (value) {
              if (value == null || value.trim() == "") {
                return 'Please enter your Post Office/City/Town';
              }
              return null;
            },
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextWidget(
            text: "State",
            fontSize: 11.sp,
          ),
          DropdownButton<String>(
            isExpanded: true,
            hint: Text('Select State'),
            value: widget.state,
            onChanged: (String? newValue) {
              setState(() {
                log("working state change");
                widget.state = newValue!;
                widget.district = null;
                profileController.district = null;
                profileController.state = newValue;
              });
            },
            items: models.map((model) {
              return DropdownMenuItem<String>(
                value: model.state,
                child: Text(model.state),
              );
            }).toList(),
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextWidget(
            text: "District",
            fontSize: 11.sp,
          ),
          DropdownButton<String>(
            isExpanded: true,
            hint: Text('Select District'),
            value: widget.district,
            onChanged: (newValue) {
              setState(() {
                log("working dis change");

                widget.district = newValue;
                profileController.district = newValue!;
                log("value of district : ${profileController.district}");
              });
            },
            items: widget.state != null
                ? models.firstWhere((model) => model.state == widget.state).districts.map((district) {
                    return DropdownMenuItem<String>(
                      value: district,
                      child: Text(district),
                    );
                  }).toList()
                : [],
          ),

          // items: [
          //   DropdownMenuItem(
          //     value: 'Item 1',
          //     child: Text('Item 1'),
          //   ),
          // ]),

          TextFormField(
            controller: widget.postalcodeController,
            keyboardType: TextInputType.number,
            maxLength: 6,
            decoration: InputDecoration(
              labelText: 'Postal Code',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your Postal Code';
              } else if (value.length != 6) {
                return 'Postal Code must be exactly 6 digits';
              }
              return null;
            },
          ),

          TextFormField(
            controller: widget.phoneNumberController,
            keyboardType: TextInputType.number,
            maxLength: 10,
            decoration: InputDecoration(
              prefixText: "+91 ",
              labelText: 'Phone Number',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your Phone Number';
              } else if (value.length != 10) {
                return 'Phone Number must be exactly 10 digits';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
