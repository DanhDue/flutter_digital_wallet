// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/base/base_view.dart';
import 'package:d3_wallet/base/binding_creator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import 'base_controller.dart';

abstract class BaseBindingCreatorView<Binding extends Bindings, T extends BaseController>
    extends BaseView<T> {
  final BindingCreator<Binding>? bindingCreator;

  bool bindingCreatorIsCreated = false;

  BaseBindingCreatorView({super.key, this.bindingCreator});

  @override
  Widget? onCreateViews(BuildContext context);

  @override
  @nonVirtual
  Widget build(BuildContext context) {
    _createBinding();
    return GestureDetector(
      onTap: () {
        // call this method here to hide soft keyboard
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: onCreateViews(context) ?? const SizedBox.shrink(),
    );
  }

  void _createBinding() {
    if (bindingCreatorIsCreated) return;
    bindingCreatorIsCreated = true;
    Binding? binding = bindingCreator?.call();
    binding?.dependencies();
  }
}
