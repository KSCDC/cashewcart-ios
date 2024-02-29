import 'package:flutter/material.dart';
import 'package:internship_sample/presentation/authentication/widgets/custom_icon_text_field.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class AuthenticationPageTitle extends StatelessWidget {
  AuthenticationPageTitle({
    super.key,
    required this.heading,
  });
  TextEditingController usernameOrEmailController = TextEditingController();
  final String heading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextWidget(
          text: heading,
          fontSize: 36,
          fontweight: FontWeight.w700,
        ),
      ],
    );
  }
}
