import 'package:ai_chatbot/helper/global.dart';
import 'package:ai_chatbot/model/onboard.dart';
import 'package:ai_chatbot/screen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  final double lottieHeightFactor = 0.5;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    if (_pageController.page!.round() < 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final list = [
      Onboard(
        title: 'Smart Conversations with AI',
        subtitle:
            'Chat freely and get instant, accurate answers to all your questions powered by cutting-edge AI',
        lottie: 'aichatonboard',
      ),
      Onboard(
        title: 'Create Stunning Images Instantly',
        subtitle:
            'Bring your imagination to life — generate unique AI-powered artworks or explore beautiful photos',
        lottie: 'ai_ask',
      ),
      Onboard(
        title: 'Break Language Barriers',
        subtitle:
            'Translate text seamlessly between multiple languages with fast and reliable AI translation',
        lottie: 'aiimagine',
      ),
    ];

    return Scaffold(
      body: PageView(
        controller: _pageController,
        children:
            list.map((item) {
              final isLast = list.indexOf(item) == list.length - 1;

              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      height: mq.height * lottieHeightFactor,
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Lottie.asset(
                        'assets/${item.lottie}.json',
                        fit: BoxFit.contain,
                      ),
                    ),

                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: mq.height * 0.02),

                    Text(
                      item.subtitle,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),

                    const Spacer(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        list.length,
                        (index) => Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                list.indexOf(item) == index
                                    ? Colors.blue
                                    : Colors.grey,
                          ),
                        ),
                      ),
                    ),

                    const Spacer(),

                    SizedBox(
                      width: mq.width * 0.6,
                      child: ElevatedButton(
                        onPressed: _goToNextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: Text(
                          isLast ? 'Get Started' : 'Next',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: mq.height * 0.05),
                  ],
                ),
              );
            }).toList(),
      ),
    );
  }
}
