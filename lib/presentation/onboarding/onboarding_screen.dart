import 'package:flutter/material.dart';
import 'package:cashew_cart/core/colors.dart';
import 'package:cashew_cart/presentation/authentication/signin_screen.dart';
import 'package:cashew_cart/presentation/get_started/get_started_screen.dart';
import 'package:cashew_cart/presentation/onboarding/widgets/onboarding_tile.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final controller = PageController();
  ValueNotifier<int> pageNumberNotifier = ValueNotifier(1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        backgroundColor: appBackgroundColor,
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
                    const CustomTextWidget(
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
              Get.offAll(() => SignInScreen());
            },
            child: CustomTextWidget(
              text: "Skip",
              fontSize: 18,
              fontweight: FontWeight.w600,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(bottom: 60),
          child: PageView(
            controller: controller,
            onPageChanged: (newPageNo) {
              pageNumberNotifier.value = newPageNo + 1;
            },
            children: [
              OnboardingTile(
                imagePath: "lib/core/assets/images/onboard_choose_products.png",
                heading: "Choose Products",
                description:
                    "Customers will be able to select the cashew products they want to buy now- and other products will continue to remain in the cart. Selected products will be available on the checkout page.",
              ),
              OnboardingTile(
                imagePath: "lib/core/assets/images/onboard_make_payment.png",
                heading: "Make Payment",
                description:
                    "Customers can make  payments for purchased products through the technology online payment gateway system.",
              ),
              OnboardingTile(
                imagePath: "lib/core/assets/images/onboard_get_your_order.png",
                heading: "Get Your Order",
                description:
                    "After the payment authorization an order summary  will be available on your My Order page.",
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 60,
        color: appBackgroundColor,
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
                        : const SizedBox();
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
              },
            ),
            TextButton(
              onPressed: () async {
                if (controller.page == 2) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const GetStartedScreen()));
                } else {
                  await controller.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  );

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
                              fontColor: kMainThemeColor,
                              fontweight: FontWeight.w600,
                            )
                          : const CustomTextWidget(
                              text: "Next",
                              fontSize: 18,
                              fontColor: kMainThemeColor,
                              fontweight: FontWeight.w600,
                              textAlign: TextAlign.center,
                            );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
