// ignore_for_file: unused_element

import 'dart:convert';
import 'dart:io';

import 'dart:developer';
import 'package:ai_chatbot/helper/secrets.dart';
import 'package:http/http.dart';

import 'package:translator_plus/translator_plus.dart';

class APIs {
  static Future<String> getAnswer(String question) async {
    try {
      final res = await post(
        Uri.parse(
          'https://api.openai.com/v1/chat/completions',
        ), // ✅ Correct endpoint
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer ${Secrets.openaiApiKey}',
        },
        body: jsonEncode({
          "model": "gpt-4o-mini",
          "max_tokens": 2000,
          "temperature": 0,
          "messages": [
            {"role": "user", "content": question},
          ],
        }),
      );

      final data = jsonDecode(res.body);
      log('res: $data');
      return data['choices'][0]['message']['content'];
    } catch (e) {
      log('getAnswerE: $e');
      return 'Something went wrong (Try again after some time)';
    }
  }

  static Future<String> googleTranslate({
    required String from,
    required String to,
    required String text,
  }) async {
    try {
      final res = await GoogleTranslator().translate(text, from: from, to: to);
      return res.text;
    } catch (e) {
      log('googleTranslateE: $e');
      return 'Something went wrong!';
    }
  }

  static Future<List<String>> searchAiImages(String prompt) async {
    try {
      if (prompt.trim().isEmpty) return [];

      final res = await get(
        Uri.parse('https://lexica.art/api/v1/search?q=$prompt'),
      );

      log('Lexica response: ${res.body}');

      if (res.statusCode != 200) {
        log('Lexica API failed: ${res.statusCode}');
        return [];
      }

      final data = jsonDecode(res.body);

      return List.from(data['images']).map((e) => e['src'].toString()).toList();
    } catch (e) {
      log('searchAiImagesE: $e');
      return [];
    }
  }
}
