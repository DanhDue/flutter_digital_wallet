// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:flutter/material.dart';

class MnemonicCreationView extends StatefulWidget {
  const MnemonicCreationView({super.key, this.goToMnemonicConfirmation, this.createdWallet});

  final WalletResponseObject? createdWallet;
  final VoidCallback? goToMnemonicConfirmation;

  @override
  State<MnemonicCreationView> createState() => _MnemonicCreationViewState();
}

class _MnemonicCreationViewState extends State<MnemonicCreationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: Center(
          child: Text('MnemonicCreationView is working', style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}
