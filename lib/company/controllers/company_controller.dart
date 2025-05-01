import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:judeh_accounting/company/controllers/create_edit_company_controller.dart';
import 'package:judeh_accounting/company/widgets/create_edit_company.dart';
import 'package:judeh_accounting/pocketbase/constants/pocketbase_collections.dart';
import 'package:judeh_accounting/pocketbase/controllers/pocketbase_controller.dart';
import 'package:judeh_accounting/pocketbase/helpers/pocketbase_helper.dart';
import 'package:judeh_accounting/shared/dialog/dialog_helper.dart';
import 'package:judeh_accounting/shared/drawer/drawer_helper.dart';
import 'package:judeh_accounting/shared/loader/loader_mixin.dart';
import 'package:judeh_accounting/shared/logger/app_logger.dart';
import 'package:judeh_accounting/shared/snackbar/snackbar_helper.dart';

import '../models/company.dart';

class CompanyController extends GetxController with HasLoaderMixin {
  final companies = <Company>[];

  BuildContext? context;

  int _totalPages = 0;
  int _totalItems = 0;
  int _page = 1;

  int get totalPages => _totalPages;
  int get totalItems => _totalItems;
  int get page => _page;

  set page(int value) {
    _page = value;
    _loadCompanies();
  }

  @override
  void onInit() {
    super.onInit();
    _loadCompanies();
    PocketbaseHelper.polling(
        collectionName: PocketbaseCollections.companies,
        onPoll: _loadCompanies);
  }

  void delete(Company company) async {
    if (!await DialogHelper.confirmDelete()) return;

    try {
      await pocketbase()
          .collection(PocketbaseCollections.companies)
          .delete(company.id);
    } catch (e, track) {
      AppLogger.exception(e, track);
    }
    SnackbarHelper.success(description: 'تم الحذف بنجاح');
  }

  void _loadCompanies() async {
    startLoading();

    final response =
        await pocketbase().collection(PocketbaseCollections.companies).getList(
              page: _page,
              perPage: 10,
            );
    companies.clear();

    companies.addAll(response.items.map((e) => Company.fromMap(e.data)));
    _totalPages = response.totalPages;
    _totalItems = response.totalItems;
    _page = response.page;

    stopLoading();
  }

  void create() {
    if (Get.isRegistered<CreateEditCompanyController>()) {
      Get.find<CreateEditCompanyController>().company = null;
    }
    DrawerHelper.openEndDrawer(widget: CreateEditCompany(), context: context!);
  }

  void edit(Company company) {
    if (Get.isRegistered<CreateEditCompanyController>()) {
      Get.find<CreateEditCompanyController>().company = company;
    }
    DrawerHelper.openEndDrawer(widget: CreateEditCompany(), context: context!);
  }
}
