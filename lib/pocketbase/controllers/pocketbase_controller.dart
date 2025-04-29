import 'package:get/get.dart';
import 'package:judeh_accounting/shared/local_storage/local_storage_helper.dart';
import 'package:judeh_accounting/shared/snackbar/snackbar_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:pocketbase_server_flutter/pocketbase_server_flutter.dart';

class PocketbaseController extends GetxController {
  String? _localIpAddress;

  String? get ipAddress => _localIpAddress;

  @override
  void onInit() {
    startServer();
    _loadIpServer();
    super.onInit();
  }

  void startServer() async {
    PocketbaseServerFlutter.notificationTitle = 'Judeh accounting';
    PocketbaseServerFlutter.notificationBody =
        'Judeh accounting running in the background';

    final path =
        '${(await getApplicationDocumentsDirectory()).path}/judeh_accounting/pocketbase.exe';

    await PocketbaseServerFlutter.start(
      superUserEmail: 'test@test.com',
      superUserPassword: 'password',
      pocketbaseExecutable: GetPlatform.isWindows ? path : null,
      port: '8089',
      hostName: _localIpAddress = await PocketbaseServerFlutter.localIpAddress,
    );

    pocketbase.baseURL = _localIpAddress ?? '';

    update();
  }

  void stopServer() async => await PocketbaseServerFlutter.stop();

  final pocketbase = PocketBase('');

  void _loadIpServer() async{
    final storage = LocalStorageHelper.storage;

    pocketbase.baseURL = await storage.read(key: LocalStorageHelper.keys.ipServer) ?? '';
    
    final response= await GetConnect().get('${pocketbase.baseURL}/_/');
    if(response.statusCode != 200) {
      await storage.delete(key: LocalStorageHelper.keys.ipServer);
      SnackbarHelper.error(description: 'لقد تم فقدان الاتصال بالجهاز. تأكد من انك على نفس شبكة الجهاز وان الجهاز يعمل.');
    }
  }
}

PocketBase pocketbase() => Get.find<PocketbaseController>().pocketbase;
