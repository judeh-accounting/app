import 'package:flutter/material.dart';
import 'package:judeh_accounting/shared/widgets/table/actions/bulk_action.dart';

class DeleteBulkAction extends BulkAction {
  const DeleteBulkAction({
    super.key,
    required super.onPressed,
  }) : super(
          text: 'حذف المحدد',
          backgroundColor: Colors.red,
        );
}
