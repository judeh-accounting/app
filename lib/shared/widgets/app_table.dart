import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:judeh_accounting/shared/constants/app_strings.dart';
import 'package:judeh_accounting/shared/widgets/app_loader.dart';

class AppTable<T> extends StatelessWidget {
  const AppTable({
    super.key,
    required this.totalPages,
    required this.totalItems,
    required this.page,
    required this.columns,
    required this.onGenerateRow,
    required this.data,
    required this.onChangePage,
    required this.loading,
    this.onEditRow,
    this.onDeleteRow,
    this.focusNode,
  });

  final List<AppColumn> columns;

  final List<String> Function(T data) onGenerateRow;

  final List<T> data;

  final int totalPages;

  final int page;

  final Function(int page) onChangePage;

  final int totalItems;

  final bool loading;

  final Function(T data)? onDeleteRow;

  final Function(T data)? onEditRow;

  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return loading
        ? AppLoader(
            width: double.infinity,
            height: Get.height,
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ObxValue(
                  (selectedIndexes) => Focus(
                        focusNode: focusNode,
                        child: DataTable(
                          showBottomBorder: true,
                          columns: columns
                              .map((column) => DataColumn(
                                  label: Text(column.name),
                                  onSort: column.onSort))
                              .toList(),
                          rows: data
                              .map(
                                (data) => DataRow(
                                  selected: selectedIndexes.contains(data),
                                  onSelectChanged: (value) {
                                    if (value == null || !value) {
                                      selectedIndexes.remove(data);
                                    } else {
                                      selectedIndexes.add(data);
                                    }
                                  },
                                  cells: [
                                    ...onGenerateRow.call(data).map(
                                          (e) => DataCell(
                                            Text(
                                              e.length > 50
                                                  ? '${e.substring(0, 50)}...'
                                                  : e,
                                            ),
                                          ),
                                        ),
                                    if (columns.contains(AppColumn.actions()))
                                      DataCell(
                                        PopupMenuButton<_AppColumnActionTypes>(
                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                              value: _AppColumnActionTypes.edit,
                                              child: Text(
                                                AppStrings.edit,
                                                style: TextTheme.of(context)
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary),
                                              ),
                                            ),
                                            PopupMenuItem(
                                              value:
                                                  _AppColumnActionTypes.delete,
                                              child: Text(
                                                AppStrings.delete,
                                                style: TextTheme.of(context)
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        color: Colors.red),
                                              ),
                                            ),
                                          ],
                                          onSelected: (value) {
                                            switch (value) {
                                              case _AppColumnActionTypes.edit:
                                                onEditRow?.call(data);
                                                break;
                                              case _AppColumnActionTypes.delete:
                                                onDeleteRow?.call(data);
                                                break;
                                            }
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                  RxList<T>()),
              SizedBox(height: 15),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('العدد الكامل $totalItems'),
              ),
              ObxValue<RxInt>(
                  (hoveredIndex) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          totalPages,
                          (index) => Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: ElevatedButton(
                              onPressed: () => onChangePage(index + 1),
                              onHover: (value) =>
                                  hoveredIndex.value = value ? index + 1 : -1,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: hoveredIndex.value ==
                                        (index + 1)
                                    ? Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withValues(alpha: .5)
                                    : (index + 1) == page
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.white,
                              ),
                              child: Text(
                                '${index + 1}',
                                style:
                                    TextTheme.of(context).bodyMedium?.copyWith(
                                        color: (index + 1) != page
                                            ? hoveredIndex.value == (index + 1)
                                                ? Colors.white
                                                : null
                                            : Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                  RxInt(-1)),
            ],
          );
  }
}

class AppColumn {
  final String name;

  final void Function(int, bool)? onSort;

  AppColumn({required this.name, this.onSort});

  factory AppColumn.actions() => AppColumn(name: '');

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppColumn &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}

enum _AppColumnActionTypes { edit, delete }
