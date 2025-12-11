import 'package:d3_wallet/base/base_view.dart';
import 'package:flutter/material.dart';

import '../controllers/transactions_controller.dart';

class TransactionsView extends BaseView<TransactionsController> {
  TransactionsView({super.key});
  @override
  Widget onCreateViews(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TransactionsView'), centerTitle: true),
      body: const Center(
        child: Text('TransactionsView is working', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
