// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/base/base_view.dart';
import 'package:flutter/material.dart';

import '../controllers/profile_detail_controller.dart';

class ProfileDetailView extends BaseView<ProfileDetailController> {
  ProfileDetailView({super.key});
  @override
  Widget onCreateViews(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ProfileDetailView'), centerTitle: true),
      body: const Center(
        child: Text('ProfileDetailView is working', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
