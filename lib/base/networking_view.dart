// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'base_controller.dart';
import 'base_networking_view.dart';

/// A base view that extends [BaseNetworkingView] and automatically shows/hides
/// a loading dialog using [SmartDialog] when the loading state changes.
///
/// This eliminates the need to manually override [onLoadingStatusChange] in
/// each view that requires a loading indicator.
///
/// Usage:
/// ```dart
/// class MyView extends BaseSmartDialogView<MyController> {
///   MyView({super.key});
///
///   @override
///   Widget buildBody(BuildContext context, state) {
///     return YourWidget();
///   }
/// }
/// ```
abstract class NetworkingView<C extends BaseController> extends BaseNetworkingView<C> {
  NetworkingView({super.key});

  bool _isLoadingShown = false;

  /// Override this to customize the loading message.
  /// Returns an empty string by default for a clean loading spinner.
  @protected
  String get loadingMessage => '';

  /// Override this to control whether the loading can be dismissed by tapping the mask.
  @protected
  bool get clickMaskDismiss => false;

  /// Override this to control whether the loading dialog is shown.
  /// This is useful for cases where you want to conditionally show the loading dialog.
  @protected
  bool get shouldBeShowLoadingDialog => true;

  @override
  void onLoadingStatusChange(bool isLoading) {
    if (!shouldBeShowLoadingDialog) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isLoading) {
        if (!_isLoadingShown) {
          _isLoadingShown = true;
          Fimber.d("onLoadingStatusChange(isLoading: $isLoading)");
          SmartDialog.showLoading(msg: loadingMessage, clickMaskDismiss: clickMaskDismiss);
        }
      } else {
        if (_isLoadingShown) {
          _isLoadingShown = false;
          Fimber.d("onLoadingStatusChange(isLoading: $isLoading)");
          SmartDialog.dismiss();
        }
      }
    });
  }
}
