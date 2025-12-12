// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/app/modules/home/constants/nav_ids.dart';
import 'package:d3_wallet/app/modules/home/controllers/home_controller.dart';
import 'package:d3_wallet/app/modules/my_wallets/bindings/my_wallets_binding.dart';
import 'package:d3_wallet/app/modules/my_wallets/views/my_wallets_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Navigator widget for the Wallet tab with nested navigation
class WalletNav extends StatelessWidget {
  const WalletNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(NavIds.wallet),
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
                child: MyWalletsView(bindingCreator: () => MyWalletsBinding()),
              ),
        );
      },
    );
  }
}
