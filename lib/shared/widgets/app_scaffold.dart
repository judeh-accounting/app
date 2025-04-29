import 'package:flutter/material.dart';

import '../constants/app_strings.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold(
      {super.key, this.title = AppStrings.appName, required this.child});

  final String title;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(title),
          ),
          child,
        ],
      ),
    );
  }
}
