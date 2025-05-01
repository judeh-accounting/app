import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.onPressed, required this.text})
      : _secondary = false;

  final Function() onPressed;

  final String text;

  final bool _secondary;

  const AppButton.secondary(
      {super.key, required this.onPressed, required this.text})
      : _secondary = true;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: _secondary
          ? ElevatedButton.styleFrom(
              backgroundColor: ColorScheme.of(context).secondary,
              foregroundColor: Colors.white,
            )
          : null,
      child: Text(
        text,
      ),
    );
  }
}
