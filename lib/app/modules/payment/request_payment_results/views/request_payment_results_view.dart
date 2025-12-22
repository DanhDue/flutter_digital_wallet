// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/base/base_view.dart';
import 'package:flutter/material.dart';

import '../controllers/request_payment_results_controller.dart';

class RequestPaymentResultsView extends BaseView<RequestPaymentResultsController> {
  const RequestPaymentResultsView({super.key});

  @override
  Widget onCreateViews(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('RequestPaymentResultsView is working', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
