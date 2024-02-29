import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class AddressTile extends StatelessWidget {
  AddressTile({super.key});
  // final ValueNotifier isEditable;

  @override
  Widget build(BuildContext context) {
    TextEditingController _textEditingController = TextEditingController(
        text: "216 St Paul's Rd, London N1 2LL, UK, \nContact :  +44-784232 ");
    ValueNotifier<bool> isAddressEditableNotifier = ValueNotifier(false);
    final screenSize = MediaQuery.of(context).size;
    return ValueListenableBuilder(
      valueListenable: isAddressEditableNotifier,
      builder: (context, value, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: screenSize.width * 0.32,
              width: screenSize.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                          text: "Address :",
                          fontSize: 12,
                          fontweight: FontWeight.w500,
                        ),
                        kHeight,
                        TextField(
                          controller: _textEditingController,
                          style: TextStyle(fontSize: 14),
                          maxLines: 2,
                          enabled: value,
                          decoration: InputDecoration(
                            border:
                                value ? OutlineInputBorder() : InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: -5,
                      right: -2,
                      child: GestureDetector(
                        onTap: () {
                          isAddressEditableNotifier.value = true;
                        },
                        child: Icon(Icons.edit_note_rounded),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (value)
              GestureDetector(
                onTap: () {
                  isAddressEditableNotifier.value = false;
                },
                child: Container(
                  height: screenSize.width * 0.1,
                  width: screenSize.width * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.done_rounded,
                    ),
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}
