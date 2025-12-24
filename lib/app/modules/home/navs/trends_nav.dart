// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/app/modules/home/constants/nav_ids.dart';
import 'package:d3_wallet/app/modules/home/controllers/home_controller.dart';
import 'package:d3_wallet/app/modules/trends/bindings/trends_binding.dart';
import 'package:d3_wallet/app/modules/trends/coin_market_detail/bindings/coin_market_detail_binding.dart';
import 'package:d3_wallet/app/modules/trends/coin_market_detail/views/coin_market_detail_view.dart';
import 'package:d3_wallet/app/modules/trends/views/trends_view.dart';
import 'package:d3_wallet/app/routes/app_pages.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Navigator widget for the Trends tab with nested navigation
class TrendsNav extends StatelessWidget {
  const TrendsNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(NavIds.trends),
      onGenerateRoute: (settings) {
        Fimber.d("TrendsNav.onGenerateRoute: ${settings.name}, args: ${settings.arguments}");
        if (settings.name == Routes.COIN_MARKET_DETAIL) {
          return GetPageRoute(
            settings: settings,
            page: () => const CoinMarketDetailView(),
            binding: CoinMarketDetailBinding(arguments: settings.arguments),
          );
        } else {
          return GetPageRoute(
            settings: settings,
            page: () => PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) async {
                if (didPop) return;
                final shouldExit = await HomeController.to.handleBackPress();
                if (shouldExit) {
                  SystemNavigator.pop();
                }
              },
              child: TrendsView(),
            ),
            binding: TrendsBinding(),
          );
        }
      },
    );
  }
}
