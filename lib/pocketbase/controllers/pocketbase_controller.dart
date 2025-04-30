import 'package:get/get.dart';
import 'package:judeh_accounting/pocketbase/constants/pocketbase_collections.dart';
import 'package:judeh_accounting/shared/local_storage/local_storage_helper.dart';
import 'package:judeh_accounting/shared/snackbar/snackbar_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:pocketbase_server_flutter/pocketbase_server_flutter.dart';

class PocketbaseController extends GetxController {
  String? _localIpAddress;

  String? get ipAddress => _localIpAddress;

  static const adminEmail = 'test@test.com';

  static const adminPassword = 'password';

  static const port = '8089';

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
      superUserEmail: adminEmail,
      superUserPassword: adminPassword,
      pocketbaseExecutable: GetPlatform.isWindows ? path : null,
      port: port,
      hostName: _localIpAddress = await PocketbaseServerFlutter.localIpAddress,
    );

    if(_localIpAddress != null) {
      pocketbase.baseURL = 'http://$_localIpAddress:8089';
      await _storage.write(key: LocalStorageHelper.keys.ipServer, value: pocketbase.baseURL);

      loginAsAdmin();
    }

    update();
  }

  void stopServer() async => await PocketbaseServerFlutter.stop();

  final pocketbase = PocketBase('');

    final _storage = LocalStorageHelper.storage;
  void _loadIpServer() async {

    pocketbase.baseURL =
        await _storage.read(key: LocalStorageHelper.keys.ipServer) ?? '';

    try{
      await GetConnect().get('${pocketbase.baseURL}/_/');
    }catch(_){
      await _storage.delete(key: LocalStorageHelper.keys.ipServer);
      SnackbarHelper.error(
          description:
              'لقد تم فقدان الاتصال بالجهاز. تأكد من انك على نفس شبكة الجهاز وان الجهاز يعمل.');
    }
  }

  void loginAsAdmin() async => await pocketbase
      .collection(PocketbaseCollections.superusers)
      .authWithPassword(adminEmail, adminPassword);
}

PocketBase pocketbase() => Get.find<PocketbaseController>().pocketbase;
