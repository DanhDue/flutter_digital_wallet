// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/base/base_view.dart';
import 'package:flutter/material.dart';

import '../controllers/password_creation_controller.dart';

class PasswordCreationView extends BaseView<PasswordCreationController> {
  PasswordCreationView({super.key});

  @override
  Widget? onCreateViews(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PasswordCreationView'), centerTitle: true),
      body: const Center(
        child: Text('PasswordCreationView is working', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
