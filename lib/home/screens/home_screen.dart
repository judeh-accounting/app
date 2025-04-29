import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:judeh_accounting/shared/constants/app_strings.dart';
import 'package:judeh_accounting/shared/widgets/app_scaffold.dart';

import '../../shared/router/app_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AppStrings.home,
      child: SliverToBoxAdapter(),
    );
  }
}
