// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:d3_wallet/app/modules/home/constants/nav_ids.dart';
import 'package:d3_wallet/base/dialog_mixin.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:d3_wallet/utils/extensions/double_extension.dart';
import 'package:d3_wallet/widgets/common_header_bar.dart';
import 'package:d3_wallet/widgets/token_action_button.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../controllers/coin_market_detail_controller.dart';

class CoinMarketDetailView extends StatefulWidget {
  const CoinMarketDetailView({super.key});

  @override
  State<CoinMarketDetailView> createState() => _CoinMarketDetailViewState();
}

class _CoinMarketDetailViewState extends State<CoinMarketDetailView> with DialogMixin {
  final controller = Get.put(CoinMarketDetailController(), permanent: false);

  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller = WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onHttpError: (HttpResponseError error) {
            debugPrint('Error occurred on page: ${error.response?.statusCode}');
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
          onHttpAuthRequest: (HttpAuthRequest request) {
            Fimber.d("request: $request");
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message.message)));
        },
      )
      ..loadRequest(Uri.parse('https://flutter.dev'))
      ..setOnConsoleMessage((message) {});

    // setBackgroundColor is not currently supported on macOS.
    if (kIsWeb || !Platform.isMacOS) {
      controller.setBackgroundColor(Colors.white);
    }

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      if (kDebugMode) {
        AndroidWebViewController.enableDebugging(true);
      }
      (controller.platform as AndroidWebViewController).setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features
    _webViewController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .center,
          mainAxisSize: .max,
          children: [
            Obx(
              () => CommonHeaderBar(
                title: controller.coinMarketInfo.value.name,
                network: "Solana Mainnet Beta",
                backPress: () => Get.back(id: NavIds.trends),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: .start,
                  crossAxisAlignment: .center,
                  mainAxisSize: .max,
                  children: [
                    Obx(
                      () => Container(
                        width: .infinity,
                        padding: const .all(16),
                        alignment: .centerLeft,
                        child: Row(
                          mainAxisAlignment: .spaceBetween,
                          crossAxisAlignment: .start,
                          mainAxisSize: .max,
                          children: [
                            Column(
                              mainAxisAlignment: .start,
                              crossAxisAlignment: .start,
                              mainAxisSize: .max,
                              children: [
                                Text(
                                  controller.coinMarketInfo.value.symbol ?? "",
                                  style: context.appThemes.medium14.copyWith(
                                    color: context.appThemes.ink60,
                                  ),
                                ),
                                Text(
                                  controller.coinMarketInfo.value.price?.shrinkCurrencyAsFixed() ??
                                      "",
                                  style: context.appThemes.medium14.copyWith(
                                    color: context.appThemes.ink60,
                                  ),
                                ),
                                IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment: .start,
                                    crossAxisAlignment: .center,
                                    mainAxisSize: .min,
                                    children: [
                                      RepaintBoundary(
                                        child: Container(
                                          height: .infinity,
                                          alignment: .center,
                                          child:
                                              controller
                                                      .coinMarketInfo
                                                      .value
                                                      .percentChange7d
                                                      ?.isNegative ==
                                                  true
                                              ? Transform.rotate(
                                                  angle: 0 * pi / 180,
                                                  child: Assets.images.icArrowAltLdown.svg(
                                                    fit: .cover,
                                                    colorFilter: ColorFilter.mode(
                                                      context.appThemes.red100,
                                                      .srcATop,
                                                    ),
                                                  ),
                                                )
                                              : Transform.rotate(
                                                  angle: 180 * pi / 180,
                                                  child: Assets.images.icArrowAltLdown.svg(
                                                    fit: .cover,
                                                    colorFilter: ColorFilter.mode(
                                                      context.appThemes.green100,
                                                      .srcATop,
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ),
                                      Container(
                                        alignment: .centerLeft,
                                        height: .infinity,
                                        child: Text(
                                          controller.coinMarketInfo.value.percentChange7d != null
                                              ? "${controller.coinMarketInfo.value.percentChange7d?.isNegative == true ? "" : "+"}${controller.coinMarketInfo.value.percentChange7d?.toStringAsFixed(2)}%"
                                              : "0.00%",
                                          style: context.appThemes.regular10.copyWith(
                                            color:
                                                controller
                                                        .coinMarketInfo
                                                        .value
                                                        .percentChange7d
                                                        ?.isNegative ==
                                                    true
                                                ? context.appThemes.red100
                                                : context.appThemes.green100,
                                          ),
                                          textAlign: .end,
                                          maxLines: 1,
                                          overflow: .ellipsis,
                                        ),
                                      ),
                                      Text(
                                        LocaleKeys.past7Days.tr,
                                        style: context.appThemes.regular10.copyWith(
                                          color: context.appThemes.ink60,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Obx(
                              () => Text(
                                "Rank: #${controller.coinMarketInfo.value.cmcRank ?? controller.coinMarketInfo.value.rank}",
                                style: context.appThemes.bold16.copyWith(
                                  color: context.appThemes.ink60,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    RepaintBoundary(
                      child: SizedBox(
                        height: 214,
                        child: WebViewWidget(controller: _webViewController),
                      ),
                    ),
                    Obx(() {
                      if (controller.coinMarketInfo.value.symbol?.isNotEmpty == true) {
                        WidgetsBinding.instance.addPostFrameCallback((duration) {
                          _webViewController.loadHtmlString("""
                          <div class="tradingview-widget-container">
                            <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-mini-symbol-overview.js">
                            {
                              "symbol": "BINANCE:${controller.coinMarketInfo.value.symbol}USDT",
                                "locale": "en",
                                "dateRange": "12M",
                                "colorTheme": "light",
                                "trendLineColor": "rgba(3, 125, 214, 1)",
                                "underLineColor": "rgba(3, 125, 214, 0.15)",
                                "displayMode": "adaptive",
                                "chartOnly": true,
                                "autosize": true,
                                "lineWidth": 4,
                                "lineType": 0,
                                "locale": "vi",
                                "isTransparent": true
                              }
                              </script>
                            </div>
                            """);
                        });
                      }
                      return const SizedBox.shrink();
                    }),
                    _buildActionsLayouts(context),
                    const SizedBox(height: 8),
                    _buildYourAmount(context),
                    const SizedBox(height: 24),
                    Obx(() => _buildCoinMarketInfo(context)),
                    const SizedBox(height: 24),
                    _buildLogs(context),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildLogs(BuildContext context) {
    return Container(
      width: .infinity,
      padding: const .symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          Text(
            LocaleKeys.coinMarketDetailCommunity.tr,
            style: context.appThemes.bold14.copyWith(color: context.appThemes.ink100),
          ),
          const SizedBox(height: 8),
          Text(
            LocaleKeys.coinMarketDetailNoComments.tr,
            style: context.appThemes.regular14.copyWith(color: context.appThemes.ink60),
          ),
        ],
      ),
    );
  }

  _buildCoinMarketInfo(BuildContext context) {
    final info = controller.coinMarketInfo.value;
    final volumePerAssets =
        (info.volume24h != null && info.marketCap != null && info.marketCap! > 0)
        ? (info.volume24h! / info.marketCap! * 100).toStringAsFixed(2)
        : "0.00";

    return Padding(
      padding: const .symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          Text(
            LocaleKeys.marketDetails.tr,
            style: context.appThemes.bold14.copyWith(color: context.appThemes.ink100),
          ),
          const SizedBox(height: 4),
          _buildCoinMarketItem(
            context,
            title: LocaleKeys.rank.tr,
            value: "#${info.cmcRank ?? info.rank ?? "--"}",
          ),
          _buildCoinMarketItem(
            context,
            title: LocaleKeys.marketCap.tr,
            value: info.marketCap?.shrinkCurrencyAsFixed() ?? "0.00 \$",
          ),
          _buildCoinMarketItem(
            context,
            title: LocaleKeys.volumeIn24h.tr,
            value: info.volume24h?.shrinkCurrencyAsFixed() ?? "0.00 \$",
          ),
          _buildCoinMarketItem(
            context,
            title: LocaleKeys.volumePerAssets.tr,
            value: "$volumePerAssets%",
          ),
          _buildCoinMarketItem(
            context,
            title: LocaleKeys.circulatingSupply.tr,
            value:
                "${info.circulatingSupply?.toDouble().shrinkTokenValue() ?? "0.00"} ${info.symbol ?? ""}",
          ),
          _buildCoinMarketItem(
            context,
            title: LocaleKeys.maxSupply.tr,
            value:
                "${info.maxSupply?.toDouble().shrinkTokenValue() ?? "0.00"} ${info.symbol ?? ""}",
          ),
          _buildCoinMarketItem(
            context,
            title: LocaleKeys.priceHigh.tr,
            value: info.high?.shrinkCurrencyAsFixed() ?? "--- \$",
          ),
          _buildCoinMarketItem(
            context,
            title: LocaleKeys.priceLow.tr,
            value: info.low?.shrinkCurrencyAsFixed() ?? "--- \$",
          ),
          _buildCoinMarketItem(
            context,
            title: LocaleKeys.priceOpen.tr,
            value: info.open?.shrinkCurrencyAsFixed() ?? "--- \$",
          ),
          _buildCoinMarketItem(
            context,
            title: LocaleKeys.priceClose.tr,
            value: info.close?.shrinkCurrencyAsFixed() ?? "--- \$",
          ),
          _buildCoinMarketItem(
            context,
            title: LocaleKeys.numberOfTrades.tr,
            value: info.numberOfTrades?.toString() ?? "--",
          ),
          _buildCoinMarketItem(
            context,
            title: LocaleKeys.quoteAssetVolume.tr,
            value: info.quoteAssetVolume?.shrinkCurrencyAsFixed() ?? "0.00 \$",
          ),
          _buildCoinMarketItem(
            context,
            title: LocaleKeys.openTime.tr,
            value: info.openTime?.jm ?? "--",
          ),
          _buildCoinMarketItem(
            context,
            title: LocaleKeys.closeTime.tr,
            value: info.closeTime != null ? "Tomorrow - ${info.closeTime?.jm}" : "--",
          ),
          _buildCoinMarketItem(
            context,
            title: LocaleKeys.marketDominance.tr,
            value: "${info.marketCapDominance?.toStringAsFixed(2) ?? "0.00"}%",
          ),
          _buildCoinMarketItem(
            context,
            title: LocaleKeys.fullyDiluted.tr,
            value: info.fullyDilutedMarketCap?.shrinkCurrencyAsFixed() ?? "0.00 \$",
          ),
        ],
      ),
    );
  }

  _buildCoinMarketItem(BuildContext context, {String? title, String? value}) {
    return Padding(
      padding: const .symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: .start,
        crossAxisAlignment: .center,
        mainAxisSize: .max,
        children: [
          Expanded(
            flex: 210,
            child: Text(
              title ?? "",
              style: context.appThemes.regular14.copyWith(color: context.appThemes.ink60),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 120,
            child: Text(
              value ?? "99,49B \$",
              style: context.appThemes.regular14.copyWith(color: context.appThemes.ink100),
              textAlign: .end,
            ),
          ),
        ],
      ),
    );
  }

  _buildYourAmount(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          Text(
            LocaleKeys.yourBalance.tr,
            style: context.appThemes.bold14.copyWith(color: context.appThemes.ink100),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: .start,
                  crossAxisAlignment: .start,
                  mainAxisSize: .max,
                  children: [
                    Stack(
                      alignment: .bottomRight,
                      children: [
                        Obx(
                          () => CachedNetworkImage(
                            width: 36,
                            height: 36,
                            imageUrl: controller.coinMarketInfo.value.logo ?? "",
                            fit: .cover,
                          ),
                        ),
                        Assets.images.icSolana.svg(width: 16, height: 16, fit: .cover),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Obx(
                      () => Text(
                        controller.coinMarketInfo.value.name ?? "",
                        style: context.appThemes.medium14.copyWith(
                          color: context.appThemes.ink100,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Obx(
                    () => Text(
                      "0.08 ${controller.coinMarketInfo.value.symbol ?? ""}",
                      style: context.appThemes.medium14.copyWith(color: context.appThemes.ink100),
                    ),
                  ),
                  Text(
                    "54.5552 \$",
                    style: context.appThemes.regular10.copyWith(color: context.appThemes.ink60),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildActionsLayouts(BuildContext context) {
    return Row(
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
    ).paddingSymmetric(horizontal: 50, vertical: 16);
  }
}
