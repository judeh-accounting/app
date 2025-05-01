import 'package:flutter/material.dart' hide DrawerController;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:judeh_accounting/shared/router/app_router.dart';

import '../constants/app_strings.dart';
import '../drawer/drawer_controller.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({
    super.key,
    this.title = AppStrings.appName,
    required this.child,
    this.actions = const [],
    this.onCtrlN,
    this.onCtrlE,
  });

  final String title;

  final Widget child;

  final List<Widget> actions;

  final Function()? onCtrlN;

  final Function()? onCtrlE;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: {
        if (widget.onCtrlN != null)
          const SingleActivator(LogicalKeyboardKey.keyN, control: true):
              widget.onCtrlN!,
        if (widget.onCtrlE != null)
          const SingleActivator(LogicalKeyboardKey.keyE, control: true):
              widget.onCtrlE!,
      },
      child: Focus(
        autofocus: true,
        child: Scaffold(
          endDrawerEnableOpenDragGesture: false,
          endDrawer: GetBuilder<DrawerController>(builder: (controller) {
            return Container(
              width: Get.width * .5,
              height: Get.height,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        onPressed: Get.back, icon: Icon(Icons.close)),
                  ),
                  SizedBox(height: 25),
                  if (controller.widget != null) controller.widget!,
                ],
              ),
            );
          }),
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
                    _MenuItem(
                      icon: Icons.factory_outlined,
                      title: AppStrings.companies,
                      route: AppRouter.company,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      title: SelectableText(widget.title),
                      leading: SizedBox(),
                      actions: [
                        SizedBox(),
                        ...widget.actions,
                      ],
                    ),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      sliver: widget.child,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.title,
    required this.route,
  });

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
