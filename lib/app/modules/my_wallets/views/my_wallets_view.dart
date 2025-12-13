// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:d3_wallet/app/modules/comming_soon_modal/bindings/comming_soon_modal_binding.dart';
import 'package:d3_wallet/app/modules/comming_soon_modal/views/comming_soon_modal_view.dart';
import 'package:d3_wallet/app/modules/my_wallets/bindings/my_wallets_binding.dart';
import 'package:d3_wallet/app/modules/network_selection/views/network_selection_view.dart';
import 'package:d3_wallet/app/routes/app_pages.dart';
import 'package:d3_wallet/app/routes/navigation_arguments.dart';
import 'package:d3_wallet/base/base_binding_creator_widget.dart';
import 'package:d3_wallet/data/bean/response/network_object/network_object.dart';
import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:d3_wallet/utils/extensions/double_extension.dart';
import 'package:d3_wallet/utils/extensions/string_ext.dart';
import 'package:d3_wallet/utils/gradient_utils.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boring_avatars/flutter_boring_avatars.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/utils.dart';

import '../controllers/my_wallets_controller.dart';

class MyWalletsView extends BaseBindingCreatorView<MyWalletsBinding, MyWalletsController> {
  MyWalletsView({super.key, required super.bindingCreator});

  @override
  Widget? onCreateViews(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // call this method here to hide soft keyboard
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          top: true,
          bottom: true,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: GetPlatform.isIOS ? 0 : 13),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                _buildTopBar(context),
                SizedBox(height: 16),
                _buildWalletInfo(context),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TokenActionButton(
                      icon: Assets.images.icSend,
                      title: LocaleKeys.walletActionSend.tr,
                    ),
                    TokenActionButton(
                      icon: Assets.images.icReceive,
                      title: LocaleKeys.walletActionReceive.tr,
                    ),
                    TokenActionButton(
                      icon: Assets.images.icBuy,
                      title: LocaleKeys.walletActionBuy.tr,
                    ),
                    TokenActionButton(
                      icon: Assets.images.icStaking,
                      title: LocaleKeys.walletActionStaking.tr,
                    ),
                  ],
                ).paddingSymmetric(horizontal: 50),
                SizedBox(height: 26),
                Container(width: double.infinity, height: 1, color: context.appThemes.ink5),
                Obx(() {
                  if (controller.isLoading.value == true) {
                    WidgetsBinding.instance.addPostFrameCallback((duration) {
                      // EasyLoading.show();
                      SmartDialog.showLoading(msg: "");
                    });
                  } else {
                    WidgetsBinding.instance.addPostFrameCallback((duration) {
                      // EasyLoading.dismiss();
                      SmartDialog.dismiss();
                    });
                  }
                  return const SizedBox.shrink();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _handleActions(BuildContext context, AccountActions action, WalletResponseObject? wallet) async {
    switch (action) {
      case AccountActions.shareLink:
        Fimber.d("AccountActions.shareLink");
        break;
      case AccountActions.showSecureQuestions:
        final nextAction = await showWrapBottomSheet(
          context,
          CommingSoonModalView(bindingCreator: () => CommingSoonModalBinding()),
          routeSettings: RouteSettings(name: Routes.COMMING_SOON_MODAL),
        );
        _handleActions(context, nextAction, wallet);
        break;
      case AccountActions.showFirstSecureQuestion:
        final nextAction = await showWrapBottomSheet(
          context,
          CommingSoonModalView(bindingCreator: () => CommingSoonModalBinding()),
          routeSettings: RouteSettings(name: Routes.COMMING_SOON_MODAL),
        );
        _handleActions(context, nextAction, wallet);
        break;
      case AccountActions.showSecondSecureQuestion:
        final nextAction = await showWrapBottomSheet(
          context,
          CommingSoonModalView(bindingCreator: () => CommingSoonModalBinding()),
          routeSettings: RouteSettings(name: Routes.COMMING_SOON_MODAL),
        );
        _handleActions(context, nextAction, wallet);
        break;
      case AccountActions.showMnemonics:
        final done = await Get.toNamed(
          Routes.HOME,
          arguments: {NavigationArguments.selectedWallet: wallet},
        );
        if (done) {
          controller.backupIsDone();
        }
        break;
      default:
        break;
    }
  }

  _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        InkWell(
          onTap: () async {
            showWrapBottomSheet(
              context,
              CommingSoonModalView(bindingCreator: () => CommingSoonModalBinding()),
              routeSettings: RouteSettings(name: Routes.COMMING_SOON_MODAL),
            );
          },
          child: SizedBox(
            width: 48,
            height: 48,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(48),
              child: AnimatedBoringAvatar(
                name: "ZenoWallet - Pieter",
                type: BoringAvatarType.beam,
                duration: const Duration(milliseconds: 300),
              ),
            ),
          ),
        ),
        SizedBox(width: 48),
        Expanded(child: SizedBox.shrink()),
        InkWell(
          onTap: () async {
            Fimber.d("select network");
            final selectedNetwork = await showModalBottomSheet(
              context: context,
              useRootNavigator: true,
              backgroundColor: context.appThemes.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              builder:
                  (context) => Padding(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Wrap(
                      children: [
                        NetworkSelectionView(selectedNetwork: controller.selectedNetwork.value),
                      ],
                    ),
                  ),
              routeSettings: RouteSettings(name: Routes.NETWORK_SELECTION),
              isScrollControlled: true,
            );
            final selectedNetworkValue = selectedNetwork as NetworkObject?;
            if (selectedNetworkValue == null) return;
            controller.updateSelectedNetwork(selectedNetworkValue);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  context.appThemes.middleBlue,
                  context.appThemes.middleBlue,
                  context.appThemes.pinkLady,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.0, 0.2, 1.0],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  () => SizedBox(
                    width: 24,
                    height: 24,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: CachedNetworkImage(
                        imageUrl: controller.selectedNetwork.value.logo ?? "",
                        width: 36,
                        height: 36,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 6),
                Text(
                  controller.selectedNetwork.value.name ?? "",
                  style: context.appThemes.medium14.copyWith(color: context.appThemes.white),
                ),
                SizedBox(width: 6),
                Assets.images.icChevronDown.svg(
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(context.appThemes.white, BlendMode.srcIn),
                ),
              ],
            ),
          ),
        ),
        Expanded(child: SizedBox.shrink()),
        InkWell(
          onTap: () async {
            showWrapBottomSheet(
              context,
              CommingSoonModalView(bindingCreator: () => CommingSoonModalBinding()),
              routeSettings: RouteSettings(name: Routes.COMMING_SOON_MODAL),
            );
          },
          child: Assets.images.icSearch
              .svg(width: 24, height: 24, fit: BoxFit.cover)
              .paddingSymmetric(horizontal: 12),
        ),
        InkWell(
          onTap: () async {
            showWrapBottomSheet(
              context,
              CommingSoonModalView(bindingCreator: () => CommingSoonModalBinding()),
              routeSettings: RouteSettings(name: Routes.COMMING_SOON_MODAL),
            );
          },
          child: Assets.images.icBitcoinCard
              .svg(
                width: 24,
                height: 24,
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(context.appThemes.trueBlue, BlendMode.srcIn),
              )
              .paddingSymmetric(horizontal: 12),
        ),
      ],
    ).paddingSymmetric(horizontal: 16);
  }

  _buildWalletInfo(BuildContext context) {
    return Obx(() {
      final wallets = controller.wallets;

      if (wallets.isEmpty) {
        return SizedBox(
          height: 186,
          child: Center(
            child: Text(
              LocaleKeys.noWalletsAvailable.tr,
              style: context.appThemes.regular16.copyWith(color: context.appThemes.ink60),
            ),
          ),
        );
      }

      final reversedWallets = wallets.reversed.toList();

      return Container(
        height: 186,
        alignment: Alignment.center,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Swiper(
              itemCount: reversedWallets.length,
              index: reversedWallets.length - 1,
              itemBuilder:
                  (context, index) =>
                      _buildWalletCard(context, reversedWallets[index], constraints, index),
              layout: SwiperLayout.STACK,
              itemWidth: constraints.maxWidth * 0.86,
              scale: 0.96,
              loop: false,
            );
          },
        ),
      );
    });
  }

  Widget _buildWalletCard(
    BuildContext context,
    WalletResponseObject? wallet,
    BoxConstraints constraints,
    int walletIndex,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: GradientUtils.getWalletGradientColors(context, walletIndex),
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.0, 0.3, 1.0],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: 335 / 168,
            child: Assets.images.icWalletBackground2.svg(
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
                      wallet?.name ?? "Account",
                      style: context.appThemes.bold18.copyWith(
                        color: GradientUtils.getTextColorForGradient(context, walletIndex),
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
                            color: GradientUtils.getTextColorForGradient(context, walletIndex),
                          ),
                          children: [
                            TextSpan(
                              text:
                                  controller.balanceIsHidden.value
                                      ? LocaleKeys.myWalletHiddenBalance.tr
                                      : controller.fullBalance.value.shrinkAndReformat(),
                              style: context.appThemes.bold24.copyWith(
                                color: GradientUtils.getTextColorForGradient(context, walletIndex),
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
                                    GradientUtils.getTextColorForGradient(context, walletIndex),
                                    BlendMode.srcIn,
                                  ),
                                )
                                : Assets.images.icInvisibility.svg(
                                  width: 24,
                                  height: 24,
                                  fit: BoxFit.contain,
                                  colorFilter: ColorFilter.mode(
                                    GradientUtils.getTextColorForGradient(context, walletIndex),
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
                              decoration: BoxDecoration(
                                color: context.appThemes.materialIndigo.withValues(alpha: 0.7),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "••••••••",
                                style: context.appThemes.regular14.copyWith(
                                  color: context.appThemes.ink40,
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
                      (wallet?.address ?? "").formatWalletAddress() ?? "",
                      style: context.appThemes.regular20.copyWith(
                        color: GradientUtils.getTextColorForGradient(
                          context,
                          walletIndex,
                        ).withValues(alpha: 0.6),
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(width: 16),
                    Assets.images.icCopyLine.svg(
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                      colorFilter: ColorFilter.mode(
                        GradientUtils.getTextColorForGradient(
                          context,
                          walletIndex,
                        ).withValues(alpha: 0.6),
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _showCommingSoon(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: context.appThemes.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder:
          (context) => Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Wrap(
              children: [CommingSoonModalView(bindingCreator: () => CommingSoonModalBinding())],
            ),
          ),
      routeSettings: RouteSettings(name: Routes.COMMING_SOON_MODAL),
      isScrollControlled: true,
    );
  }
}

class TokenActionButton extends StatelessWidget {
  const TokenActionButton({super.key, required this.icon, required this.title});

  final AssetGenImage icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        icon.image(width: 53, height: 80, fit: BoxFit.cover).paddingOnly(bottom: 6),
        Text(title, style: context.appThemes.bold14.copyWith(color: context.appThemes.greenVogue)),
      ],
    );
  }
}
