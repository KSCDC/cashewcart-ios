import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {super.key, required this.label, required this.onPressed});

  final String label;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Adjust the border radius
          ),
          side: BorderSide(
            color: Colors.black, // Border color
            width: 1, // Border width
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.black, // Text color
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
