import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_tts/flutter_tts.dart';

class TranslatorController extends GetxController {
  var isLoading = false.obs;
  var translatedText = "".obs;
  final FlutterTts flutterTts = FlutterTts();

  Future<void> translate(String text, String from, String to) async {
    if (text.isEmpty) return;

    isLoading.value = true;

    try {
      final encodedText = Uri.encodeComponent(text);
      final url = Uri.parse(
        "https://api.mymemory.translated.net/get?q=$encodedText&langpair=$from|$to",
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        translatedText.value = data['responseData']['translatedText'] ?? "Error";
      } else {
        translatedText.value = "Error: ${response.statusCode}";
      }
    } catch (e) {
      translatedText.value = "Error: $e";
    }

    isLoading.value = false;
  }

  Future<void> speak() async {
    if (translatedText.value.isNotEmpty) {
      await flutterTts.speak(translatedText.value);
    }
  }
}
