import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/models/product_model.dart';
import 'package:internship_sample/presentation/widgets/search_filter_bar.dart';
import 'package:internship_sample/services/debouncer.dart';

class SearchSectionTile extends StatelessWidget {
  SearchSectionTile({
    super.key,
    // required this.heading,
  });

  final searchController = TextEditingController();
  // final String heading;
  final _debouncer = Debouncer(milliseconds: 1 * 1000);
  AppController controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10.w,
      ),
      child: Column(
        children: [
          TextFormField(
            controller: searchController,
            onChanged: (value) {
              _debouncer.run(
                () async {
                  print("searching");
                  if (value.trim() != "") {
                    controller.searchProducts(value);
                  } else {
                    controller.haveSearchResult.value = false;
                    controller.searchResults.clear();
                    print("${controller.searchResults.length}");
                  }
                },
              );
            },
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
          SearchFilterBar()
        ],
      ),
    );
  }
}
