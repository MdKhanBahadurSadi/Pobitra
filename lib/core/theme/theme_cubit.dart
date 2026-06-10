import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Supported theme modes for Pobitra Browser.
enum AppThemeMode { system, light, dark, amoled }

/// Cubit to manage app-wide stateful theming and persistence.
class ThemeCubit extends Cubit<AppThemeMode> {
  final FlutterSecureStorage _secureStorage;
  static const String _themeKey = 'app_theme_mode';

  ThemeCubit({FlutterSecureStorage? secureStorage})
      : _secureStorage = secureStorage ?? const FlutterSecureStorage(),
        super(AppThemeMode.system) {
    _loadTheme();
  }

  /// Asynchronously loads the saved theme from secure storage.
  Future<void> _loadTheme() async {
    try {
      final String? savedTheme = await _secureStorage.read(key: _themeKey);
      if (savedTheme != null) {
        final loadedMode = AppThemeMode.values.firstWhere(
          (mode) => mode.name == savedTheme,
          orElse: () => AppThemeMode.system,
        );
        emit(loadedMode);
      }
    } catch (_) {
      // Fallback to default system theme if reading secure storage fails
      emit(AppThemeMode.system);
    }
  }

  /// Updates the theme mode and persists the choice to secure storage.
  Future<void> setThemeMode(AppThemeMode mode) async {
    emit(mode);
    try {
      await _secureStorage.write(key: _themeKey, value: mode.name);
    } catch (_) {
      // Fallback/Silent ignore if write fails
    }
  }
}
