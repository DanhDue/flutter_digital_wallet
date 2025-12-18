// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import 'base_controller.dart';
import 'base_view.dart';

abstract class BaseNetworkingView<C extends BaseController> extends BaseView<C> {
  BaseNetworkingView({super.key});

  @override
  Widget onCreateViews(BuildContext context) {
    return controller.obx(
      (state) {
        onLoadingStatusChange(false);
        return buildBody(context, state);
      },
      onLoading: Builder(
        builder: (context) {
          onLoadingStatusChange(true);
          return Scaffold(body: buildLoading(context) ?? const SizedBox.shrink());
        },
      ),
      onError: (error) {
        onLoadingStatusChange(false);
        if (controller.state != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            SmartDialog.showToast(error ?? '');
          });
          return buildBody(context, controller.state);
        } else {
          return buildError(context, error);
        }
      },
      onEmpty: buildEmpty(context),
    );
  }

  @protected
  Widget buildBody(BuildContext context, dynamic state);

  /// Called when the loading layouts is created.
  ///
  /// Sample to show the CircularProgressIndicator:
  /// ```dart
  /// @override
  /// Widget? buildLoading(BuildContext context) => const Center(child: CircularProgressIndicator());
  /// ```
  @protected
  Widget? buildLoading(BuildContext context) => const SizedBox.shrink();

  @protected
  Widget buildError(BuildContext context, String? error) {
    return Center(
      child: Text(error ?? 'An error occurred', style: const TextStyle(color: Colors.red)),
    );
  }

  @protected
  Widget buildEmpty(BuildContext context) {
    return const Center(child: Text('No data available'));
  }

  /// Called when the loading status changes.
  /// Override this method to show/hide SmartDialog or other loading indicators.
  ///
  /// [isLoading] - true when loading starts, false when loading ends
  ///
  /// Sample to show the SmartDialog:
  /// ```dart
  /// 1. Create a boolean variable to track the loading state
  /// bool isLoadingShown = false;
  ///
  /// 2. Override the onLoadingStatusChange method
  /// @override
  /// void onLoadingStatusChange(bool isLoading) {
  ///   WidgetsBinding.instance.addPostFrameCallback((_) {
  ///     if (isLoading) {
  ///       if (!isLoadingShown) {
  ///         isLoadingShown = true;
  ///         Fimber.d("onLoadingStatusChange(isLoading: $isLoading)");
  ///         SmartDialog.showLoading(msg: "");
  ///       }
  ///     } else {
  ///       isLoadingShown = false;
  ///       Fimber.d("onLoadingStatusChange(isLoading: $isLoading)");
  ///       SmartDialog.dismiss();
  ///     }
  ///   });
  /// }
  /// ```
  @protected
  Future<void> onLoadingStatusChange(bool isLoading) async {
    // Default implementation does nothing
    // Override in subclass to call SmartDialog.showLoading() / SmartDialog.dismiss()
  }
}
