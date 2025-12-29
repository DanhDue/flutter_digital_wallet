// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/data/bean/response/transaction_response_object/transaction_response_object.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class TransactionDetailController extends GetxController {
  late final TransactionResponseObject transaction;

  @override
  void onInit() {
    super.onInit();
    // Get transaction from arguments
    transaction = Get.arguments as TransactionResponseObject;
  }

  Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    Get.snackbar(
      'Copied',
      'Address copied to clipboard',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  Future<void> shareReceipt() async {
    final signature = transaction.overview?.signature?.firstOrNull ?? '';
    final slot = transaction.overview?.slot?.toString() ?? '';
    final text =
        '''
Transaction Details
Signature: $signature
Slot: $slot
Status: Confirmed
    ''';

    await SharePlus.instance.share(ShareParams(text: text));
  }

  Future<void> openExplorer() async {
    final signature = transaction.overview?.signature?.firstOrNull ?? '';
    if (signature.isEmpty) return;

    final url = Uri.parse('https://explorer.solana.com/tx/$signature?cluster=devnet');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }
}
