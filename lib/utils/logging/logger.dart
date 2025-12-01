import 'dart:developer' as dev;

class AppLogger {
  AppLogger._();

  static void info(String message) {
    dev.log(message, name: 'INFO');
  }

  static void warn(String message) {
    dev.log(message, name: 'WARN');
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    dev.log(
      message,
      name: 'ERROR',
      error: error,
      stackTrace: stackTrace,
    );
  }
}
