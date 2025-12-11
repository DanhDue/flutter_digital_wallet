import 'package:d3_wallet/base/base_view.dart';
import 'package:flutter/material.dart';

import '../controllers/qr_scanning_controller.dart';

class QRScanningView extends BaseView<QRScanningController> {
  QRScanningView({super.key});
  @override
  Widget onCreateViews(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QRScanningView'), centerTitle: true),
      body: const Center(child: Text('QRScanningView is working', style: TextStyle(fontSize: 20))),
    );
  }
}
