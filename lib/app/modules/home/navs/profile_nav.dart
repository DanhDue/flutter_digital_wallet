// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/app/modules/home/constants/nav_ids.dart';
import 'package:d3_wallet/app/modules/home/controllers/home_controller.dart';
import 'package:d3_wallet/app/modules/profile/profile_detail/bindings/profile_detail_binding.dart';
import 'package:d3_wallet/app/modules/profile/profile_detail/views/profile_detail_view.dart';
import 'package:d3_wallet/app/modules/profile/views/profile_view.dart';
import 'package:d3_wallet/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Navigator widget for the Profile tab with nested navigation
class ProfileNav extends StatelessWidget {
  const ProfileNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(NavIds.profile),
      onGenerateRoute: (settings) {
        if (settings.name == Routes.PROFILE_DETAIL) {
          return GetPageRoute(
            settings: settings,
            page: () => ProfileDetailView(),
            binding: ProfileDetailBinding(),
          );
        } else {
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
                  child: ProfileView(),
                ),
          );
        }
      },
    );
  }
}
