// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'dart:async';

import 'package:d3_wallet/app/modules/qr_scanner/scanner/controllers/scanner_controller.dart';
import 'package:d3_wallet/app/routes/app_pages.dart';
import 'package:d3_wallet/app/routes/navigation_arguments.dart';
import 'package:d3_wallet/base/widgets/custom_filled_button.dart';
import 'package:d3_wallet/base/widgets/input_text.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:d3_wallet/utils/extensions/string_ext.dart';
import 'package:d3_wallet/utils/qr_utils.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/export.dart';

import '../controllers/wallet_import_controller.dart';

class WalletImportView extends StatefulWidget {
  const WalletImportView({super.key});

  @override
  State<WalletImportView> createState() => _WalletImportViewState();
}

class _WalletImportViewState extends State<WalletImportView> {
  final controller = Get.put(WalletImportController(), permanent: false);

  late StreamSubscription<bool> keyboardSubscription;

  @override
  void initState() {
    super.initState();

    var keyboardVisibilityController = KeyboardVisibilityController();
    // Query
    Fimber.d('Keyboard visibility direct query: ${keyboardVisibilityController.isVisible}');

    // Subscribe
    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
      Fimber.d('Keyboard visibility update. Is visible: $visible');
      controller.keyboardVisibilityChanged(visible);
    });
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // call this method here to hide soft keyboard
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Scaffold(
            body: SafeArea(
              top: true,
              bottom: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        onTap: Get.back,
                        child: Assets.images.icArrowLeft.svg(
                          width: 36,
                          height: 36,
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(context.appThemes.ink60, BlendMode.srcIn),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Assets.images.icZenoTxt.image(width: 105, fit: BoxFit.cover),
                        ),
                      ),
                      Visibility(
                        visible: false,
                        maintainSize: true,
                        maintainState: true,
                        maintainAnimation: true,
                        child: Assets.images.icArrowLeft.svg(
                          width: 36,
                          height: 36,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ).marginSymmetric(horizontal: 16),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(height: 26),
                            Text(
                              LocaleKeys.importWallet.tr,
                              style: context.appThemes.bold24.copyWith(
                                color: context.appThemes.ink100,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8),
                            Text(
                              LocaleKeys.importWalletDescription.tr,
                              style: context.appThemes.regular14.copyWith(
                                color: context.appThemes.ink60,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 24),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              decoration: BoxDecoration(
                                border: Border.all(color: context.appThemes.yellow100),
                                color: context.appThemes.yellow5,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    LocaleKeys.example.tr,
                                    style: context.appThemes.medium14.copyWith(
                                      color: context.appThemes.ink100,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    LocaleKeys.exampleSecretRecoveryPhrase.tr,
                                    style: context.appThemes.regular12.copyWith(
                                      color: context.appThemes.ink60,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    LocaleKeys.exampleSecretRecoveryPhraseValue.tr,
                                    style: context.appThemes.regular12.copyWith(
                                      color: context.appThemes.ink60,
                                    ),
                                    textAlign: TextAlign.left,
                                  ).paddingOnly(left: 14),
                                  SizedBox(height: 6),
                                  Text(
                                    LocaleKeys.examplePrivateKey.tr,
                                    style: context.appThemes.regular12.copyWith(
                                      color: context.appThemes.ink60,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    LocaleKeys.examplePrivateKeyValue.tr,
                                    style: context.appThemes.regular12.copyWith(
                                      color: context.appThemes.ink60,
                                    ),
                                    textAlign: TextAlign.left,
                                  ).paddingOnly(left: 14),
                                  SizedBox(height: 6),
                                  Text(
                                    LocaleKeys.exampleBase58PrivateKey.tr,
                                    style: context.appThemes.regular12.copyWith(
                                      color: context.appThemes.ink60,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    LocaleKeys.exampleBase58PrivateKeyValue.tr,
                                    style: context.appThemes.regular12.copyWith(
                                      color: context.appThemes.ink60,
                                    ),
                                    textAlign: TextAlign.left,
                                  ).paddingOnly(left: 14),
                                ],
                              ),
                            ),
                            SizedBox(height: 24),
                            Obx(
                              () => InputText(
                                controller: controller.textEditingController,
                                focusNode: controller.focusNode,
                                status:
                                    controller.isFocus.value
                                        ? InputTextStatus.focus
                                        : (controller.isMnemonicError.value != true
                                            ? InputTextStatus.normal
                                            : InputTextStatus.error),
                                onChanged: (value) => controller.onTextChanged(value),
                                labelText: LocaleKeys.srpOrPk.tr,
                                hintText: LocaleKeys.enterTextPlease.tr,
                                minLines: 1,
                                maxLines: 3,
                                suffixIcon:
                                    controller.showClearIcon.value == true
                                        ? InkWell(
                                          onTap: () => controller.clearText(),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 24,
                                              top: 12,
                                              bottom: 12,
                                              right: 4,
                                            ),
                                            child: Assets.images.icClear.svg(),
                                          ),
                                        )
                                        : null,
                                showPrefixIconsDivider: controller.showClearIcon.value,
                                secondSuffixIcon: Assets.images.icScan.svg(
                                  width: 24,
                                  height: 24,
                                  fit: BoxFit.cover,
                                ),
                                onSecondSuffixIconTap: () async {
                                  Get.delete<ScannerController>();
                                  final scannedMnemonic = await Get.toNamed(
                                    Routes.SCANNER,
                                    arguments: {NavigationArguments.qr.showFullScreen: true},
                                  );
                                  final sMnemonics = scannedMnemonic as String?;
                                  if (sMnemonics != null && sMnemonics.isNotBlank() == true) {
                                    controller.scannedText(
                                      QrUtils.instance.retrieveMnemonicFromQr(sMnemonics),
                                    );
                                  }
                                },
                              ),
                            ),
                            Obx(
                              () => Visibility(
                                visible: controller.isMnemonicError.value,
                                child: SizedBox(height: 4),
                              ),
                            ),
                            Obx(
                              () => Visibility(
                                visible: controller.isMnemonicError.value,
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    LocaleKeys.srpIsWrong.tr,
                                    style: context.appThemes.regular12.copyWith(
                                      color: context.appThemes.red100,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => CustomFilledButton(
                      horizontalPadding: 16,
                      onPressed: () {
                        Fimber.d("recoveryWallet");
                        if (controller.isValid.value) {
                          controller.restoreWallet();
                        }
                      },
                      backgroundColor:
                          controller.isValid.value
                              ? context.appThemes.trueBlue100
                              : context.appThemes.blue15,
                      text: LocaleKeys.recoveryWallet.tr,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(() {
            if (controller.isLoading.value == true) {
              WidgetsBinding.instance.addPostFrameCallback((duration) {
                SmartDialog.showLoading(msg: "");
              });
            } else {
              WidgetsBinding.instance.addPostFrameCallback((duration) {
                SmartDialog.dismiss();
              });
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
