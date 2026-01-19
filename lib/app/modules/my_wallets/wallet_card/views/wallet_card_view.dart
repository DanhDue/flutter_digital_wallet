// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:animated_visibility/animated_visibility.dart';
import 'package:d3_wallet/base/widgets/pretty_animated_qr_view.dart';
import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/colors.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:d3_wallet/utils/extensions/double_extension.dart';
import 'package:d3_wallet/utils/extensions/string_ext.dart';
import 'package:d3_wallet/utils/gradient_utils.dart';
import 'package:d3_wallet/utils/constants.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../controllers/wallet_card_controller.dart';

class WalletCardView extends StatefulWidget {
  const WalletCardView({super.key, this.wallet, this.walletIndex = 0});

  final int walletIndex;
  final WalletResponseObject? wallet;

  @override
  State<WalletCardView> createState() => _WalletCardViewState();
}

class _WalletCardViewState extends State<WalletCardView> with AutomaticKeepAliveClientMixin {
  late final WalletCardController controller;

  @protected
  late PrettyQrDecoration decoration;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    // Create a unique tag for this wallet's controller
    final tag = GetXControllerTags.walletCard(
      widget.wallet?.address ?? widget.walletIndex.toString(),
    );

    // Try to find existing controller, or create a new permanent one
    if (Get.isRegistered<WalletCardController>(tag: tag)) {
      controller = Get.find<WalletCardController>(tag: tag);
      Fimber.d("Reusing existing controller for tag: $tag");
    } else {
      controller = Get.put(WalletCardController(), tag: tag, permanent: true);
      Fimber.d("Created new permanent controller for tag: $tag");
    }

    decoration = PrettyQrDecoration(
      shape: const PrettyQrSmoothSymbol(color: AppColors.ink100, roundFactor: 1),
      image: PrettyQrDecorationImage(
        image: Assets.images.icZeno.provider(),
        opacity: 0.69,
        position: .embedded,
      ),
      background: Colors.transparent,
      quietZone: .zero,
    );
    controller.updateWallet(widget.wallet, widget.walletIndex);
  }

  @override
  void dispose() {
    // Don't delete the controller - it's permanent and will be reused
    // Only dispose when the wallet is actually removed from the list
    Fimber.d("WalletCardView dispose called for ${widget.wallet?.address}");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required by AutomaticKeepAliveClientMixin
    return Stack(
      alignment: .bottomRight,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: .circular(20),
            gradient: LinearGradient(
              colors: GradientUtils.getWalletGradientColors(context, widget.walletIndex),
              begin: .centerLeft,
              end: .centerRight,
              stops: const [0.0, 0.2, 1.0],
            ),
          ),
          child: Stack(
            alignment: .center,
            children: [
              Stack(
                children: [
                  Positioned(
                    right: 75,
                    child: Assets.images.icFingerPrint1.svg(height: 56, fit: .cover),
                  ),
                  Positioned(
                    left: 26,
                    bottom: 0,
                    child: Assets.images.icFingerPrint2.svg(height: 56, fit: .cover),
                  ),
                  Positioned(
                    right: 18,
                    bottom: 12,
                    child: Obx(
                      () => Visibility(
                        visible: !controller.showQRCode.value,
                        maintainSize: true,
                        maintainState: true,
                        maintainAnimation: true,
                        child: Assets.images.icCardArrowDown.svg(height: 68, fit: .cover),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const .symmetric(vertical: 20, horizontal: 16),
                child: Column(
                  mainAxisAlignment: .start,
                  crossAxisAlignment: .start,
                  mainAxisSize: .min,
                  children: [
                    Row(
                      mainAxisAlignment: .start,
                      crossAxisAlignment: .center,
                      mainAxisSize: .max,
                      children: [
                        Text(
                          widget.wallet?.name ?? "Account",
                          style: context.appThemes.bold18.copyWith(
                            color: GradientUtils.getTextColorForGradient(
                              context,
                              widget.walletIndex,
                            ),
                          ),
                        ),
                        const Expanded(child: SizedBox.shrink()),
                        Assets.images.icVerticalDots
                            .svg(fit: .cover, height: 24)
                            .paddingSymmetric(horizontal: 12),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: .start,
                      crossAxisAlignment: .center,
                      mainAxisSize: .max,
                      children: [
                        Obx(
                          () => Text.rich(
                            maxLines: 1,
                            overflow: .ellipsis,
                            TextSpan(
                              text: "\$ ",
                              style: context.appThemes.bold24.copyWith(
                                color: GradientUtils.getTextColorForGradient(
                                  context,
                                  widget.walletIndex,
                                ),
                              ),
                              children: [
                                TextSpan(
                                  text: controller.balanceIsHidden.value
                                      ? LocaleKeys.myWalletHiddenBalance.tr
                                      : controller.fullBalance.value.shrinkAndReformat(),
                                  style: context.appThemes.bold24.copyWith(
                                    color: GradientUtils.getTextColorForGradient(
                                      context,
                                      widget.walletIndex,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Obx(
                          () => InkWell(
                            onTap: () => controller.hideBalance(),
                            child: controller.balanceIsHidden.value
                                ? Assets.images.icVisibility.svg(
                                    width: 24,
                                    height: 24,
                                    fit: .contain,
                                    colorFilter: .mode(
                                      GradientUtils.getTextColorForGradient(
                                        context,
                                        widget.walletIndex,
                                      ),
                                      .srcIn,
                                    ),
                                  )
                                : Assets.images.icInvisibility.svg(
                                    width: 24,
                                    height: 24,
                                    fit: .contain,
                                    colorFilter: .mode(
                                      GradientUtils.getTextColorForGradient(
                                        context,
                                        widget.walletIndex,
                                      ),
                                      .srcIn,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Obx(
                      () => Visibility(
                        child: controller.balanceIsHidden.value
                            ? Container(
                                alignment: .centerLeft,
                                child: Text(
                                  LocaleKeys.myWalletHiddenBalance.tr,
                                  style: context.appThemes.regular14.copyWith(
                                    color: GradientUtils.getTextColorForGradient(
                                      context,
                                      controller.walletIndex,
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  color: context.appThemes.materialIndigo.withValues(alpha: 0.7),
                                  borderRadius: .circular(8),
                                ),
                                padding: const .symmetric(vertical: 3, horizontal: 3),
                                child: Row(
                                  mainAxisAlignment: .start,
                                  crossAxisAlignment: .center,
                                  mainAxisSize: .min,
                                  children: [
                                    Assets.images.icArrowAltLtop.svg(
                                      width: 12,
                                      height: 12,
                                      fit: .contain,
                                    ),
                                    Text(
                                      "20,878,699",
                                      style: context.appThemes.regular14.copyWith(
                                        color: context.appThemes.green100,
                                      ),
                                    ),
                                    Text(
                                      "\$",
                                      style: context.appThemes.regular14.copyWith(
                                        color: context.appThemes.green100,
                                      ),
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      "(+11.48%)",
                                      style: context.appThemes.regular14.copyWith(
                                        color: context.appThemes.green100,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: .start,
                      crossAxisAlignment: .center,
                      mainAxisSize: .max,
                      children: [
                        Text(
                          (widget.wallet?.address ?? "").formatWalletAddress() ?? "",
                          style: context.appThemes.regular20.copyWith(
                            color: GradientUtils.getTextColorForGradient(
                              context,
                              widget.walletIndex,
                            ).withValues(alpha: 0.6),
                          ),
                          textAlign: .start,
                        ),
                        const SizedBox(width: 16),
                        InkWell(
                          onTap: () => controller.copyAddress(),
                          child: Assets.images.icLucideCopy.svg(
                            width: 24,
                            height: 24,
                            fit: .contain,
                            colorFilter: .mode(
                              GradientUtils.getTextColorForGradient(
                                context,
                                widget.walletIndex,
                              ).withValues(alpha: 0.6),
                              .srcIn,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => AnimatedVisibility(
            visible: controller.showQRCode.value,
            enter: fadeIn(),
            exit: fadeOut(),
            enterDuration: const Duration(seconds: 2),
            child: Container(
              color: context.appThemes.white,
              width: 96,
              height: 96,
              child: Obx(
                () => controller.qrImage.value == null
                    ? const SizedBox.shrink()
                    : PrettyAnimatedQrView(
                        qrImage: controller.qrImage.value!,
                        decoration: decoration,
                      ).paddingAll(3),
              ),
            ).marginOnly(right: 16, bottom: 16),
          ),
        ),
      ],
    );
  }
}
