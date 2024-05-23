import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/controllers/search_controller.dart';
import 'package:internship_sample/presentation/widgets/custom_elevated_button.dart';
import 'package:internship_sample/presentation/widgets/custom_search_filtering_button.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/presentation/widgets/search_section_tile.dart';

class SearchFilterBar extends StatelessWidget {
  SearchFilterBar({
    super.key,
  });

  AppController controller = Get.put(AppController());
  SearchResultController searchController = Get.put(SearchResultController());
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(() {
          return DropdownButton<String>(
            value: controller.dropdownValue.value,
            onChanged: (String? newValue) {
              controller.dropdownValue.value = newValue!;
              // Here you can add code to sort the list based on the selected option
              if (newValue == 'Price Low to High') {
                searchController.sortProduct.value = true;
                searchController.sortAscending.value = true;
                searchController.searchProducts(SearchSectionTile().searchController.text);
                // result.sort((a, b) => double.parse(a.sellingPrice).compareTo(double.parse(b.sellingPrice)));
              } else if (newValue == 'Price High to Low') {
                searchController.sortProduct.value = true;
                searchController.sortAscending.value = false;
                searchController.searchProducts(SearchSectionTile().searchController.text);
                // result.sort((a, b) => double.parse(b.sellingPrice).compareTo(double.parse(a.sellingPrice)));
              } else {
                searchController.sortProduct.value = false;
                searchController.searchProducts(SearchSectionTile().searchController.text);
              }
            },
            items: <String>['Default', 'Price Low to High', 'Price High to Low'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: CustomTextWidget(
                  text: value,
                  fontSize: 16,
                  fontweight: FontWeight.w600,
                ),
              );
            }).toList(),
          );
        }),
        CustomSearchFilteringButton(
          onTap: () {
            showPriceFilterBottomSheet(context);
          },
          label: "Price Filter",
          icon: Icons.filter_alt,
        )
      ],
    );
  }

  void showPriceFilterBottomSheet(BuildContext context) {
    RangeValues _currentRangeValues = RangeValues(searchController.minSearchPrice.value.toDouble(), searchController.maxSearchPrice.value.toDouble());

    showModalBottomSheet(
      // useRootNavigator: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Select Price Range',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Text('Minimum Price: ₹${_currentRangeValues.start.round()}'),
                        ),
                        Expanded(
                          child: Text('Maximum Price: ₹${_currentRangeValues.end.round()}'),
                        ),
                      ],
                    ),
                    RangeSlider(
                      values: _currentRangeValues,
                      min: 0,
                      max: 5000,
                      onChanged: (RangeValues values) {
                        setState(() {
                          _currentRangeValues = values;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        // print('Minimum Price: ₹${_currentRangeValues.start.toStringAsFixed(2)}');
                        // print('Maximum Price: ₹${_currentRangeValues.end.toStringAsFixed(2)}');
                        searchController.minSearchPrice.value = _currentRangeValues.start.round();
                        searchController.maxSearchPrice.value = _currentRangeValues.end.round();
                        searchController.searchProducts(SearchSectionTile().searchController.text);
                        Navigator.pop(context);
                      },
                      child: CustomElevatedButton(
                        label: 'Apply',
                      ),
                    ),
                    SizedBox(
                      height: 50.w,
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
