// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/app/modules/qr_scanner/qr/views/qr_view.dart';
import 'package:d3_wallet/app/modules/qr_scanner/scanner/views/scanner_view.dart';
import 'package:d3_wallet/app/modules/qr_scanner/scanner/views/widgets/qr_tab_item.dart';
import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../controllers/qr_scanner_controller.dart';

class QRScannerView extends StatefulWidget {
  const QRScannerView({super.key, this.selectedWallet});

  final WalletResponseObject? selectedWallet;

  @override
  State<QRScannerView> createState() => _QRScannerViewState();
}

class _QRScannerViewState extends State<QRScannerView> with TickerProviderStateMixin {
  final controller = Get.put(QRScannerController(), permanent: false);

  late final TabController _tabController;
  var _selectedTabbar = 0;

  @override
  void initState() {
    super.initState();
    controller.setupInputs(widget.selectedWallet);
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Builder(
                    builder: (_) {
                      if (_selectedTabbar == 0) {
                        return Obx(
                          () => ScannerView(selectedWallet: controller.selectedWallet.value),
                        );
                      } else if (_selectedTabbar == 1) {
                        return Obx(() => QRView(selectedWallet: controller.selectedWallet.value));
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 62),
                    child: PreferredSize(
                      preferredSize: const Size.fromHeight(40),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        child: Container(
                          height: 40,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            color: context.appThemes.trueBlue.withValues(
                              alpha: _selectedTabbar == 0 ? 0.35 : 0.2,
                            ),
                          ),
                          child: TabBar(
                            controller: _tabController,
                            onTap: (index) {
                              setState(() {
                                _selectedTabbar = index;
                              });
                            },
                            indicatorSize: TabBarIndicatorSize.tab,
                            dividerColor: Colors.transparent,
                            indicator: BoxDecoration(
                              color: context.appThemes.trueBlue,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            labelColor: context.appThemes.white,
                            unselectedLabelColor:
                                _selectedTabbar == 0
                                    ? context.appThemes.white.withValues(alpha: 0.54)
                                    : context.appThemes.black.withValues(alpha: 0.54),
                            tabs: [
                              TabItem(title: LocaleKeys.scanQrCode.tr),
                              TabItem(title: LocaleKeys.yourQrCode.tr),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(width: double.infinity, height: 1, color: context.appThemes.ink5),
          ],
        ),
      ),
    );
  }
}
