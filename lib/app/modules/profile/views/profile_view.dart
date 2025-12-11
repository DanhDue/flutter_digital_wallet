// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/app/modules/profile_detail/bindings/profile_detail_binding.dart';
import 'package:d3_wallet/app/modules/profile_detail/views/profile_detail_view.dart';
import 'package:d3_wallet/base/base_view.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:flutter/material.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends BaseView<ProfileController> {
  ProfileView({super.key});

  @override
  Widget onCreateViews(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ProfileView'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('ProfileView is working', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _navigateToProfileDetail(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: context.appThemes.mainGreen,
                foregroundColor: context.appThemes.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text('Go to Profile Detail'),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToProfileDetail(BuildContext context) {
    // Use Navigator.of(context) for nested navigation within the tab
    ProfileDetailBinding().dependencies();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileDetailView()));
  }
}
