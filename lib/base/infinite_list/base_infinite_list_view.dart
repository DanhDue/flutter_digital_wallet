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
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';

abstract class BaseInfiniteListView<C extends BaseInfiniteListController> extends BaseView<C> {
  BaseInfiniteListView({super.key, BindingCreator? bindingCreator});

  bool? appBarIsHidden = false;

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
        body: Stack(
          children: [
            Visibility(
              visible: controller.hasNoData.value != true,
              child: Padding(
                padding: _evaluateTopPadding(context),
                child: RefreshIndicator(
                  key: controller.refreshIndicatorKey ?? GlobalKey(),
                  onRefresh: () => controller.fetchData(isRefresh: true),
                  child: GetBuilder<C>(
                    builder: (controller) => controller.items.isEmptyOrNull
                        ? const SizedBox.shrink()
                        : buildInfiniteList(),
                  ),
                ),
              ),
            ),
            Obx(() {
              return Visibility(
                visible: controller.isError.value?.isNotBlank == true,
                child: Center(child: buildErrorLayout(context)),
              );
            }),
            Obx(() {
              return Visibility(
                visible: controller.hasNoData.value == true,
                child: Padding(
                  padding: _evaluateNoDataPadding(context),
                  child: RefreshIndicator(
                    key: controller.refreshFromNoData ?? GlobalKey(),
                    onRefresh: () => controller.fetchData(isRefresh: true),
                    child: Stack(
                      children: [
                        Center(child: buildHasNoDataLayout(context)),
                        ListView(),
                      ],
                    ),
                  ),
                ),
              );
            }),
            Obx(() {
              if (controller.isLoading.value) {
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
    );
  }

  Widget buildInfiniteList() {
    return ListView.builder(
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
                    : const Padding(
                        padding: EdgeInsets.all(8),
                        child: CircularProgressIndicator(),
                      ),
              ),
            );
          } else {
            return controller.items.isNotEmpty
                ? const Center(
                    child: Padding(padding: EdgeInsets.all(8), child: CircularProgressIndicator()),
                  )
                : const SizedBox.shrink();
          }
        }
        return buildItemViews(context, item: controller.items[index], index: index);
      },
    );
  }

  Widget buildHasNoDataLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Assets.images.icHasNoData.image(width: 96, height: 96, fit: BoxFit.cover),
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
      ],
    );
  }

  Widget buildErrorLayout(BuildContext context) {
    return InkWell(
      onTap: () => controller.fetchData(isRefresh: true),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: AutoSizeText(
          LocaleKeys.loadDataErrorMessage.tr,
          style: context.appThemes.paragraphSemiBold.copyWith(color: context.appThemes.textGrey),
          textAlign: TextAlign.center,
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
    if (appBarIsHidden == true) return const EdgeInsets.only(top: 0);
    if (Navigator.canPop(context)) return const EdgeInsets.only(top: 146);
    return const EdgeInsets.only(top: 146);
  }

  EdgeInsets _evaluateNoDataPadding(BuildContext context) {
    if (appBarIsHidden == true) return const EdgeInsets.only(top: 0, bottom: 0);
    if (Navigator.canPop(context)) return const EdgeInsets.only(top: 96, bottom: 96);
    return const EdgeInsets.only(top: 96, bottom: 96);
  }
}
