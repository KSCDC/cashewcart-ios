import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/controllers/profile_controller.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/core/states_and_districts.dart';
import 'package:internship_sample/models/states_and_districts_model.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: widget.nameController,
          decoration: InputDecoration(
            labelText: 'Name',
          ),
        ),
        TextField(
          controller: widget.addressController,
          decoration: InputDecoration(
            labelText: 'Address',
          ),
        ),
        SizedBox(height: 5),
        TextField(
          controller: widget.cityController,
          decoration: InputDecoration(
            labelText: 'Post Office/City/Town',
          ),
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
              widget.state = newValue!;
              widget.district = null;
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
        SizedBox(height: 5),
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
              widget.district = newValue;
              profileController.district = newValue!;
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

        TextField(
          controller: widget.postalcodeController,
          keyboardType: TextInputType.number,
          maxLength: 6,
          decoration: InputDecoration(
            labelText: 'Postal Code',
          ),
        ),
        TextField(
          controller: widget.phoneNumberController,
          keyboardType: TextInputType.number,
          maxLength: 10,
          decoration: InputDecoration(
            prefixText: "+91",
            labelText: 'Phone Number',
          ),
        ),
      ],
    );
  }
}
