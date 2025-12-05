// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/base/base_view.dart';
import 'package:flutter/material.dart';

import '../controllers/intro_controller.dart';

class IntroView extends BaseView<IntroController> {
  IntroView({super.key});

  @override
  Widget? onCreateViews(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('IntroView'), centerTitle: true),
      body: const Center(child: Text('IntroView is working', style: TextStyle(fontSize: 20))),
    );
  }
}
