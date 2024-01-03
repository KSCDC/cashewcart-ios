import 'package:flutter/material.dart';

class PlaceOrderDropDown extends StatelessWidget {
  const PlaceOrderDropDown({super.key, required this.itemsList});

final List<String> itemsList;
  @override
  Widget build(BuildContext context) {
    return Container(
                                          height: 30,
                                          width: 50,
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                              icon: Icon(Icons.keyboard_arrow_down_sharp),
                                              value: "42",
                                              isExpanded: true,
                                              items: itemsList.map((String size) {
                                                return new DropdownMenuItem(
                                                  value: size,
                                                  child: Text(size),
                                                );
                                              }).toList(),
                                              onChanged: (selectedItem) {},
                                              // hint: Container(
                                              //   child: Text(
                                              //     "42",
                                              //   ),
                                              // ),
                                            ),
                                          ),
                                        );
  }
}