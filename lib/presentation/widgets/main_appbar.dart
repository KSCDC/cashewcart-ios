import 'package:flutter/material.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {},
        icon: Icon(Icons.menu),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
            child: Image.asset(
              "lib/core/assets/images/logos/app_logo.png",
            ),
          ),
          SizedBox(width: 9),
          CustomTextWidget(
            text: "Stylish",
            fontFamily: "LibreCaslonText",
            fontSize: 18,
            fontColor: kMainAppBarTextColor,
            fontweight: FontWeight.w700,
          )
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            child: CircleAvatar(  
              child: Image.asset("lib/core/assets/images/avatar.jpeg"),
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
