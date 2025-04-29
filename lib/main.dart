import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:judeh_accounting/pocketbase/controllers/pocketbase_controller.dart';
import 'package:judeh_accounting/shared/local_storage/local_storage_helper.dart';
import 'package:judeh_accounting/shared/logger/app_logger.dart';
import 'package:judeh_accounting/shared/router/app_router.dart';

void main() async {
  AppLogger.initializeLoggerForFlutterError();

  LocalStorageHelper.initFlutterSecureStorage();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: PocketbaseController(),
        builder: (_) {
          return GetMaterialApp(
            title: 'Judeh Accounting',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
              useMaterial3: true,
            ),
            getPages: AppRouter.pages,
            initialRoute: AppRouter.home,
            navigatorObservers: [
              AppRouter.loggerObserver,
            ],
            debugShowCheckedModeBanner: false,
            locale: Locale('ar'),
          );
        });
  }
}
