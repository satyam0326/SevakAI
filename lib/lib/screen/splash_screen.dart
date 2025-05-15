import 'package:ai_chatbot/helper/global.dart';
import 'package:ai_chatbot/helper/pref.dart';
import 'package:ai_chatbot/screen/homescreen.dart';
import 'package:ai_chatbot/screen/onboarding_screen.dart';
import 'package:ai_chatbot/widget/custom_loading.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder:
              (_) => Pref.showOnboarding() ? OnboardingScreen() : HomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Center(child: CustomLoading())],
      ),
    );
  }
}
