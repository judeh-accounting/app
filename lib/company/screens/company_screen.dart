import 'package:flutter/material.dart';
import 'package:judeh_accounting/shared/constants/app_strings.dart';
import 'package:judeh_accounting/shared/widgets/app_scaffold.dart';

class CompanyScreen extends StatelessWidget {
  const CompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AppStrings.company,
      child: SliverToBoxAdapter(
        child: DataTable(columns: [DataColumn(label: SelectableText('test column'))],
          rows: [
            for(int i = 0; i < 10; i++)
            DataRow(cells: [ DataCell(SelectableText('test')),])
          ],
        ),
      ),
    );
  }
}

class CustomDataTableSource extends DataTableSource{
  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [DataCell(SelectableText('test'))]);
  }

  @override
  bool get isRowCountApproximate => true;

  @override
  int get rowCount => 3;

  @override
  int get selectedRowCount => 1;
}
