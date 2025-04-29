import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:judeh_accounting/pocketbase/controllers/pocketbase_controller.dart';
import 'package:judeh_accounting/shared/local_storage/local_storage_helper.dart';
import 'package:judeh_accounting/shared/logger/app_logger.dart';
import 'package:judeh_accounting/shared/snackbar/snackbar_helper.dart';
import 'package:judeh_accounting/shared/widgets/app_text_form_field.dart';

class SettingsController extends GetxController {
  final storage = LocalStorageHelper.storage;

  bool connectedToServer = false;

  bool serverStarted = true;

  late final pocketbaseController = Get.find<PocketbaseController>();

  late String ipAddress = pocketbaseController.ipAddress ?? '';

  @override
  void onInit() {
    super.onInit();
    connectedToServer = pocketbase().baseURL.isNotEmpty;
    update();
  }

  void connectToServer() async {
    String ip = '';
    await Get.dialog(
      AlertDialog.adaptive(
        title: Text('الاتصال بجهاز آخر'),
        content: Form(
          child: Column(
            children: [
              AppTextFormField(
                keyboardType: TextInputType.numberWithOptions(signed: false),
                label: 'رقم الجهاز',
                onSaved: (value) => ip = value!,
              ),
              SizedBox(height: 10),
              Builder(builder: (context) {
                return ElevatedButton(
                  onPressed: () async {
                    if (Form.of(context).validate()) {
                      Form.of(context).save();
                      final url = 'http://$ip:8089';
                      final response =
                          await GetConnect().get('$url/_/');
                      if (response.statusCode != 200) {
                        SnackbarHelper.error(
                            description: 'رقم الجهاز غير موجود');
                        connectedToServer = false;
                      }
                      if (context.mounted) {
                        connectedToServer = true;
                        pocketbase().baseURL = url;
                        await storage.write(key: LocalStorageHelper.keys.ipServer, value: url);
                        AppLogger.info(pocketbase().baseURL);
                        SnackbarHelper.success(
                            description: 'تم ربط الجهاز بنجاح');
                        Navigator.of(context).pop();
                      }
                      update();
                    }
                  },
                  child: Text('اتصال'),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void stopServer() {
    pocketbaseController.stopServer();
    serverStarted = false;
    update();
  }

  void startServer() async{
    pocketbaseController.startServer();
    serverStarted = true;
   ipAddress = pocketbase().baseURL;
   update();
  }
}
