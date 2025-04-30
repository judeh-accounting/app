import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:judeh_accounting/shared/widgets/app_button.dart';

abstract class DialogHelper{
  static Future<bool> confirmDelete() async => await Get.dialog(AlertDialog.adaptive(
    title: Text('حذف', style: TextTheme.of(Get.context!).bodyMedium?.copyWith(color: Colors.red),),
    content: Text('هل انت متأكد من الحذف؟ (لا يمكنك استعادته لاحقاً)'),
    actions: [
      AppButton(onPressed: () => Get.back(result: true), text: 'موافق'),
      AppButton.secondary(onPressed: () => Get.back(result: false), text: 'إلغاء الامر'),
    ],
  ),);
}