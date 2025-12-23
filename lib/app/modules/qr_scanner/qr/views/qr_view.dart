// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/app/routes/app_pages.dart';
import 'package:d3_wallet/app/routes/navigation_arguments.dart';
import 'package:d3_wallet/base/widgets/custom_unfilled_button.dart';
import 'package:d3_wallet/base/widgets/pretty_animated_qr_view.dart';
import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/colors.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:d3_wallet/utils/constants.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../controllers/qr_controller.dart';

class QRView extends StatefulWidget {
  const QRView({super.key, this.selectedWallet});

  final WalletResponseObject? selectedWallet;

  @override
  State<QRView> createState() => _QRViewState();
}

class _QRViewState extends State<QRView> {
  final controller = Get.put(QRController(), permanent: false);

  @protected
  late PrettyQrDecoration decoration;

  @override
  void initState() {
    super.initState();
    decoration = PrettyQrDecoration(
      shape: const PrettyQrSmoothSymbol(color: AppColors.ink60, roundFactor: 1),
      image: PrettyQrDecorationImage(
        image: Assets.images.icZeno.provider(),
        opacity: 0.96,
        position: .embedded,
      ),
      background: Colors.transparent,
      quietZone: .zero,
    );
    controller.updateSelectedWallet(widget.selectedWallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .center,
        mainAxisSize: .max,
        children: [
          Obx(
            () => controller.showFullScreen.value == true
                ? const SizedBox(height: 49)
                : const SizedBox(height: 75),
          ), // TOP PADDING => To show view bellow the TabBar.
          Obx(
            () => controller.showFullScreen.value == true
                ? const SizedBox.shrink()
                : const SizedBox(height: 30),
          ),
          Obx(
            () => controller.showFullScreen.value == true
                ? Row(
                    mainAxisAlignment: .end,
                    crossAxisAlignment: .center,
                    mainAxisSize: .max,
                    children: [
                      InkWell(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: const .only(top: 10, right: 22, bottom: 10, left: 22),
                          child: Icon(size: 24, Icons.close, color: context.appThemes.trueBlue),
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: .start,
                crossAxisAlignment: .center,
                mainAxisSize: .min,
                children: [
                  const SizedBox(height: 12),
                  Center(
                    child: Text(
                      LocaleKeys.receive.tr,
                      style: context.appThemes.bold20.copyWith(
                        color: context.appThemes.greenVogue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Container(
                    padding: const .symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: context.appThemes.transparent,
                      border: Border.all(color: context.appThemes.greenVogue60),
                      borderRadius: .circular(100),
                    ),
                    child: Row(
                      mainAxisAlignment: .start,
                      crossAxisAlignment: .center,
                      mainAxisSize: .min,
                      children: [
                        Assets.images.icSolana.svg(width: 20, height: 20, fit: .cover),
                        const SizedBox(width: 4),
                        Text(
                          "Solana Devnet",
                          style: context.appThemes.regular14.copyWith(
                            color: context.appThemes.greenVogue60,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Assets.images.icChevronDown.svg(width: 20, height: 20, fit: .cover),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Obx(
                    () => Container(
                      width: 320,
                      height: 320,
                      decoration: BoxDecoration(borderRadius: .circular(20)),
                      child: PrettyAnimatedQrView(
                        qrImage: QrImage(
                          QrCode.fromData(
                            data: controller.qrData.value,
                            errorCorrectLevel: QrErrorCorrectLevel.H,
                          ),
                        ),
                        decoration: decoration,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const .symmetric(horizontal: 69),
                    child: Text(
                      controller.selectedWallet.value.name ?? "",
                      style: context.appThemes.medium16.copyWith(color: context.appThemes.ink100),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const .symmetric(horizontal: 69),
                    child: Obx(
                      () => Text(
                        controller.selectedWallet.value.address ?? "",
                        style: context.appThemes.regular12.copyWith(
                          color: context.appThemes.ink100,
                        ),
                        textAlign: .center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () async {
                      Fimber.d("copy address to the clipboard");
                      await Clipboard.setData(
                        ClipboardData(text: controller.selectedWallet.value.address ?? ""),
                      );
                      Fimber.d("copied address: ${controller.selectedWallet.value.address ?? ""}");
                      if (GetPlatform.isIOS) {
                        SmartDialog.showToast(
                          LocaleKeys.walletAddressIsCoppied.tr,
                          displayTime: ToastDuration.LENGTH_SHORT,
                        );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: .center,
                      crossAxisAlignment: .center,
                      mainAxisSize: .max,
                      children: [
                        Assets.images.icCopyLine.svg(
                          width: 24,
                          height: 24,
                          fit: .cover,
                          colorFilter: .mode(context.appThemes.greenVogue60, .srcIn),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          LocaleKeys.copyAddress.tr,
                          style: context.appThemes.medium14.copyWith(
                            color: context.appThemes.greenVogue60,
                          ),
                          textAlign: .center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const .symmetric(horizontal: 24, vertical: 12),
            child: CustomUnfilledButton(
              onPressed: () {
                Fimber.d("Request Payment");
                Get.toNamed(
                  Routes.REQUEST_PAYMENT,
                  arguments: {NavigationArguments.selectedWallet: controller.selectedWallet.value},
                );
              },
              borderColor: context.appThemes.greenVogue60,
              textColor: context.appThemes.greenVogue60,
              text: LocaleKeys.requestPayment.tr,
            ),
          ),
          Obx(
            () => controller.showFullScreen.value != true
                ? const SizedBox.shrink()
                : const SizedBox(height: 12),
          ),
        ],
      ),
    );
  }
}
