import 'package:flutter/material.dart';
import 'package:internship_sample/presentation/authentication/signin_screen.dart';
import 'package:internship_sample/presentation/get_started/get_started_screen.dart';
import 'package:internship_sample/presentation/onboarding/widgets/onboarding_tile.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final controller = PageController();
  ValueNotifier<int> pageNumberNotifier = ValueNotifier(1);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: ValueListenableBuilder(
              valueListenable: pageNumberNotifier,
              builder: (BuildContext context, int value, _) {
                return Padding(
                  padding: const EdgeInsets.only(left: 17),
                  child: Row(
                    children: [
                      CustomTextWidget(
                        text: "${pageNumberNotifier.value}",
                        fontSize: 18,
                        fontweight: FontWeight.w600,
                      ),
                      CustomTextWidget(
                        text: "/3",
                        fontSize: 18,
                        fontColor: Color(0xffA0A0A1),
                        fontweight: FontWeight.w600,
                      ),
                    ],
                  ),
                );
              }),
          actions: [
            TextButton(
              onPressed: () {
                controller.animateToPage(
                  2,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
                pageNumberNotifier.value = 3;
              },
              child: CustomTextWidget(
                text: "Skip",
                fontSize: 18,
                fontweight: FontWeight.w600,
              ),
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(bottom: 60),
          child: PageView(
            controller: controller,
            children: [
              OnboardingTile(
                imagePath: "lib/core/assets/images/onboard_choose_products.png",
                heading: "Choose Products",
                description:
                    "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.",
              ),
              OnboardingTile(
                imagePath: "lib/core/assets/images/onboard_make_payment.png",
                heading: "Make Payment",
                description:
                    "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.",
              ),
              OnboardingTile(
                imagePath: "lib/core/assets/images/onboard_get_your_order.png",
                heading: "Get Your Order",
                description:
                    "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.",
              ),
            ],
          ),
        ),
        bottomSheet: Container(
          height: 60,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 115,
                child: ValueListenableBuilder(
                    valueListenable: pageNumberNotifier,
                    builder: (BuildContext context, int value, _) {
                      return pageNumberNotifier.value != 1
                          ? TextButton(
                              onPressed: () async {
                                await controller.previousPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn,
                                );
                                pageNumberNotifier.value =
                                    controller.page!.toInt() + 1;
                              },
                              child: const CustomTextWidget(
                                text: "Prev",
                                fontSize: 18,
                                fontColor: Color(0xffC4C4C4),
                                fontweight: FontWeight.w600,
                              ),
                            )
                          : SizedBox();
                    }),
              ),
              SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: const WormEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 15,
                  ),
                  onDotClicked: (index) {
                    controller.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                    pageNumberNotifier.value = index + 1;
                  }),
              TextButton(
                onPressed: () async {
                  print("current page no : ${controller.page}");
                  if (controller.page == 2) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => GetStartedScreen()));
                  } else {
                    await controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                    // print("current page no : ${controller.page}");
                    pageNumberNotifier.value = controller.page!.toInt() + 1;
                  }
                },
                child: SizedBox(
                  width: 115,
                  child: ValueListenableBuilder(
                      valueListenable: pageNumberNotifier,
                      builder: (BuildContext context, int value, _) {
                        return pageNumberNotifier.value == 3
                            ? const CustomTextWidget(
                                text: "Get Started",
                                fontSize: 18,
                                fontColor: Color(0xffF83758),
                                fontweight: FontWeight.w600,
                              )
                            : const CustomTextWidget(
                                text: "Next",
                                fontSize: 18,
                                fontColor: Color(0xffF83758),
                                fontweight: FontWeight.w600,
                                textAlign: TextAlign.center,
                              );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
