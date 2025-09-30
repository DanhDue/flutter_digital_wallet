// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/base/binding_creator.dart';
import 'package:d3_wallet/base/infinite_list/base_infinite_list_controller.dart';
import 'package:d3_wallet/base/infinite_list/base_infinite_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

abstract class BaseInfiniteListViewWithCreator<
  Binding extends Bindings,
  C extends BaseInfiniteListController
>
    extends BaseInfiniteListView<C> {
  final BindingCreator<Binding>? bindingCreator;

  BaseInfiniteListViewWithCreator({super.key, required this.bindingCreator})
    : super(bindingCreator: bindingCreator);

  @override
  Widget build(BuildContext context) {
    _createBinding();
    return super.build(context);
  }

  void _createBinding() {
    Binding? binding = bindingCreator?.call();
    binding?.dependencies();
  }
}
