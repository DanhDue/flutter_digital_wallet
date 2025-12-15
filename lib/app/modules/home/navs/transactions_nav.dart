// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/app/modules/home/constants/nav_ids.dart';
import 'package:d3_wallet/app/modules/home/controllers/home_controller.dart';
import 'package:d3_wallet/app/modules/transactions/bindings/transactions_binding.dart';
import 'package:d3_wallet/app/modules/transactions/views/transactions_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Navigator widget for the Transactions tab with nested navigation
class TransactionsNav extends StatelessWidget {
  const TransactionsNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(NavIds.transactions),
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
                child: TransactionsView(),
              ),
          binding: TransactionsBinding(),
        );
      },
    );
  }
}
