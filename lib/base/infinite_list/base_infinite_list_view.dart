// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:auto_size_text/auto_size_text.dart';
import 'package:d3_wallet/base/base_view.dart';
import 'package:d3_wallet/base/binding_creator.dart';
import 'package:d3_wallet/base/infinite_list/base_infinite_list_controller.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:dart_extensions/dart_extensions.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

abstract class BaseInfiniteListView<C extends BaseInfiniteListController> extends BaseView<C> {
  const BaseInfiniteListView({
    super.key,
    BindingCreator? bindingCreator,
    this.appBarIsHidden = true,
    this.topSafeArea = true,
    this.bottomSafeArea = false,
    this.leftSafeArea = false,
    this.rightSafeArea = false,
  });

  final bool appBarIsHidden;
  final bool topSafeArea;
  final bool bottomSafeArea;
  final bool leftSafeArea;
  final bool rightSafeArea;

  @override
  Widget? onCreateViews(BuildContext context) {
    return FocusDetector(
      onFocusLost: () {
        Fimber.d("FocusDetector - onFocusLost: ${DateTime.now()}");
      },
      onFocusGained: () {
        Fimber.d("FocusDetector - onFocusGained: ${DateTime.now()}");
      },
      onVisibilityLost: () {
        Fimber.d("FocusDetector - onVisibilityLost: ${DateTime.now()}");
        controller.isLoading.value = false;
      },
      onVisibilityGained: () {
        Fimber.d("FocusDetector - onVisibilityGained: ${DateTime.now()}");
      },
      onForegroundLost: () {
        Fimber.d("FocusDetector - onForegroundLost: ${DateTime.now()}");
      },
      onForegroundGained: () {
        Fimber.d("FocusDetector - onForegroundGained: ${DateTime.now()}");
      },
      child: Scaffold(
        body: SafeArea(
          top: topSafeArea,
          bottom: bottomSafeArea,
          left: leftSafeArea,
          right: rightSafeArea,
          child: Stack(
            children: [
              Obx(
                () => Visibility(
                  visible: controller.hasNoData.value != true,
                  child: Padding(
                    padding: _evaluateTopPadding(context),
                    child: RefreshIndicator(
                      key: controller.refreshIndicatorKey,
                      onRefresh: () =>
                          controller.fetchData(isRefresh: true, ignoreShowLoading: true),
                      child: GetBuilder<C>(
                        builder: (controller) => controller.items.isEmptyOrNull
                            ? const SizedBox.shrink()
                            : buildInfiniteList(),
                      ),
                    ),
                  ),
                ),
              ),
              Obx(() {
                return Visibility(
                  visible: controller.isError.value?.isNotBlank == true,
                  child: RefreshIndicator(
                    onRefresh: () =>
                        controller.fetchData(isRefresh: true, ignoreShowLoading: true),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height:
                            MediaQuery.of(context).size.height -
                            _evaluateNoDataPadding(context).vertical,
                        child: buildErrorLayout(context),
                      ),
                    ),
                  ),
                );
              }),
              Obx(() {
                return Visibility(
                  visible: controller.hasNoData.value == true,
                  child: RefreshIndicator(
                    key: controller.refreshFromNoData,
                    onRefresh: () =>
                        controller.fetchData(isRefresh: true, ignoreShowLoading: true),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height:
                            MediaQuery.of(context).size.height -
                            _evaluateNoDataPadding(context).vertical,
                        child: Padding(
                          padding: _evaluateNoDataPadding(context),
                          child: Stack(children: [Center(child: buildHasNoDataLayout(context))]),
                        ),
                      ),
                    ),
                  ),
                );
              }),
              Obx(() {
                return Visibility(
                  visible: controller.isLoading.value == true,
                  child: Center(
                    child: RepaintBoundary(
                      child: Assets.lotties.sandyLoading.lottie(
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                        animate: true,
                        repeat: true,
                        backgroundLoading: true,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfiniteList() {
    return ListView.builder(
      controller: controller.scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: controller.items.length + (controller.hasMore == true ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == controller.items.length - (controller.nextPageThreshold) &&
            controller.hasMore == true) {
          controller.fetchData();
        }
        if (index == controller.items.length) {
          if (controller.loadMoreError == true) {
            return Center(
              child: InkWell(
                onTap: () => controller.fetchData(isLoadMore: true),
                child: controller.loadMoreError == true
                    ? buildErrorItemWhileLoadMore()
                    : Padding(
                        padding: const .symmetric(vertical: 20),
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: context.appThemes.trueBlue,
                          size: 36,
                        ),
                      ),
              ),
            );
          } else {
            return controller.items.isNotEmpty
                ? Center(
                    child: Padding(
                      padding: const .symmetric(vertical: 20),
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: context.appThemes.trueBlue,
                        size: 36,
                      ),
                    ),
                  )
                : const SizedBox.shrink();
          }
        }
        return buildItemViews(context, item: controller.items[index], index: index);
      },
    );
  }

  Widget buildHasNoDataLayout(BuildContext context) {
    return InkWell(
      onTap: () => controller.fetchData(isRefresh: true),
      child: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        mainAxisSize: .max,
        children: [
          Assets.images.icHasNoData.image(width: 96, height: 96, fit: .cover),
          const SizedBox(height: 12),
          Text(
            LocaleKeys.oops.tr,
            style: context.appThemes.h1.copyWith(color: context.appThemes.black),
          ),
          const SizedBox(height: 8),
          Text(
            LocaleKeys.noDataMessage.tr,
            style: context.appThemes.h3.copyWith(color: context.appThemes.textGrey),
          ),
          const SizedBox(height: 96),
        ],
      ),
    );
  }

  Widget buildErrorLayout(BuildContext context) {
    return InkWell(
      onTap: () => controller.fetchData(isRefresh: true),
      child: Center(
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          mainAxisSize: .min,
          children: [
            AutoSizeText(
              LocaleKeys.loadDataErrorMessage.tr,
              style: context.appThemes.paragraphSemiBold.copyWith(
                color: context.appThemes.textGrey,
              ),
              textAlign: .center,
            ),
            const SizedBox(height: 96),
          ],
        ),
      ),
    );
  }

  Widget buildErrorItemWhileLoadMore() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(LocaleKeys.loadDataErrorMessage.tr),
    );
  }

  Widget buildItemViews(BuildContext context, {dynamic item, int? index});

  EdgeInsets _evaluateTopPadding(BuildContext context) {
    if (appBarIsHidden == true) return const .only(top: 0);
    if (Navigator.canPop(context)) return const .only(top: 146);
    return const .only(top: 146);
  }

  EdgeInsets _evaluateNoDataPadding(BuildContext context) {
    if (appBarIsHidden == true) return const .only(top: 0, bottom: 0);
    if (Navigator.canPop(context)) return const .only(top: 96, bottom: 96);
    return const .only(top: 96, bottom: 96);
  }
}
