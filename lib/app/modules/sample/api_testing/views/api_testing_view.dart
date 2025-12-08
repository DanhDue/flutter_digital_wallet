// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/base/base_networking_view.dart';
import 'package:flutter/material.dart';

import '../controllers/api_testing_controller.dart';

class ApiTestingView extends BaseNetworkingView<ApiTestingController> {
  ApiTestingView({super.key});

  @override
  Widget? buildLoading(BuildContext context) =>
      const Center(child: CircularProgressIndicator(color: Colors.amber));

  @override
  Widget buildBody(BuildContext context, state) {
    return Scaffold(
      body: Center(child: Text(state.toString(), style: const TextStyle(fontSize: 20))),
    );
  }
}
