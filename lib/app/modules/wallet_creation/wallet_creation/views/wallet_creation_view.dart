// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/base/base_networking_view.dart';
import 'package:flutter/material.dart';

import '../controllers/wallet_creation_controller.dart';

class WalletCreationView extends BaseNetworkingView<WalletCreationController> {
  WalletCreationView({super.key});

  @override
  Widget buildBody(BuildContext context, state) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            Center(child: Text('WalletCreationView is working', style: TextStyle(fontSize: 20))),
          ],
        ),
      ),
    );
  }
}
