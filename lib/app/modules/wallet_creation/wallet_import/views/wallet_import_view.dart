// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/base/base_networking_view.dart';
import 'package:flutter/material.dart';

import '../controllers/wallet_import_controller.dart';

class WalletImportView extends BaseNetworkingView<WalletImportController> {
  WalletImportView({super.key});

  @override
  Widget buildBody(BuildContext context, state) {
    return const Center(
      child: Text('WalletImportView is working', style: TextStyle(fontSize: 20)),
    );
  }
}
