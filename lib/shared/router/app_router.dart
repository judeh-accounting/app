import 'package:get/get.dart';
import 'package:judeh_accounting/home/screens/home_screen.dart';
import 'package:judeh_accounting/settings/screens/settings_screen.dart';

import 'logger_observer.dart';

abstract class AppRouter {
  static const settings = '/settings';

  static const home = '/home';

  static List<GetPage> get pages => [
        GetPage(name: home, page: () => HomeScreen()),
        GetPage(name: settings, page: () => SettingsScreen()),
      ];

  static final loggerObserver = LoggerObserver();
}
