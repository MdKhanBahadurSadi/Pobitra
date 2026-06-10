import 'package:flutter_bloc/flutter_bloc.dart';

class AdBlockerState {
  final int blockedCount;
  final bool isEnabled;

  AdBlockerState({
    this.blockedCount = 0,
    this.isEnabled = true,
  });

  AdBlockerState copyWith({
    int? blockedCount,
    bool? isEnabled,
  }) {
    return AdBlockerState(
      blockedCount: blockedCount ?? this.blockedCount,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}

class AdBlockerCubit extends Cubit<AdBlockerState> {
  AdBlockerCubit() : super(AdBlockerState());

  void incrementBlockedCount() {
    emit(state.copyWith(blockedCount: state.blockedCount + 1));
  }

  void toggleAdBlocker(bool enabled) {
    emit(state.copyWith(isEnabled: enabled));
  }
}
