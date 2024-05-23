import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/controllers/cart_controller.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/presentation/main_page/main_page_screen.dart';
import 'package:internship_sample/presentation/onboarding/onboarding_screen.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);
  static String? email;
  String? encryptedPassword;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  CartController cartController = Get.put(CartController());
  AppController controller = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000), // Adjust animation duration as needed
    );
    _animation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat(reverse: true); // Repeat the animation with reverse
    gotoOnboardScreenAfterDelay(2);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Image(
                  image: AssetImage("lib/core/assets/images/logos/splash_logo.png"),
                  width: screenSize.width * 0.85,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the animation controller
    super.dispose();
  }

  Future<void> gotoOnboardScreenAfterDelay(int delayInSeconds) async {
    await Future.delayed(Duration(seconds: delayInSeconds));
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    SplashScreen.email = sharedPref.getString(EMAIL);
    widget.encryptedPassword = sharedPref.getString(ENCRYPTEDPASSWORD);

    if (SplashScreen.email != null && widget.encryptedPassword != null) {
      print("have email and password");
      controller.isLoggedIn.value = true;
      cartController.getCartList();
      Get.offAll(() => MainPageScreen());
    } else {
      print("dont have email and password");
       controller.isLoggedIn.value = true;
      Get.offAll(() => OnboardingScreen());
    }
  }
}
