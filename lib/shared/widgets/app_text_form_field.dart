import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    this.keyboardType,
    required this.label,
    this.onSaved,
    this.onEditingComplete,
    this.required = false,
    this.controller,
    this.maxLines = 1,
  });

  final TextInputType? keyboardType;

  final String label;

  final void Function(String?)? onSaved;

  final bool required;

  final TextEditingController? controller;

  final int maxLines;

  final Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: SelectableText(label),
      ),
      maxLines: maxLines,
      onSaved: onSaved,
      onEditingComplete: onEditingComplete,
      keyboardType: keyboardType,
      validator: (value) {
        if (required) {
          return value != null && value.isNotEmpty ? null : 'هذا الحقل اجباري';
        }
        return null;
      },
    );
  }
}
