// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:d3_wallet/app/modules/home/constants/nav_ids.dart';
import 'package:d3_wallet/app/modules/trends/bindings/trends_binding.dart';
import 'package:d3_wallet/app/routes/app_pages.dart';
import 'package:d3_wallet/app/routes/navigation_arguments.dart';
import 'package:d3_wallet/base/infinite_list/base_infinite_lis_view_with_binding_creator.dart';
import 'package:d3_wallet/data/bean/response/coin_market_res_object/coin_market_res_object.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:d3_wallet/utils/extensions/double_extension.dart';
import 'package:d3_wallet/utils/extensions/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/trends_controller.dart';
import 'widgets/trends_search_bar.dart';

class TrendsView extends BaseInfiniteListViewWithCreator<TrendsBinding, TrendsController> {
  TrendsView({super.key});

  @override
  bool get appBarIsHidden => true;

  @override
  Widget buildMainViews(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // call this method here to hide soft keyboard
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Column(
        children: [
          Obx(
            () => TrendsSearchBar(
              onChanged: controller.onSearchChanged,
              history: controller.searchHistory.toList(),
              onFocusChanged: (focused) => controller.isSearchFocused.value = focused,
              onMicTap: controller.onMicTap,
              onHistoryTap: controller.onHistoryTap,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(child: super.buildMainViews(context)),
        ],
      ),
    );
  }

  @override
  Widget buildItemViews(BuildContext context, {item, int? index}) {
    if (item is CoinMarketResObject) {
      return InkWell(
        onTap: () {
          Get.toNamed(
            Routes.COIN_MARKET_DETAIL,
            arguments: {NavigationArguments.coinMarketInfo: item},
            id: NavIds.trends,
          );
        },
        child: Container(
          color: context.appThemes.white,
          width: double.infinity,
          padding: .only(left: 16, right: 16, top: index == 0 ? 0 : 12, bottom: 12),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: .start,
              crossAxisAlignment: .center,
              mainAxisSize: .min,
              children: [
                IntrinsicHeight(
                  child: ClipRRect(
                    borderRadius: .circular(200),
                    child: item.logo?.isNotBlank() == true
                        ? CachedNetworkImage(
                            width: 42,
                            height: 42,
                            imageUrl: item.logo ?? "",
                            fit: .cover,
                          )
                        : Assets.images.appstore.image(width: 42, height: 42, fit: .cover),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: .start,
                    crossAxisAlignment: .start,
                    mainAxisSize: .max,
                    children: [
                      Text(
                        item.symbol ?? "",
                        style: context.appThemes.regular14.copyWith(
                          color: context.appThemes.ink100,
                        ),
                        textAlign: .start,
                        maxLines: 1,
                        overflow: .ellipsis,
                      ),
                      Text(
                        item.volume24h?.shrinkCurrencyAsFixed() ?? "",
                        style: context.appThemes.medium14.copyWith(color: context.appThemes.ink60),
                        textAlign: .start,
                        maxLines: 1,
                        overflow: .ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  mainAxisAlignment: .end,
                  crossAxisAlignment: .end,
                  mainAxisSize: .min,
                  children: [
                    Text(
                      CurrencyTextInputFormatter.simpleCurrency().formatDouble(item.price ?? 0.0),
                      style: context.appThemes.medium14.copyWith(color: context.appThemes.ink100),
                      textAlign: .end,
                      maxLines: 1,
                      overflow: .ellipsis,
                    ),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: .start,
                        crossAxisAlignment: .center,
                        mainAxisSize: .min,
                        children: [
                          Container(
                            height: double.infinity,
                            alignment: .center,
                            child: item.percentChange24h?.isNegative == true
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
                                  ),
                          ),
                          Container(
                            alignment: .centerLeft,
                            height: double.infinity,
                            child: Text(
                              item.percentChange24h != null
                                  ? "${item.percentChange24h?.isNegative == true ? "" : "+"}${item.percentChange24h?.toStringAsFixed(2)}%"
                                  : "0.00%",
                              style: context.appThemes.regular10.copyWith(
                                color: item.percentChange24h?.isNegative == true
                                    ? context.appThemes.red100
                                    : context.appThemes.green100,
                              ),
                              textAlign: .end,
                              maxLines: 1,
                              overflow: .ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
