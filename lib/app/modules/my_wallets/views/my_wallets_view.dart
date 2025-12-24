// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:d3_wallet/base/dialog_mixin.dart';
import 'package:d3_wallet/app/modules/my_wallets/bindings/my_wallets_binding.dart';
import 'package:d3_wallet/app/modules/my_wallets/wallet_card/views/wallet_card_view.dart';
import 'package:d3_wallet/app/modules/network_selection/views/network_selection_view.dart';
import 'package:d3_wallet/app/modules/wallet_token_info/views/wallet_token_info_view.dart';
import 'package:d3_wallet/app/routes/app_pages.dart';
import 'package:d3_wallet/base/base_binding_creator_widget.dart';
import 'package:d3_wallet/data/bean/response/network_object/network_object.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:d3_wallet/utils/constants.dart';
import 'package:dart_helper_utils/dart_helper_utils.dart';
import 'package:fimber/fimber.dart';
import 'package:d3_wallet/widgets/token_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boring_avatars/flutter_boring_avatars.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/utils.dart';

import '../controllers/my_wallets_controller.dart';

class MyWalletsView extends BaseBindingCreatorView<MyWalletsBinding, MyWalletsController>
    with DialogMixin {
  MyWalletsView({super.key, super.bindingCreator});

  @override
  Widget? onCreateViews(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          top: true,
          bottom: true,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: GetPlatform.isIOS ? 0 : 13),
            child: Column(
              mainAxisAlignment: .start,
              crossAxisAlignment: .start,
              mainAxisSize: .max,
              children: [
                _buildTopBar(context),
                const SizedBox(height: 16),
                _buildWalletInfo(context),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: .spaceBetween,
                  crossAxisAlignment: .center,
                  mainAxisSize: .max,
                  children: [
                    InkWell(
                      onTap: () => showCommingSoon(context),
                      child: TokenActionButton(
                        icon: Assets.images.icSend,
                        title: LocaleKeys.walletActionSend.tr,
                      ),
                    ),
                    InkWell(
                      onTap: () => showCommingSoon(context),
                      child: TokenActionButton(
                        icon: Assets.images.icReceive,
                        title: LocaleKeys.walletActionReceive.tr,
                      ),
                    ),
                    InkWell(
                      onTap: () => showCommingSoon(context),
                      child: TokenActionButton(
                        icon: Assets.images.icBuy,
                        title: LocaleKeys.walletActionBuy.tr,
                      ),
                    ),
                    InkWell(
                      onTap: () => showCommingSoon(context),
                      child: TokenActionButton(
                        icon: Assets.images.icStaking,
                        title: LocaleKeys.walletActionStaking.tr,
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 50),
                const SizedBox(height: 26),
                Expanded(
                  child: Padding(
                    padding: const .symmetric(horizontal: 16),
                    child: Obx(
                      () => WalletTokenInfoView(
                        selectedWallet: controller.selectedWallet.value,
                        balanceIsHidden: controller.balanceIsHidden.value,
                      ),
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
          ),
        ),
      ),
    );
  }

  _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: .start,
      crossAxisAlignment: .center,
      mainAxisSize: .max,
      children: [
        InkWell(
          onTap: () => showCommingSoon(context),
          child: SizedBox(
            width: 48,
            height: 48,
            child: ClipRRect(
              borderRadius: .circular(48),
              child: AnimatedBoringAvatar(
                name: "ZenoWallet - Pieter",
                type: BoringAvatarType.beam,
                duration: const Duration(milliseconds: 300),
              ),
            ),
          ),
        ),
        const SizedBox(width: 48),
        Expanded(child: SizedBox.shrink()),
        InkWell(
          onTap: () async {
            Fimber.d("select network");
            final selectedNetwork = await showModalBottomSheet(
              context: context,
              useRootNavigator: true,
              backgroundColor: context.appThemes.transparent,
              shape: RoundedRectangleBorder(borderRadius: .vertical(top: .circular(8))),
              clipBehavior: .antiAliasWithSaveLayer,
              builder: (context) => Padding(
                padding: .only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Wrap(
                  children: [
                    NetworkSelectionView(selectedNetwork: controller.selectedNetwork.value),
                  ],
                ),
              ),
              routeSettings: const RouteSettings(name: Routes.NETWORK_SELECTION),
              isScrollControlled: true,
            );
            final selectedNetworkValue = selectedNetwork as NetworkObject?;
            if (selectedNetworkValue == null) return;
            controller.updateSelectedNetwork(selectedNetworkValue);
          },
          child: Container(
            padding: const .symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: .circular(20),
              gradient: LinearGradient(
                colors: [
                  context.appThemes.middleBlue,
                  context.appThemes.middleBlue,
                  context.appThemes.pinkLady,
                ],
                begin: .centerLeft,
                end: .centerRight,
                stops: const [0.0, 0.2, 1.0],
              ),
            ),
            child: Row(
              mainAxisAlignment: .start,
              crossAxisAlignment: .center,
              mainAxisSize: .min,
              children: [
                Obx(
                  () => SizedBox(
                    width: 24,
                    height: 24,
                    child: ClipRRect(
                      borderRadius: .circular(24),
                      child: CachedNetworkImage(
                        imageUrl: controller.selectedNetwork.value.logo ?? "",
                        width: 36,
                        height: 36,
                        fit: .cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  controller.selectedNetwork.value.name ?? "",
                  style: context.appThemes.medium14.copyWith(color: context.appThemes.white),
                ),
                const SizedBox(width: 6),
                Assets.images.icChevronDown.svg(
                  width: 24,
                  height: 24,
                  fit: .cover,
                  colorFilter: .mode(context.appThemes.white, .srcIn),
                ),
              ],
            ),
          ),
        ),
        const Expanded(child: SizedBox.shrink()),
        InkWell(
          onTap: () => showCommingSoon(context),
          child: Assets.images.icSearch
              .svg(width: 24, height: 24, fit: .cover)
              .paddingSymmetric(horizontal: 12),
        ),
        InkWell(
          onTap: () => showCommingSoon(context),
          child: Assets.images.icBitcoinCard
              .svg(
                width: 24,
                height: 24,
                fit: .cover,
                colorFilter: .mode(context.appThemes.trueBlue, .srcIn),
              )
              .paddingOnly(left: 12),
        ),
      ],
    ).paddingSymmetric(horizontal: 16);
  }

  _buildWalletInfo(BuildContext context) {
    return Obx(() {
      final wallets = controller.wallets;

      if (wallets.isEmptyOrNull) {
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
        alignment: .center,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Swiper(
              key: const PageStorageKey<String>(PageStorageKeys.WALLETS_SWIPER),
              itemCount: reversedWallets.length,
              index: reversedWallets.length - 1,
              itemBuilder: (context, index) {
                final wallet = reversedWallets[index];
                return WalletCardView(
                  key: ValueKey(PageStorageKeys.walletCardKey(wallet?.address, index)),
                  wallet: wallet,
                  walletIndex: index,
                );
              },
              onIndexChanged: (index) {
                Fimber.d("onIndexChanged - index: $index");
                controller.updateSelectedWallet(reversedWallets[index]);
              },
              layout: .STACK,
              itemWidth: controller.wallets.length > 1
                  ? constraints.maxWidth - 40
                  : constraints.maxWidth - 32,
              scale: 0.96,
              loop: false,
            );
          },
        ),
      );
    });
  }
}
