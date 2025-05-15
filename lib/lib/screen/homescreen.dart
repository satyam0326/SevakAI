import 'package:ai_chatbot/apis/apis.dart';
import 'package:ai_chatbot/helper/global.dart';
import 'package:ai_chatbot/helper/pref.dart';
import 'package:ai_chatbot/model/home_type.dart';
import 'package:ai_chatbot/widget/home_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final isDarkMode = Pref.isDarkMode.obs;
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _updateOnboardingPref();
  }

  Future<void> _updateOnboardingPref() async {
    await Pref.setShowOnboarding(false);
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.sizeOf(context);
    APIs.getAnswer('hii');
    return Scaffold(
      appBar: AppBar(
        title: Text(appName),
        actions: [
          IconButton(
            onPressed: () {
              Get.changeThemeMode(
                isDarkMode.value ? ThemeMode.light : ThemeMode.dark,
              );
              isDarkMode.value = !isDarkMode.value;
              Pref.isDarkMode = isDarkMode.value;
            },
            icon: Obx(
              () => Icon(
                isDarkMode.value
                    ? Icons.brightness_2_rounded
                    : Icons.brightness_5_rounded,
                color: Colors.blue,
                size: 26,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: mq.width * .05,
          vertical: mq.height * 0.01,
        ),
        children: HomeType.values.map((e) => HomeCard(homeType: e)).toList(),
      ).animate().fade(duration: Duration(seconds: 2)),
    );
  }
}
