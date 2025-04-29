import 'package:get/get.dart';
import 'package:judeh_accounting/company/screens/company_screen.dart';
import 'package:judeh_accounting/home/screens/home_screen.dart';
import 'package:judeh_accounting/settings/screens/settings_screen.dart';

import 'logger_observer.dart';

abstract class AppRouter {
  static const settings = '/settings';

  static const home = '/home';

  static const company = '/company';

  static List<GetPage> get pages => [
        GetPage(name: home, page: () => HomeScreen()),
        GetPage(name: settings, page: () => SettingsScreen()),
        GetPage(name: company, page: () => CompanyScreen()),
      ];

  static final loggerObserver = LoggerObserver();
}
