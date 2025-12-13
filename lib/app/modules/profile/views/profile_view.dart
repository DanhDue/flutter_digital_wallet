// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/app/modules/home/constants/nav_ids.dart';
import 'package:d3_wallet/app/routes/app_pages.dart';
import 'package:d3_wallet/base/base_view.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends BaseView<ProfileController> {
  ProfileView({super.key});

  @override
  Widget onCreateViews(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('ProfileView is working', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _navigateToProfileDetail,
              style: ElevatedButton.styleFrom(
                backgroundColor: context.appThemes.trueBlue,
                foregroundColor: context.appThemes.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text('Go to Profile Detail'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _navigateToLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: context.appThemes.trueBlue,
                foregroundColor: context.appThemes.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text('Go to Login'),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToProfileDetail() {
    // Use GetX nested navigation with named route and navigator ID
    Get.toNamed(Routes.PROFILE_DETAIL, id: NavIds.profile);
  }

  void _navigateToLogin() {
    // Navigate to Login using global/root navigation (hides bottom nav bar)
    // Home stays in stack, so back button returns to Home
    Get.toNamed(Routes.LOGIN);
  }
}
