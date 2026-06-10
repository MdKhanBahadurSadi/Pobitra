import 'dart:developer' as dev;

class TelemetryGuard {
  static final TelemetryGuard _instance = TelemetryGuard._internal();
  factory TelemetryGuard() => _instance;
  TelemetryGuard._internal();

  /// Sanitizes messages by removing sensitive patterns like passwords or tokens.
  String sanitizeLog(String rawMessage) {
    // Eliminate matching credential strings or query attributes
    String sanitized = rawMessage.replaceAll(
      RegExp(r'password=[^&]*|token=[^&]*|apikey=[^&]*|secret=[^&]*', caseSensitive: false),
      'FILTERED'
    );
    
    // Remove potential email addresses or generic sensitive patterns if needed
    // sanitized = sanitized.replaceAll(RegExp(r'[\w-\.]+@([\w-]+\.)+[\w-]{2,4}'), '[EMAIL]');
    
    return sanitized;
  }

  /// Logs a sanitized message to the console and potentially remote telemetry.
  void log(String message, {Object? error, StackTrace? stackTrace, String name = 'Pobitra'}) {
    final sanitizedMessage = sanitizeLog(message);
    
    dev.log(
      sanitizedMessage,
      name: name,
      error: error,
      stackTrace: stackTrace,
    );

    // In production, send to Firebase Crashlytics or Sentry here:
    // if (!kDebugMode) {
    //   FirebaseCrashlytics.instance.log(sanitizedMessage);
    //   if (error != null) FirebaseCrashlytics.instance.recordError(error, stackTrace);
    // }
  }
}

/// Global logger shortcut
final logger = TelemetryGuard();
