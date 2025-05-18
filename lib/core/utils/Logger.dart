import 'package:flutter/foundation.dart';

enum LogLevel {
  debug,
  info,
  warn,
  error,
}

class Logger {
  static Logger? _instance;
  bool _isDebug = false;

  Logger._internal();

  static Logger getInstance() {
    _instance ??= Logger._internal();
    return _instance!;
  }

  void enableDebug() {
    _isDebug = true;
  }

  String _formatMessage(LogLevel level, String message, [dynamic data]) {
    final timestamp = DateTime.now().toIso8601String();
    final dataString = data != null ? '\nData: ${_stringify(data)}' : '';
    return '[${timestamp}] ${level.name.toUpperCase()}: ${message}${dataString}';
  }

  String _stringify(dynamic obj) {
    if (obj is BigInt) {
      return obj.toString();
    } else if (obj is Map) {
      return '{${obj.entries.map((e) => '"${e.key}": ${_stringify(e.value)}').join(', ')}}';
    } else if (obj is List) {
      return '[${obj.map((e) => _stringify(e)).join(', ')}]';
    } else {
      return obj.toString();
    }
  }

  void debug(String message, [dynamic data]) {
    if (_isDebug) {
      debugPrint(_formatMessage(LogLevel.debug, message, data));
    }
  }

  void info(String message, [dynamic data]) {
    debugPrint(_formatMessage(LogLevel.info, message, data));
  }

  void warn(String message, [dynamic data]) {
    debugPrint(_formatMessage(LogLevel.warn, message, data));
  }

  void error(String message, [dynamic error]) {
    debugPrint(_formatMessage(LogLevel.error, message, error));
  }
}

final logger = Logger.getInstance();

void main() {
  logger.info('Application started.');
  logger.debug('Debugging is currently disabled.');

  logger.enableDebug();
  logger.debug('Debugging enabled.');

  logger.info('Processing user request...', {'userId': 123, 'action': 'login'});

  logger.warn('Potential issue: Low disk space.', {'available': '1GB'});

  try {
    int.parse('abc');
  } catch (e) {
    logger.error('Error during parsing:', e);
  }

  logger.info('Application finished.');
}
