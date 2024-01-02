import 'package:flutter/material.dart';
import 'package:internship_sample/presentation/widgets/custom_search_filtering_button.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class SearchFilterBar extends StatelessWidget {
  const SearchFilterBar({
    super.key,
    required this.heading,
  });
  final String heading;

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
        const Row(
          children: [
            CustomSearchFilteringButton(
              label: "Sort",
              icon: Icons.swap_vert,
            ),
            CustomSearchFilteringButton(
              label: "Filter",
              icon: Icons.filter_alt,
            ),
          ],
        )
      ],
    );
  }
}
