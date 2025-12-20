// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/base/base_controller.dart';
import 'package:d3_wallet/base/binding_creator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

/// A StatefulWidget base view that combines networking capabilities with binding creator pattern.
///
/// This class properly separates lifecycle logic from rendering logic:
/// - Lifecycle methods (initState, didUpdateWidget) trigger data fetching
/// - Rendering methods (buildBody, buildLoading, etc.) only display UI
///
/// Usage:
/// ```dart
/// class MyView extends BaseBindingStatefulNetworkingView<MyBinding, MyController> {
///   MyView({super.key, this.selectedWallet});
///
///   final Wallet? selectedWallet;
///
///   @override
///   BindingCreator<MyBinding> get bindingCreator => () => MyBinding();
///
///   @override
///   void onLoadData() {
///     controller.fetchData(selectedWallet);
///   }
///
///   @override
///   Widget buildBody(BuildContext context, state) {
///     return ListView(...);
///   }
/// }
/// ```
abstract class BaseBindingStatefulNetworkingView<
  Binding extends Bindings,
  C extends BaseController
>
    extends StatefulWidget {
  const BaseBindingStatefulNetworkingView({super.key});

  /// Override this to provide the binding creator
  BindingCreator<Binding>? get bindingCreator;

  /// Called when data needs to be loaded or reloaded.
  /// This is called in:
  /// - initState() - for initial load
  /// - didUpdateWidget() - when widget properties change
  ///
  /// [controller] The controller instance to use for data fetching
  void onLoadData(C controller);

  /// Build the main content when data is successfully loaded
  @protected
  Widget buildBody(BuildContext context, dynamic state);

  /// Build the loading indicator
  @protected
  Widget? buildLoading(BuildContext context) => const SizedBox.shrink();

  /// Build the error view
  @protected
  Widget buildError(BuildContext context, String? error) {
    return Center(
      child: Text(error ?? 'An error occurred', style: const TextStyle(color: Colors.red)),
    );
  }

  /// Build the empty state view
  @protected
  Widget buildEmpty(BuildContext context) {
    return const Center(child: Text('No data available'));
  }

  /// Called when the loading status changes
  @protected
  Future<void> onLoadingStatusChange(bool isLoading) async {
    // Default implementation does nothing
    // Override in subclass to call SmartDialog.showLoading() / SmartDialog.dismiss()
  }

  @override
  State<BaseBindingStatefulNetworkingView<Binding, C>> createState() =>
      _BaseBindingStatefulNetworkingViewState<Binding, C>();
}

class _BaseBindingStatefulNetworkingViewState<Binding extends Bindings, C extends BaseController>
    extends State<BaseBindingStatefulNetworkingView<Binding, C>> {
  bool _bindingCreated = false;
  late C _controller;

  @override
  void initState() {
    super.initState();
    _createBinding();
    _controller = Get.find<C>();

    // Trigger initial data load in post-frame callback to ensure widget is mounted
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        widget.onLoadData(_controller);
      }
    });
  }

  @override
  void didUpdateWidget(covariant BaseBindingStatefulNetworkingView<Binding, C> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Check if we need to reload data when widget updates
    // Subclasses can override shouldReloadData() to customize this behavior
    if (shouldReloadData(oldWidget)) {
      widget.onLoadData(_controller);
    }
  }

  /// Override this in subclass to determine when to reload data on widget update
  /// By default, always reload when widget updates
  bool shouldReloadData(covariant BaseBindingStatefulNetworkingView<Binding, C> oldWidget) {
    return true;
  }

  void _createBinding() {
    if (_bindingCreated) return;
    _bindingCreated = true;
    Binding? binding = widget.bindingCreator?.call();
    binding?.dependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // Hide soft keyboard
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: _controller.obx(
        (state) {
          widget.onLoadingStatusChange(false);
          return widget.buildBody(context, state);
        },
        onLoading: Builder(
          builder: (context) {
            widget.onLoadingStatusChange(true);
            return Scaffold(body: widget.buildLoading(context) ?? const SizedBox.shrink());
          },
        ),
        onError: (error) {
          widget.onLoadingStatusChange(false);
          if (_controller.state != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              SmartDialog.showToast(error ?? '');
            });
            return widget.buildBody(context, _controller.state);
          } else {
            return widget.buildError(context, error);
          }
        },
        onEmpty: widget.buildEmpty(context),
      ),
    );
  }
}
