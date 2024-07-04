import 'package:flutter/material.dart';
import 'package:cashew_cart/core/colors.dart';
import 'package:cashew_cart/presentation/authentication/signin_screen.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              height: screenSize.height,
              width: screenSize.width,
              child: FittedBox(
                child: Image.asset(
                  "lib/core/assets/images/get_started_bg_image.png",
                ),
                fit: BoxFit.fill,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black87,
                      Colors.black12,
                    ],
                  )),
                  child: Padding(
                    padding: const EdgeInsets.all(55.0),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        CustomTextWidget(
                          text: "You want Authentic, here you go!",
                          fontSize: 34,
                          fontColor: Colors.white,
                          fontweight: FontWeight.w600,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        CustomTextWidget(
                          text: "Find it here, buy it now!",
                          fontSize: 14,
                          fontColor: Color(0xffF2F2F2),
                          fontweight: FontWeight.w400,
                        ),
                        SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kMainThemeColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => SignInScreen(),
                                ),
                              );
                            },
                            child: const CustomTextWidget(
                              text: "Get Started",
                              fontSize: 23,
                              fontColor: kButtonTextColor,
                              fontweight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
