import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:judeh_accounting/company/models/company.dart';
import 'package:judeh_accounting/pocketbase/constants/pocketbase_collections.dart';
import 'package:judeh_accounting/pocketbase/controllers/pocketbase_controller.dart';
import 'package:judeh_accounting/shared/loader/loader_mixin.dart';
import 'package:judeh_accounting/shared/logger/app_logger.dart';

class CreateCompanyController extends GetxController with HasLoaderMixin{
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final descriptionController = TextEditingController();

  void create(BuildContext context) async{
    if(!Form.of(context).validate()) return;

    startLoading();

    final company = Company(name: nameController.text, phone: phoneController.text.isNotEmpty ? phoneController.text: null, description: descriptionController.text.isNotEmpty ? descriptionController.text : null,);

    try{
      await pocketbase().collection(PocketbaseCollections.companies).create(
        body: company.toMap(),
      );
      if(context.mounted) Scaffold.of(context).closeEndDrawer();
      _clear();
    }catch (e, trace){
      AppLogger.exception(e, trace);
    }finally{
    stopLoading();
    }
  }

  void _clear(){
    nameController.clear();
    phoneController.clear();
    descriptionController.clear();
  }
}