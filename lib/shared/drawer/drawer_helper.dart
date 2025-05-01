import 'package:flutter/material.dart' hide DrawerController;
import 'package:get/get.dart';

import 'drawer_controller.dart';

abstract class DrawerHelper {
  static void openEndDrawer(
      {required Widget widget, required BuildContext context}) {
    final controller = Get.find<DrawerController>();
    controller.widget = null;
    controller.widget = widget;
    Scaffold.of(context).openEndDrawer();
  }
}
