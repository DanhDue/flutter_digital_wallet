// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/base/widgets/pretty_animated_qr_view.dart';
import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/colors.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:d3_wallet/utils/extensions/double_extension.dart';
import 'package:d3_wallet/utils/extensions/string_ext.dart';
import 'package:d3_wallet/utils/gradient_utils.dart';
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

class _WalletCardViewState extends State<WalletCardView> {
  late final WalletCardController controller;

  @protected
  late PrettyQrDecoration decoration;

  @override
  void initState() {
    super.initState();

    // Create a unique controller for each card using wallet address as tag
    final tag = 'wallet_card_${widget.wallet?.address ?? widget.walletIndex}';
    controller = Get.put(WalletCardController(), tag: tag, permanent: false);

    decoration = PrettyQrDecoration(
      shape: const PrettyQrSmoothSymbol(color: AppColors.ink100, roundFactor: 1),
      image: PrettyQrDecorationImage(
        image: Assets.images.icZeno.provider(),
        opacity: 0.69,
        position: PrettyQrDecorationImagePosition.embedded,
      ),
      background: Colors.transparent,
      quietZone: PrettyQrQuietZone.zero,
    );
    controller.updateWallet(widget.wallet, widget.walletIndex);
  }

  @override
  void dispose() {
    // Clean up the controller when widget is disposed
    final tag = 'wallet_card_${widget.wallet?.address ?? widget.walletIndex}';
    Get.delete<WalletCardController>(tag: tag);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: GradientUtils.getWalletGradientColors(context, widget.walletIndex),
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.0, 0.3, 1.0],
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Visibility(
                visible: true,
                child: Assets.images.icWalletBackground.svg(
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
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
                        Expanded(child: SizedBox.shrink()),
                        Assets.images.icVerticalDots
                            .svg(fit: BoxFit.cover, height: 24)
                            .paddingSymmetric(horizontal: 12),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Obx(
                          () => Text.rich(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
                                  text:
                                      controller.balanceIsHidden.value
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
                        SizedBox(width: 14),
                        Obx(
                          () => InkWell(
                            onTap: () => controller.hideBalance(),
                            child:
                                controller.balanceIsHidden.value
                                    ? Assets.images.icVisibility.svg(
                                      width: 24,
                                      height: 24,
                                      fit: BoxFit.contain,
                                      colorFilter: ColorFilter.mode(
                                        GradientUtils.getTextColorForGradient(
                                          context,
                                          widget.walletIndex,
                                        ),
                                        BlendMode.srcIn,
                                      ),
                                    )
                                    : Assets.images.icInvisibility.svg(
                                      width: 24,
                                      height: 24,
                                      fit: BoxFit.contain,
                                      colorFilter: ColorFilter.mode(
                                        GradientUtils.getTextColorForGradient(
                                          context,
                                          widget.walletIndex,
                                        ),
                                        BlendMode.srcIn,
                                      ),
                                    ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Obx(
                      () => Visibility(
                        child:
                            controller.balanceIsHidden.value
                                ? Container(
                                  alignment: Alignment.centerLeft,
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
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Assets.images.icArrowAltLtop.svg(
                                        width: 12,
                                        height: 12,
                                        fit: BoxFit.contain,
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
                                      SizedBox(width: 2),
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
                    SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          (widget.wallet?.address ?? "").formatWalletAddress() ?? "",
                          style: context.appThemes.regular20.copyWith(
                            color: GradientUtils.getTextColorForGradient(
                              context,
                              widget.walletIndex,
                            ).withValues(alpha: 0.6),
                          ),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(width: 16),
                        InkWell(
                          onTap: () => controller.copyAddress(),
                          child: Assets.images.icCopyLine.svg(
                            width: 24,
                            height: 24,
                            fit: BoxFit.contain,
                            colorFilter: ColorFilter.mode(
                              GradientUtils.getTextColorForGradient(
                                context,
                                widget.walletIndex,
                              ).withValues(alpha: 0.6),
                              BlendMode.srcIn,
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
          () => Visibility(
            visible: controller.showQRCode.value,
            child: Container(
              color: context.appThemes.white,
              width: 96,
              height: 96,
              child: PrettyAnimatedQrView(
                qrImage: QrImage(
                  QrCode.fromData(
                    data: controller.qrData.value,
                    errorCorrectLevel: QrErrorCorrectLevel.H,
                  ),
                ),
                decoration: decoration,
              ).paddingAll(3),
            ).marginOnly(right: 16, bottom: 16),
          ),
        ),
      ],
    );
  }
}
