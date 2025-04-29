import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:judeh_accounting/shared/logger/app_logger.dart';

abstract class LocalStorageHelper {
  static void initFlutterSecureStorage() {
    Get.put(FlutterSecureStorage(), permanent: true);
    AppLogger.warning('flutter secure storage initialized');
  }

  static FlutterSecureStorage get storage => Get.find();

  static final keys = _Keys();
}

class _Keys {
  final ipServer = 'ip_server';

  _Keys();
}