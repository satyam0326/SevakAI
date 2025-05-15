import 'package:ai_chatbot/screen/chatbot_feature.dart';
import 'package:ai_chatbot/screen/image_feature.dart';
import 'package:ai_chatbot/screen/translator_feature.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum HomeType { aiChatbot, aiImage, aiTranslator }

extension MyHomeType on HomeType {
  String get title => switch (this) {
    HomeType.aiChatbot => 'SevakTalk',
    HomeType.aiImage => 'SevakImagine',
    HomeType.aiTranslator => 'SevakTranslate',
  };
  String get lottie => switch (this) {
    HomeType.aiChatbot => 'loading.json',
    HomeType.aiImage => 'sevakimg.json',
    HomeType.aiTranslator => 'ai_ask.json',
  };
  bool get leftAlign => switch (this) {
    HomeType.aiChatbot => true,
    HomeType.aiImage => false,
    HomeType.aiTranslator => true,
  };
  EdgeInsets get padding => switch (this) {
    HomeType.aiChatbot => EdgeInsets.zero,
    HomeType.aiImage => EdgeInsets.zero,
    HomeType.aiTranslator => EdgeInsets.zero,
  };
  VoidCallback get onTap => switch (this) {
    HomeType.aiChatbot => () => Get.to(() => ChatBotFeature()),
    HomeType.aiImage => () => Get.to(() => ImageFeature()),
    HomeType.aiTranslator => () => Get.to(() => TranslatorFeature()),
  };
}
