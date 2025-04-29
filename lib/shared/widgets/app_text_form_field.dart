import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    this.keyboardType,
    required this.label,
    required this.onSaved,
    this.required = false,
  });

  final TextInputType? keyboardType;

  final String label;

  final void Function(String?) onSaved;

  final bool required;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: SelectableText(label),
      ),
      onSaved: onSaved,
      keyboardType: keyboardType,
      validator: (value) {
        if (required) {
          return 'هذا الحقل اجباري';
        }
        return null;
      },
    );
  }
}
