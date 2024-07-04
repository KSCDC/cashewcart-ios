import 'package:flutter/material.dart';
import 'package:cashew_cart/core/colors.dart';
import 'package:cashew_cart/core/constants.dart';
import 'package:cashew_cart/presentation/widgets/custom_appbar.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  String title = "About KSCDC";
  String aboutKscdc = aboutKsdcEnglish;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actionWidget: GestureDetector(
          onTap: () {
            setState(() {
              if (aboutKscdc == aboutKsdcEnglish) {
                aboutKscdc = aboutKsdcMalayalam;
                title = "കാഷ്യൂ  കോർപ്പറേഷനെക്കുറിച്ച്";
              } else {
                aboutKscdc = aboutKsdcEnglish;
                title = "About KSCDC";
              }
            });
          },
          child: Row(
            children: [
              CustomTextWidget(
                text: "ENG",
                fontColor: kMainThemeColor,
              ),
              Icon(
                Icons.compare_arrows_rounded,
                color: kMainThemeColor,
              ),
              CustomTextWidget(
                text: "MAL",
                fontColor: kMainThemeColor,
              ),
              SizedBox(
                width: 5,
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        // child: CustomTextWidget(text: aboutKsdcEnglish),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              CustomTextWidget(
                text: title,
                fontSize: 18,
                fontweight: FontWeight.w600,
              ),
              kHeight,
              Text(
                aboutKscdc,
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
