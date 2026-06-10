import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/reader_content.dart';

enum ReaderTheme { white, sepia, amoled }

class ReaderModeState {
  final bool isEnabled;
  final ReaderContent? content;
  final ReaderTheme theme;
  final double fontSize;
  final String fontFamily;
  final bool isPlaying;
  final double playbackSpeed;

  ReaderModeState({
    this.isEnabled = false,
    this.content,
    this.theme = ReaderTheme.white,
    this.fontSize = 18.0,
    this.fontFamily = 'Sans-Serif',
    this.isPlaying = false,
    this.playbackSpeed = 1.0,
  });

  ReaderModeState copyWith({
    bool? isEnabled,
    ReaderContent? content,
    ReaderTheme? theme,
    double? fontSize,
    String? fontFamily,
    bool? isPlaying,
    double? playbackSpeed,
  }) {
    return ReaderModeState(
      isEnabled: isEnabled ?? this.isEnabled,
      content: content ?? this.content,
      theme: theme ?? this.theme,
      fontSize: fontSize ?? this.fontSize,
      fontFamily: fontFamily ?? this.fontFamily,
      isPlaying: isPlaying ?? this.isPlaying,
      playbackSpeed: playbackSpeed ?? this.playbackSpeed,
    );
  }
}

class ReaderModeCubit extends Cubit<ReaderModeState> {
  ReaderModeCubit() : super(ReaderModeState());

  void enterReaderMode(ReaderContent content) {
    emit(state.copyWith(isEnabled: true, content: content));
  }

  void exitReaderMode() {
    emit(state.copyWith(isEnabled: false, isPlaying: false));
  }

  void setTheme(ReaderTheme theme) {
    emit(state.copyWith(theme: theme));
  }

  void setFontSize(double size) {
    emit(state.copyWith(fontSize: size));
  }

  void setFontFamily(String family) {
    emit(state.copyWith(fontFamily: family));
  }

  void togglePlayback() {
    emit(state.copyWith(isPlaying: !state.isPlaying));
  }

  void setPlaybackSpeed(double speed) {
    emit(state.copyWith(playbackSpeed: speed));
  }
}
