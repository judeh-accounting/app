import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/dialog/dialog_route.dart';
import 'package:judeh_accounting/shared/logger/app_logger.dart';

class LoggerObserver extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);

    AppLogger.info(
        'Route name is: ${_extractRouteName(route)}, Route args is: ${_extractRouteArgs(route)}');
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);

    AppLogger.info(
        'Route name is: ${_extractRouteName(route)}, Route args is: ${_extractRouteArgs(route)}');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);

    AppLogger.info(
        'Route name is: ${_extractRouteName(route)}, Route args is: ${_extractRouteArgs(route)}');
  }
}

dynamic _extractRouteArgs(Route? route) => route!.settings.arguments;

String? _extractRouteName(Route? route) {
  AppLogger.info(route?.settings);
  if (route?.settings.name != null) {
    return route!.settings.name;
  }

  if (route is GetPageRoute) {
    return route.routeName;
  }

  if (route is GetDialogRoute) {
    return 'DIALOG ${route.hashCode}';
  }

  if (route is GetModalBottomSheetRoute) {
    return 'BOTTOMSHEET ${route.hashCode}';
  }

  return null;
}
