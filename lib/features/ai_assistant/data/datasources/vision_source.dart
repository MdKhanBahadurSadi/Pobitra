import 'dart:typed_data';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:convert';
import 'dart:developer';

class VisionSource {
  final String _apiKey = const String.fromEnvironment('GEMINI_API_KEY');
  late final GenerativeModel _model;

  VisionSource() {
    _model = GenerativeModel(
      model: 'gemini-1.5-pro',
      apiKey: _apiKey,
    );
  }

  Future<String> analyzeImage(Uint8List imageBytes) async {
    try {
      final prompt = [
        Content.multi([
          TextPart('এই ছবিটি গুরুত্বসহকারে বিশ্লেষণ করো এবং বাংলায় সংক্ষেপে ৩ লাইনে তথ্যভিত্তিক বিবরণ দাও এটি কী বা এখানে কী ঘটছে।'),
          DataPart('image/jpeg', imageBytes),
        ])
      ];

      final response = await _model.generateContent(prompt);
      return response.text ?? 'বিশ্লেষণ পাওয়া যায়নি।';
    } catch (e) {
      log('Vision analysis error: $e');
      if (e.toString().contains('429')) return 'API rate limit exceeded. Please try again later.';
      return 'Error analyzing image.';
    }
  }

  Future<Map<String, dynamic>> parseScreenshot(Uint8List imageBytes) async {
    try {
      final prompt = [
        Content.multi([
          TextPart(
            "Extract all semantic texts, contact details, payment invoices, or map coordinates from this screenshot. "
            "Return the parsed information strictly in raw minified JSON format matching these keys: "
            "{'text': string, 'has_bill': boolean, 'has_contact': boolean, 'extracted_details': string}. "
            "Do not write markdown wraps like ```json."
          ),
          DataPart('image/jpeg', imageBytes),
        ])
      ];

      final response = await _model.generateContent(prompt);
      final cleanJson = response.text?.trim() ?? '{}';
      return jsonDecode(cleanJson);
    } catch (e) {
      log('Screenshot parsing error: $e');
      return {'text': '', 'has_bill': false, 'has_contact': false, 'extracted_details': 'Error parsing screenshot.'};
    }
  }

  Future<String> factCheck(String text) async {
    try {
      final prompt = [
        Content.text(
          "Determine the accuracy of the following statement based on verified worldwide data. "
          "Classify it strictly into one of three words: 'True', 'False', or 'Misleading'. "
          "Followed immediately by a clean 2-line explanation written exclusively in Bengali.\n\n"
          "Statement: $text"
        )
      ];

      final response = await _model.generateContent(prompt);
      return response.text ?? 'Unknown';
    } catch (e) {
      log('Fact check error: $e');
      return 'Error';
    }
  }
}
