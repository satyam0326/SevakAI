import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:ai_chatbot/helper/secrets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../helper/my_dialogs.dart';

enum Status { none, loading, complete }

class ImageController extends GetxController {
  final textC = TextEditingController();
  final status = Status.none.obs;
  final url = ''.obs;
  final imageList = <String>[].obs;

  // API KEYS
  static const _imagineApiKey =
      Secrets.imagineApiKey; // Replace with your real key
  static const _pexelsApiKey =
      Secrets.pexelsApiKey;

  Future<void> searchAiImage() async {
    if (textC.text.trim().isEmpty) {
      MyDialog.info('Provide some beautiful image description!');
      return;
    }

    status.value = Status.loading;
    final prompt = textC.text.trim();

    // Step 1: Try Imagine.art (Vyro)
    final imagineResult = await _generateFromImagine(prompt);

    if (imagineResult != null) {
      url.value = imagineResult;
      imageList.value = [imagineResult];
      status.value = Status.complete;
      return;
    }

    // Step 2: Fallback to Pexels
    final pexelsResults = await _searchFromPexels(prompt);
    if (pexelsResults.isNotEmpty) {
      url.value = pexelsResults.first;
      imageList.value = pexelsResults;
      status.value = Status.complete;
    } else {
      MyDialog.error('No image found from Imagine or Pexels.');
      status.value = Status.none;
    }
  }

  // 🧠 Primary AI Image Generation using Imagine.art API (Vyro)
  static Future<String?> _generateFromImagine(String prompt) async {
    try {
      final uri = Uri.parse('https://api.vyro.ai/v2/image/generations');

      final request =
          http.MultipartRequest('POST', uri)
            ..headers['Authorization'] = 'Bearer $_imagineApiKey'
            ..fields['prompt'] = prompt
            ..fields['style'] = 'realistic'
            ..fields['aspect_ratio'] = '1:1';

      final streamedResponse = await request.send();

      final contentType = streamedResponse.headers['content-type'];

      // 🧠 CASE 1: If it's JSON
      if (contentType != null && contentType.contains('application/json')) {
        final resBody = await streamedResponse.stream.bytesToString();
        final data = json.decode(resBody);
        return data['image_url'];
      }
      // 🧠 CASE 2: If it's an image (like image/png)
      else if (contentType != null && contentType.startsWith('image/')) {
        final bytes = await streamedResponse.stream.toBytes();

        final tempDir = await getTemporaryDirectory();
        final filePath =
            '${tempDir.path}/imagine_${DateTime.now().millisecondsSinceEpoch}.png';

        final file = File(filePath);
        await file.writeAsBytes(bytes);

        return file.path; // 🟢 This is a local file path
      }

      log('[Imagine API] Unexpected content-type: $contentType');
      return null;
    } catch (e) {
      log('Imagine API Exception: $e');
      return null;
    }
  }

  // 📷 Fallback Pexels Image Search
  static Future<List<String>> _searchFromPexels(String prompt) async {
    try {
      final response = await http.get(
        Uri.parse('https://api.pexels.com/v1/search?query=$prompt&per_page=10'),
        headers: {'Authorization': _pexelsApiKey},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final photos = data['photos'] as List;

        return photos
            .map((photo) => photo['src']['medium'].toString())
            .toList();
      } else {
        log('Pexels API error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Pexels API Exception: $e');
      return [];
    }
  }
}
