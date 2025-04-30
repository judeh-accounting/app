import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:judeh_accounting/company/controllers/company_controller.dart';
import 'package:judeh_accounting/company/models/company.dart';
import 'package:judeh_accounting/shared/constants/app_strings.dart';
import 'package:judeh_accounting/shared/widgets/app_scaffold.dart';
import 'package:judeh_accounting/shared/widgets/app_table.dart';

class CompanyScreen extends StatelessWidget {
  const CompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CompanyController(),
      builder: (controller) {
        return AppScaffold(
          title: AppStrings.company,
          onCtrlN: () => controller.create(),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Builder(
                builder: (context) {
                  controller.context = context;
                  return ElevatedButton(onPressed:()=> controller.create(), child: Text(AppStrings.add),);
                }
              ),
            ),
          ],
          child: SliverToBoxAdapter(
            child: AppTable(
              loading: controller.loading,
              totalPages: controller.totalPages,
              totalItems: controller.totalItems,
              page: controller.page,
              onChangePage: (page) => controller.page = page,
              columns: [
                if (kDebugMode) AppColumn(name: 'id'),
                AppColumn(name: 'name'),
                AppColumn(name: 'phone'),
                AppColumn(name: 'description'),
                AppColumn.actions(),
              ],
              data: controller.companies,
              onGenerateRow: (company) => [
                if (kDebugMode) company.id,
                company.name,
                company.phone ?? '',
                company.description ?? '',
              ],
              onDeleteRow: controller.delete,
            ),
          ),
        );
      }
    );
  }
}