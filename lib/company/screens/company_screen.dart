import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:judeh_accounting/company/controllers/company_controller.dart';
import 'package:judeh_accounting/shared/constants/app_strings.dart';
import 'package:judeh_accounting/shared/extensions/datetime_extension.dart';
import 'package:judeh_accounting/shared/logger/app_logger.dart';
import 'package:judeh_accounting/shared/widgets/app_scaffold.dart';
import 'package:judeh_accounting/shared/widgets/table/actions/delete_bulk_action.dart';
import 'package:judeh_accounting/shared/widgets/table/app_table.dart';

import '../../shared/widgets/table/dtos/column.dart';
import '../../shared/widgets/table/dtos/toggle_table.dart';
import '../models/company.dart';

class CompanyScreen extends StatelessWidget {
  const CompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: CompanyController(),
        builder: (controller) {
          return AppScaffold(
            title: AppStrings.companies,
            onCtrlN: () => controller.create(),
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Builder(builder: (context) {
                  controller.context = context;
                  return ElevatedButton(
                    onPressed: () => controller.create(),
                    child: Text(AppStrings.add),
                  );
                }),
              ),
            ],
            child: SliverToBoxAdapter(
              child: AppTable(
                loading: controller.loading,
                totalPages: controller.totalPages,
                totalItems: controller.totalItems,
                page: controller.page,
                onChangePage: (page) => controller.page = page,
                onGenerateRow: (company) => [
                  if (kDebugMode) company.id,
                  company.name,
                  if (controller.columns.contains('phone')) company.phone ?? '',
                  if (controller.columns.contains('description'))
                    company.description ?? '',
                  if (controller.columns.contains('created'))
                    company.createdAt?.since ?? '',
                  if (controller.columns.contains('updated'))
                    company.updatedAt?.since ?? '',
                ],
                onDeleteRow: controller.delete,
                onEditRow: controller.edit,
                toggleTable: AppToggleTable(
                  columns: Company.togglableColumns,
                  onToggle: (columns) => controller.columns = columns,
                ),
                bulkAction: (models) => DeleteBulkAction(
                  onPressed: () {
                    AppLogger.info('selected models for bulk: $models');
                  },
                ),
                columns: [
                  ...controller.columns.map((e) => AppColumn(name: e)),
                  AppColumn.actions(),
                ],
                data: controller.companies,
              ),
            ),
          );
        });
  }
}
