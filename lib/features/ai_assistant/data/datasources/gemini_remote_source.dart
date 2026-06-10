import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiRemoteSource {
  final String _apiKey = const String.fromEnvironment('GEMINI_API_KEY');

  late final GenerativeModel _flashModel;
  late final GenerativeModel _proModel;

  GeminiRemoteSource() {
    _flashModel = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: _apiKey,
      generationConfig: GenerationConfig(
        temperature: 0.2,
      ),
    );

    _proModel = GenerativeModel(
      model: 'gemini-1.5-pro',
      apiKey: _apiKey,
    );
  }

  Future<String> summarizePage(String content) async {
    final prompt = [
      Content.text(
        'Please provide a concise summary of the following web page content. '
        'The summary must be in Bengali (বাংলা). '
        'Content: $content'
      )
    ];

    final response = await _flashModel.generateContent(prompt);
    return response.text ?? 'Summary unavailable.';
  }

  ChatSession startChat(List<Content> history) {
    return _proModel.startChat(history: history);
  }

  Future<String> askQuestion(ChatSession chat, String question, String context) async {
    final response = await chat.sendMessage(
      Content.text(
        'Use the following context to answer the question if relevant. '
        'Context: $context\n\n'
        'Question: $question'
      ),
    );
    return response.text ?? 'I could not process that request.';
  }
}
