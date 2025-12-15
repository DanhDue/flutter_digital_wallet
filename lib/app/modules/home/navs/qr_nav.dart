// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/app/modules/home/constants/nav_ids.dart';
import 'package:d3_wallet/app/modules/home/controllers/home_controller.dart';
import 'package:d3_wallet/app/modules/qr_scanner/views/qr_scanner_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Navigator widget for the QR tab with nested navigation
class QRNav extends StatelessWidget {
  const QRNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(NavIds.qr),
      onGenerateRoute: (settings) {
        // Root screen - wrap with PopScope for back handling
        return GetPageRoute(
          settings: settings,
          page:
              () => PopScope(
                canPop: false,
                onPopInvokedWithResult: (didPop, result) async {
                  if (didPop) return;
                  final shouldExit = await HomeController.to.handleBackPress();
                  if (shouldExit) {
                    SystemNavigator.pop();
                  }
                },
                child: QRScannerView(),
              ),
        );
      },
    );
  }
}
