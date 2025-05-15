import 'package:ai_chatbot/apis/apis.dart';
import 'package:ai_chatbot/helper/my_dialogs.dart';
import 'package:ai_chatbot/model/message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final textC = TextEditingController();
  final scrollC = ScrollController();
  final list =
      <Message>[
        Message(msg: 'Namaste, How can I help you?', msgType: MessageType.bot),
      ].obs;

  Future<void> askQuestion() async {
    if (textC.text.trim().isNotEmpty) {
      list.add(Message(msg: textC.text, msgType: MessageType.user));
      list.add(Message(msg: '', msgType: MessageType.bot));
      _scrollDown(); // Now this will work
      final res = await APIs.getAnswer(textC.text);
      list.removeLast();
      list.add(Message(msg: res, msgType: MessageType.bot));
      _scrollDown(); // Now this will work
      textC.text = '';
    } else {
      MyDialog.info('Ask Something');
    }
  }

  // Moved inside the class
  void _scrollDown() {
    scrollC.animateTo(
      scrollC.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
}
