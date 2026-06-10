import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../../data/datasources/gemini_remote_source.dart';

enum AiAssistantStatus { initial, loading, success, failure }

class AiAssistantState {
  final AiAssistantStatus status;
  final String? summary;
  final List<Content> chatHistory;
  final String? errorMessage;
  final String? pageContext;

  AiAssistantState({
    this.status = AiAssistantStatus.initial,
    this.summary,
    this.chatHistory = const [],
    this.errorMessage,
    this.pageContext,
  });

  AiAssistantState copyWith({
    AiAssistantStatus? status,
    String? summary,
    List<Content>? chatHistory,
    String? errorMessage,
    String? pageContext,
  }) {
    return AiAssistantState(
      status: status ?? this.status,
      summary: summary ?? this.summary,
      chatHistory: chatHistory ?? this.chatHistory,
      errorMessage: errorMessage ?? this.errorMessage,
      pageContext: pageContext ?? this.pageContext,
    );
  }
}

class AiAssistantCubit extends Cubit<AiAssistantState> {
  final GeminiRemoteSource _remoteSource;
  ChatSession? _chatSession;

  AiAssistantCubit(this._remoteSource) : super(AiAssistantState());

  Future<void> summarizePage(String content) async {
    emit(state.copyWith(status: AiAssistantStatus.loading, pageContext: content));
    try {
      final summary = await _remoteSource.summarizePage(content);
      emit(state.copyWith(status: AiAssistantStatus.success, summary: summary));
    } catch (e) {
      emit(state.copyWith(status: AiAssistantStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> askQuestion(String question) async {
    if (state.pageContext == null) return;

    final updatedHistory = List<Content>.from(state.chatHistory)
      ..add(Content.text(question));
    
    emit(state.copyWith(status: AiAssistantStatus.loading, chatHistory: updatedHistory));

    try {
      _chatSession ??= _remoteSource.startChat([]);
      final response = await _remoteSource.askQuestion(
        _chatSession!,
        question,
        state.pageContext!,
      );

      final finalHistory = List<Content>.from(updatedHistory)
        ..add(Content.model([TextPart(response)]));

      emit(state.copyWith(status: AiAssistantStatus.success, chatHistory: finalHistory));
    } catch (e) {
      emit(state.copyWith(status: AiAssistantStatus.failure, errorMessage: e.toString()));
    }
  }

  void reset() {
    _chatSession = null;
    emit(AiAssistantState());
  }
}

extension ContentTextExtension on Content {
  String get textContent => parts
      .whereType<TextPart>()
      .map((p) => p.text)
      .join();
}
