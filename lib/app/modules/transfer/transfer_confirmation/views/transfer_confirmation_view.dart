// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/base/base_view.dart';
import 'package:flutter/material.dart';

import '../controllers/transfer_confirmation_controller.dart';

class TransferConfirmationView extends BaseView<TransferConfirmationController> {
  TransferConfirmationView({super.key});

  @override
  Widget onCreateViews(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('TransferConfirmationView is working', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
