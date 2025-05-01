import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:judeh_accounting/company/models/company.dart';
import 'package:judeh_accounting/pocketbase/constants/pocketbase_collections.dart';
import 'package:judeh_accounting/pocketbase/controllers/pocketbase_controller.dart';
import 'package:judeh_accounting/shared/loader/loader_mixin.dart';
import 'package:judeh_accounting/shared/logger/app_logger.dart';

class CreateEditCompanyController extends GetxController with HasLoaderMixin {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final descriptionController = TextEditingController();

  Company? _company;

  bool get isEdit => _company != null;

  set company(Company? company) {
    _company = company;
    loadCompanyForEdit();
  }

  void loadCompanyForEdit() {
    AppLogger.info('company is $_company');
    if (_company != null) {
      nameController.text = _company!.name;
      phoneController.text = _company!.phone ?? '';
      descriptionController.text = _company!.description ?? '';
    } else {
      _clear();
    }
  }

  void create(BuildContext context) async {
    if (!Form.of(context).validate()) return;

    startLoading();

    try {
      if (_company != null) {
        final editedCompany = _company!.copyWith(
          name: nameController.text,
          phone: phoneController.text,
          description: descriptionController.text,
        );
        await pocketbase().collection(PocketbaseCollections.companies).update(
              editedCompany.id,
              body: editedCompany.toMap(),
            );
        if (context.mounted) Scaffold.of(context).closeEndDrawer();
        _clear();
      } else {
        final company = Company(
          name: nameController.text,
          phone: phoneController.text.isNotEmpty ? phoneController.text : null,
          description: descriptionController.text.isNotEmpty
              ? descriptionController.text
              : null,
        );
        await pocketbase().collection(PocketbaseCollections.companies).create(
              body: company.toMap(),
            );
        if (context.mounted) Scaffold.of(context).closeEndDrawer();
        _clear();
      }
    } catch (e, trace) {
      AppLogger.exception(e, trace);
    } finally {
      stopLoading();
    }
  }

  void _clear() {
    nameController.clear();
    phoneController.clear();
    descriptionController.clear();
  }
}
