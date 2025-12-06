// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/base/base_view.dart';
import 'package:flutter/material.dart';

import '../controllers/wallet_creation_controller.dart';

class WalletCreationView extends BaseView<WalletCreationController> {
  WalletCreationView({super.key});

  @override
  Widget? onCreateViews(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WalletCreationView'), centerTitle: true),
      body: const Center(
        child: Text('WalletCreationView is working', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
