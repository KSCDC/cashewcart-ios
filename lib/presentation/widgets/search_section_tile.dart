import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/presentation/widgets/custom_search_filtering_button.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class SearchSectionTile extends StatelessWidget {
  SearchSectionTile({
    super.key,
    required this.heading,
  });

  final searchController = TextEditingController();
  final String heading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          TextFormField(
            controller: searchController,
            style: const TextStyle(
              color: kSearchBarElementsColor,
              fontFamily: "Montserrat",
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.search),
              hintText: "Search any product",
              hintStyle: TextStyle(
                color: kSearchBarElementsColor,
                fontFamily: "Montserrat",
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              prefixIconColor: kSearchBarElementsColor,
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
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
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
          ),
        ],
      ),
    );
  }
}
