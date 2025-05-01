import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:judeh_accounting/shared/constants/app_strings.dart';
import 'package:judeh_accounting/shared/widgets/app_loader.dart';
import 'package:judeh_accounting/shared/widgets/app_text_form_field.dart';

import '../controllers/create_edit_company_controller.dart';

class CreateEditCompany extends StatefulWidget {
  const CreateEditCompany({super.key});

  @override
  State<CreateEditCompany> createState() => _CreateEditCompanyState();
}

class _CreateEditCompanyState extends State<CreateEditCompany> {
  late final controller = Get.put(CreateEditCompanyController());

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Builder(builder: (context) {
        return Column(
          children: [
            AppTextFormField(
              label: 'الاسم',
              autofocus: true,
              controller: controller.nameController,
              required: true,
              onEditingComplete: () => _onSubmit(context),
            ),
            SizedBox(height: 10),
            AppTextFormField(
              label: 'الهاتف',
              controller: controller.phoneController,
              onEditingComplete: () => _onSubmit(context),
            ),
            SizedBox(height: 10),
            AppTextFormField(
              label: 'ملاحظات',
              controller: controller.descriptionController,
              maxLines: 4,
              onEditingComplete: () => _onSubmit(context),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => _onSubmit(context),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary),
                  child: controller.loading
                      ? AppLoader()
                      : Text(
                          controller.isEdit ? AppStrings.edit : AppStrings.add,
                          style: TextTheme.of(context)
                              .bodyMedium
                              ?.copyWith(color: Colors.white),
                        ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }

  void _onSubmit(BuildContext context) {
    if (controller.loading) return;
    controller.create(context);
  }
}
