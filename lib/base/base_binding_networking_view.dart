// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/base/base_controller.dart';
import 'package:d3_wallet/base/base_networking_view.dart';
import 'package:d3_wallet/base/binding_creator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A base view that combines networking capabilities with binding creator pattern.
///
/// This class extends [BaseNetworkingView] and adds support for creating bindings
/// on demand, similar to [BaseBindingCreatorView].
///
/// Usage:
/// ```dart
/// class MyView extends BaseBindingNetworkingView<MyBinding, MyController> {
///   MyView({super.key, required super.bindingCreator});
///
///   @override
///   Widget buildBody(BuildContext context, state) {
///     return Container();
///   }
/// }
/// ```
abstract class BaseBindingNetworkingView<Binding extends Bindings, C extends BaseController>
    extends BaseNetworkingView<C> {
  final BindingCreator<Binding>? bindingCreator;

  bool bindingCreatorIsCreated = false;

  BaseBindingNetworkingView({super.key, this.bindingCreator});

  @override
  @nonVirtual
  Widget onCreateViews(BuildContext context) {
    _createBinding();
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // call this method here to hide soft keyboard
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: super.onCreateViews(context),
    );
  }

  void _createBinding() {
    if (bindingCreatorIsCreated) return;
    bindingCreatorIsCreated = true;
    Binding? binding = bindingCreator?.call();
    binding?.dependencies();
  }
}
