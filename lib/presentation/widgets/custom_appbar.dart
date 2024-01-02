import 'package:flutter/material.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title = "",
    this.actionWidget = const SizedBox(width: 20),
  });
  final String title;
  final Widget actionWidget;
  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Center(
          child: CustomTextWidget(
            text: title,
            fontSize: 18,
            fontweight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: actionWidget,
          ),
        ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
