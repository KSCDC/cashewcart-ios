import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/controllers/search_controller.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/models/product_model.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
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
  SearchResultController controller = Get.put(SearchResultController());
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10.w,
      ),
      child: Obx(() {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: searchController,
                    focusNode: _focusNode,
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
                    onTap: () {
                      controller.isSearchMode.value = true;
                      controller.searchProducts("");
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
                ),
                if (controller.isSearchMode.value)
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: GestureDetector(
                      onTap: () {
                        controller.isSearchMode.value = false;
                        _focusNode.unfocus();
                      },
                      child: Container(
                        height: 50.w,
                        width: 60.w,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Center(
                            child: CustomTextWidget(
                          text: "Cancel",
                          fontSize: 12.sp,
                        )),
                      ),
                    ),
                  )
              ],
            ),
            const SizedBox(height: 10),
            if (controller.isSearchMode.value) SearchFilterBar()
          ],
        );
      }),
    );
  }
}
