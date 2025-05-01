import 'package:flutter/material.dart';

abstract class BulkAction<T> extends StatelessWidget {
  const BulkAction({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
  });

  final String text;

  final Function() onPressed;

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        foregroundColor: Colors.white,
        backgroundColor: backgroundColor,
      ),
      child: Text(text),
    );
  }
}
