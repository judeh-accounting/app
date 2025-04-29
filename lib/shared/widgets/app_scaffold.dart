import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:judeh_accounting/shared/router/app_router.dart';

import '../constants/app_strings.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold(
      {super.key, this.title = AppStrings.appName, required this.child});

  final String title;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: Get.width * .2,
            child: Column(
              children: [
                _MenuItem(
                  icon: Icons.dashboard_outlined,
                  title: AppStrings.home,
                  route: AppRouter.home,
                ),
                _MenuItem(icon: Icons.factory_outlined, title: AppStrings.companies, route: AppRouter.company,),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: SelectableText(title),
                  leading: SizedBox(),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  sliver: child,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({super.key, required this.icon, required this.title, required this.route,});

  final IconData icon;

  final String title;

  final String route;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: Get.currentRoute == route,
      selectedTileColor: Theme.of(context).colorScheme.primary,
      selectedColor: Colors.white,
      leading: Icon(icon),
      title: Text(title),
      onTap: () => Get.offAndToNamed(route),
    );
  }
}
