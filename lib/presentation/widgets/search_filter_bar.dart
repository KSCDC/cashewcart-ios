import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/presentation/widgets/custom_search_filtering_button.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class SearchFilterBar extends StatelessWidget {
  SearchFilterBar({
    super.key,
    required this.heading,
  });
  final String heading;
  AppController controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextWidget(
          text: heading,
          fontSize: 18,
          fontweight: FontWeight.w600,
        ),
        Row(
          children: [
            CustomSearchFilteringButton(
              onTap: () {},
              label: "Sort",
              icon: Icons.swap_vert,
            ),
            CustomSearchFilteringButton(
              onTap: () {
                showPriceFilterBottomSheet(context);
              },
              label: "Filter",
              icon: Icons.filter_alt,
            ),
          ],
        )
      ],
    );
  }

  void showPriceFilterBottomSheet(BuildContext context) {
    RangeValues _currentRangeValues = RangeValues(controller.minSearchPrice.value.toDouble(), controller.maxSearchPrice.value.toDouble());

    showModalBottomSheet(
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
                    ElevatedButton(
                      onPressed: () {
                        print('Minimum Price: ₹${_currentRangeValues.start.toStringAsFixed(2)}');
                        print('Maximum Price: ₹${_currentRangeValues.end.toStringAsFixed(2)}');
                        controller.minSearchPrice.value = _currentRangeValues.start.round();
                        controller.maxSearchPrice.value = _currentRangeValues.end.round();
                        Navigator.pop(context);
                      },
                      child: CustomTextWidget(text: 'Apply'),
                    ),
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
