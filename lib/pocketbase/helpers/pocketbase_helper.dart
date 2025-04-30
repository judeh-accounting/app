import 'package:pocketbase/pocketbase.dart';

import '../../shared/logger/app_logger.dart';
import '../constants/pocketbase_collections.dart';
import '../controllers/pocketbase_controller.dart';

abstract class PocketbaseHelper {
  static Future<Future<void> Function()> subscribe<T>({
    String topic = '*',
    required String collectionName,
    required T Function(Map<String, dynamic> event) convertToModel,
    required Function(T model) onCreate,
    required Function(T model) onUpdate,
    required Function(T model) onDelete,
    required Function() callbackAfterListening,
  }) async {
    AppLogger.warning('listening to $collectionName for $topic');
    return await pocketbase().collection(collectionName).subscribe(topic,
        (event) {
      AppLogger.warning('$collectionName event triggered: $event');
      final model = convertToModel(event.record!.data);
      switch (event.action) {
        case 'delete':
          onDelete(model);
          break;
        case 'create':
          onCreate(model);
          break;
        case 'update':
          onUpdate(model);
          break;
        default:
      }
      callbackAfterListening();
    });
  }
}
