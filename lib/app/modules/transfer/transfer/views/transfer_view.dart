// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/base/base_view.dart';
import 'package:flutter/material.dart';

import '../controllers/transfer_controller.dart';

class TransferView extends BaseView<TransferController> {
  const TransferView({super.key});

  @override
  Widget onCreateViews(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('TransferView is working', style: TextStyle(fontSize: 20))),
    );
  }
}
