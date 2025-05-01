import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerController extends GetxController {
  Widget? _widget;

  Widget? get widget => _widget;

  set widget(Widget? widget) {
    _widget = widget;
    update();
  }
}
