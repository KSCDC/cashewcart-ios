import 'package:flutter/material.dart';
import 'package:internship_sample/presentation/onboarding/onboarding_screen.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    gotoOnboardScreenAfterDelay(2);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Image(
                image:
                    AssetImage("lib/core/assets/images/logos/app_logo.png"),
                height: 100,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> gotoOnboardScreenAfterDelay(int delayInSeconds) async {
    await Future.delayed(Duration(seconds: delayInSeconds));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => OnboardingScreen(),
      ),
    );
  }
}
