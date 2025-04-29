import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

abstract class AppLogger {
  static final _logger = Logger();

  static info(message) => _logger.i(message);

  static exception(message) => _logger.e(message);

  static warning(message) => _logger.w(message);

  static initializeLoggerForFlutterError() => FlutterError.onError = (error) {
        exception(error.exception);
      };
}
