// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:d3_wallet/base/base_binding_stateful_networking_view.dart';
import 'package:d3_wallet/base/binding_creator.dart';
import 'package:d3_wallet/base/widgets/custom_unfilled_button.dart';
import 'package:d3_wallet/data/bean/response/token_account_object/token_account_object.dart';
import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:d3_wallet/utils/extensions/string_ext.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bindings/my_tokens_binding.dart';
import '../controllers/my_tokens_controller.dart';

class MyTokensView extends BaseBindingStatefulNetworkingView<MyTokensBinding, MyTokensController> {
  const MyTokensView({super.key, this.bindingCreator, this.selectedWallet, this.balanceIsHidden});

  @override
  final BindingCreator<MyTokensBinding>? bindingCreator;

  final WalletResponseObject? selectedWallet;
  final bool? balanceIsHidden;

  @override
  Widget? buildLoading(BuildContext context) {
    return Center(
      child: Assets.lotties.sandyLoading.lottie(
        width: 120,
        height: 120,
        fit: .cover,
        animate: true,
        repeat: true,
        backgroundLoading: true,
      ),
    );
  }

  @override
  Widget buildEmpty(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .center,
        mainAxisSize: .min,
        children: [
          Assets.images.icNoFound.svg(width: 86, fit: .cover),
          const SizedBox(height: 4),
          Text(
            LocaleKeys.tokenNotFoundMessage.tr,
            style: context.appThemes.regular14.copyWith(color: context.appThemes.ink60),
          ),
          const SizedBox(height: 4),
          CustomUnfilledButton(
            text: LocaleKeys.addToken.tr,
            onPressed: () => Fimber.d("Add token"),
          ),
        ],
      ),
    );
  }

  @override
  void onLoadData(MyTokensController controller) {
    // This is called in initState and didUpdateWidget
    // It handles triggering the data fetch
    controller.hiddenBalanceChanged(balanceIsHidden);
    controller.fetchTokenAccounts(WalletResponseObject(address: selectedWallet?.address ?? ""));
  }

  @override
  Widget buildBody(BuildContext context, state) {
    // Now buildBody is purely for rendering - no lifecycle logic!
    // Get controller from GetX since StatefulWidget doesn't have direct access
    final controller = Get.find<MyTokensController>();

    return Obx(
      () => ListView.separated(
        padding: const .symmetric(vertical: 10),
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemCount: controller.tokens.value.length,
        itemBuilder: (context, index) => _buildTokenItem(
          context,
          controller.tokens.value[index],
          controller.balanceIsHidden.value,
        ),
      ),
    );
  }

  _buildTokenItem(BuildContext context, TokenAccountObject? token, bool? balanceIsHidden) {
    return Row(
      mainAxisAlignment: .start,
      crossAxisAlignment: .start,
      mainAxisSize: .max,
      children: [
        _createCoinLogo(token),
        const SizedBox(width: 12),
        Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          mainAxisSize: .max,
          children: [
            Text(
              token?.mintToken?.name ?? "",
              style: context.appThemes.medium14.copyWith(color: context.appThemes.ink100),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: .start,
              crossAxisAlignment: .center,
              mainAxisSize: .max,
              children: [
                _retrieveCoinTrendingIcon(context, token),
                Text(
                  token?.percentChange24h != null
                      ? "${token?.percentChange24h?.isNegative == true ? "" : "+"}${token?.percentChange24h?.toStringAsFixed(4)}%"
                      : "0.00%",
                  style: context.appThemes.regular10.copyWith(
                    color: token?.percentChange24h?.isNegative == true
                        ? context.appThemes.red100
                        : context.appThemes.green100,
                  ),
                  textAlign: .end,
                  maxLines: 1,
                  overflow: .ellipsis,
                ),
              ],
            ),
          ],
        ),
        Expanded(child: SizedBox.shrink()),
        Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .end,
          mainAxisSize: .min,
          children: [
            Text(
              balanceIsHidden != true
                  ? (token?.amount.toString()).buildCoinPrice(
                          token?.mintToken?.symbol ?? "",
                          decimalDigits: 2,
                        ) ??
                        ""
                  : LocaleKeys.myWalletHiddenBalance.tr,
              style: context.appThemes.medium14.copyWith(color: context.appThemes.ink100),
            ),
            Row(
              mainAxisAlignment: .start,
              crossAxisAlignment: .center,
              mainAxisSize: .max,
              children: [
                Text(
                  balanceIsHidden != true
                      ? token?.estimateAmountInUSD() ?? ""
                      : LocaleKeys.myWalletHiddenBalance.tr,
                  style: context.appThemes.regular10.copyWith(color: context.appThemes.ink60),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  _createCoinLogo(TokenAccountObject? token) {
    return Stack(
      children: [
        Padding(
          padding: const .only(top: 4),
          child: SizedBox(
            width: 36,
            height: 36,
            child: ClipRRect(
              borderRadius: .circular(100),
              child: CachedNetworkImage(
                width: 27,
                height: 27,
                imageUrl: token?.mintToken?.logo ?? "",
                fit: .cover,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: ClipRRect(
            borderRadius: .circular(14),
            child: Assets.images.icSolana.svg(width: 12, height: 12, fit: .cover),
          ),
        ),
      ],
    );
  }

  _retrieveCoinTrendingIcon(BuildContext context, TokenAccountObject? token) {
    return token?.percentChange24h?.isNegative == true
        ? Transform.rotate(
            angle: 0 * pi / 180,
            child: Assets.images.icArrowAltLdown.svg(
              fit: .cover,
              colorFilter: .mode(context.appThemes.red100, .srcATop),
            ),
          )
        : Transform.rotate(
            angle: 180 * pi / 180,
            child: Assets.images.icArrowAltLdown.svg(
              fit: .cover,
              colorFilter: .mode(context.appThemes.green100, .srcATop),
            ),
          );
  }
}
