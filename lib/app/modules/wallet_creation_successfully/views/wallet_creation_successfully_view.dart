// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/wallet_creation_successfully_controller.dart';

class WalletCreationSuccessfullyView extends GetView<WalletCreationSuccessfullyController> {
  const WalletCreationSuccessfullyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WalletCreationSuccessfullyView'), centerTitle: true),
      body: const Center(
        child: Text('WalletCreationSuccessfullyView is working', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
