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
      child: SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        sliver: SliverGrid(
          delegate: SliverChildListDelegate([
            GestureDetector(
              onTap: () => Get.toNamed(AppRouter.settings),
              child: Card(
                elevation: 10,
                child: Center(child: Text(AppStrings.settings)),
              ),
            ),
            GestureDetector(
              onTap: () => Get.toNamed(AppRouter.settings),
              child: Card(
                elevation: 10,
                child: Center(child: Text(AppStrings.settings)),
              ),
            ),
            GestureDetector(
              onTap: () => Get.toNamed(AppRouter.settings),
              child: Card(
                elevation: 10,
                child: Center(child: Text(AppStrings.settings)),
              ),
            ),
            GestureDetector(
              onTap: () => Get.toNamed(AppRouter.settings),
              child: Card(
                elevation: 10,
                child: Center(child: Text(AppStrings.settings)),
              ),
            ),
          ]),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 100,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        ),
      ),
    );
  }
}
