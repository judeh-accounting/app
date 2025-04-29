import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:judeh_accounting/pocketbase/controllers/pocketbase_controller.dart';
import 'package:judeh_accounting/settings/controllers/settings_controller.dart';
import 'package:judeh_accounting/shared/constants/app_strings.dart';
import 'package:judeh_accounting/shared/widgets/app_scaffold.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: SettingsController(),
        builder: (controller) {
          return AppScaffold(
            title: AppStrings.settings,
            child: SliverToBoxAdapter(
              child: Column(
                children: [
                  controller.serverStarted
                      ? Column(
                          children: [
                            QrImageView(
                              data: controller.ipAddress,
                              size: 200,
                              foregroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            SizedBox(height: 5),
                            Text(controller.ipAddress),
                            SizedBox(height: 5),
                            ElevatedButton(
                              onPressed: controller.stopServer,
                              child: SelectableText(
                                'ايقاف السيرفر',
                                style: TextTheme.of(context)
                                    .bodyMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                            )
                          ],
                        )
                      : ElevatedButton(
                          onPressed: controller.startServer,
                          child: SelectableText(
                            'تشغيل السيرفر',
                            style: TextTheme.of(context)
                                .bodyMedium
                                ?.copyWith(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                        ),
                  SizedBox(height: 10),
                  !controller.connectedToServer
                      ? ElevatedButton(
                          onPressed: controller.connectToServer,
                          child: SelectableText('اتصال بجهاز آخر'),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.all(10),
                          child: SelectableText(
                            'تم الاتصال بجهاز',
                            style: TextTheme.of(context)
                                .bodyMedium
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                ],
              ),
            ),
          );
        });
  }
}
