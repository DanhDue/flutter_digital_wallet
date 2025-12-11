// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/base/base_view.dart';
import 'package:flutter/material.dart';

import '../controllers/trends_controller.dart';

class TrendsView extends BaseView<TrendsController> {
  TrendsView({super.key});
  @override
  Widget onCreateViews(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TrendsView'), centerTitle: true),
      body: const Center(child: Text('TrendsView is working', style: TextStyle(fontSize: 20))),
    );
  }
}
