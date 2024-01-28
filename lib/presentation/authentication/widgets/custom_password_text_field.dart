import 'package:flutter/material.dart';

class CustomPasswordTextField extends StatelessWidget {
  CustomPasswordTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
  });

  final String hintText;

  final TextEditingController controller;
  final TextInputType keyboardType;

  ValueNotifier<bool> obscureTextNotifier = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: obscureTextNotifier,
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: TextFormField(
            keyboardType: keyboardType,
            style: const TextStyle(color: Colors.black),
            obscureText: obscureTextNotifier.value,
            controller: controller,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xffF3F3F3),
              prefixIcon: Icon(Icons.lock_outline),
              hintText: hintText,
              hintStyle: const TextStyle(color: Color(0xff676767)),
              prefixIconColor: Color(0xff676767),
              suffix: GestureDetector(
                  onTap: () {
                    obscureTextNotifier.value = !obscureTextNotifier.value;
                  },
                  child: obscureTextNotifier.value
                      ? Icon(
                          Icons.visibility,
                          size: 18,
                          color: Color(0xff676767),
                        )
                      : Icon(
                          Icons.visibility_off,
                          size: 18,
                          color: Color(0xff676767),
                        )),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Color(0xffA8A8A9),
                  width: 1,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  width: 1,
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 1,
                ),
              ),
            ),
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            // validator: (value) {
            //   if (value == null || value.length < 6) {
            //     return "Password must have atleast 6 characters";
            //   }
            // },
          ),
        );
      },
    );
  }
}
