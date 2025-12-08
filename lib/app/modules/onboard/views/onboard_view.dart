// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/base/base_networking_view.dart';
import 'package:flutter/material.dart';

import '../controllers/onboard_controller.dart';

class OnboardView extends BaseNetworkingView<OnboardController> {
  OnboardView({super.key});

  @override
  Widget buildBody(BuildContext context, state) {
    return const Center(child: Text('OnboardView is working', style: TextStyle(fontSize: 20)));
  }
}
