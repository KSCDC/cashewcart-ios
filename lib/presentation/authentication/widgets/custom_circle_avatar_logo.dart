import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constants.dart';

class CustomCircleAvatarLogo extends StatelessWidget {
  const CustomCircleAvatarLogo({
    super.key,
    required this.loginWith,
    required this.logoPath,
  });

  final String logoPath;
  final LoginWith loginWith;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SnackBar snackBar = SnackBar(
          content: Text("Logging with ${loginWith.name}"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(20),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: CircleAvatar(
        radius: 28,
        backgroundColor: kMainThemeColor,
        child: CircleAvatar(
          radius: 27,
          child: SvgPicture.asset(
            logoPath,
            height: 24,
            width: 24,
          ),
        ),
      ),
    );
  }
}
