import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:judeh_accounting/shared/constants/app_strings.dart';
import 'package:judeh_accounting/shared/widgets/app_loader.dart';
import 'package:judeh_accounting/shared/widgets/app_text_form_field.dart';

import '../controllers/create_company_controller.dart';

class CreateCompany extends StatefulWidget {
  const CreateCompany({super.key});

  @override
  State<CreateCompany> createState() => _CreateCompanyState();
}

class _CreateCompanyState extends State<CreateCompany> {

  final controller = Get.put(CreateCompanyController());

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Builder(
        builder: (context) {
          return Column(
            children: [
              AppTextFormField(label: 'الاسم', controller: controller.nameController, required: true, onEditingComplete: () => _onSubmit(context),),
              SizedBox(height: 10),
              AppTextFormField(label: 'الهاتف', controller: controller.phoneController, onEditingComplete: () => _onSubmit(context),),
              SizedBox(height: 10),
              AppTextFormField(label: 'ملاحظات', controller: controller.descriptionController, maxLines: 4, onEditingComplete: () => _onSubmit(context),),
              SizedBox(height: 10),
              Row(
                children: [
                  ElevatedButton(onPressed: () => _onSubmit(context), child: controller.loading ? AppLoader() : Text(AppStrings.add, style: TextTheme.of(context).bodyMedium?.copyWith(color: Colors.white),), style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),),
                ],
              ),
            ],
          );
        }
      ),
    );
  }

  void _onSubmit(BuildContext context) {
    if(controller.loading) return;
    controller.create(context);
  }
}
