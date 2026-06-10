import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

enum VaultStatus { locked, authenticating, unlocked, error, unsupported }

class VaultState {
  final VaultStatus status;
  final String? errorMessage;

  VaultState({
    this.status = VaultStatus.locked,
    this.errorMessage,
  });

  VaultState copyWith({
    VaultStatus? status,
    String? errorMessage,
  }) {
    return VaultState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class VaultCubit extends Cubit<VaultState> {
  final LocalAuthentication _auth = LocalAuthentication();

  VaultCubit() : super(VaultState());

  Future<void> unlockVault() async {
    try {
      final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
      final bool canAuthenticate = canAuthenticateWithBiometrics || await _auth.isDeviceSupported();

      if (!canAuthenticate) {
        emit(state.copyWith(status: VaultStatus.unsupported));
        return;
      }

      emit(state.copyWith(status: VaultStatus.authenticating));

      final bool didAuthenticate = await _auth.authenticate(
        localizedReason: 'Please authenticate to access your saved passwords',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
        ),
      );

      if (didAuthenticate) {
        emit(state.copyWith(status: VaultStatus.unlocked));
      } else {
        emit(state.copyWith(status: VaultStatus.locked));
      }
    } catch (e) {
      emit(state.copyWith(
        status: VaultStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void lockVault() {
    emit(state.copyWith(status: VaultStatus.locked));
  }
}
