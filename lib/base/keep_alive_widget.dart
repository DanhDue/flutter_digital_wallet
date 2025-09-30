// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/base/binding_creator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KeepAliveWidget extends StatefulWidget {
  const KeepAliveWidget({
    super.key,
    @required this.child,
    this.safeAreaLeft = false,
    this.safeAreaTop = false,
    this.safeAreaRight = false,
    this.safeAreaBottom = false,
    required this.bindingCreator,
  });

  final Widget? child;
  final bool? safeAreaLeft;
  final bool? safeAreaTop;
  final bool? safeAreaRight;
  final bool? safeAreaBottom;

  final BindingCreator<Bindings>? bindingCreator;

  @override
  _KeepAliveWidgetState createState() => _KeepAliveWidgetState();
}

class _KeepAliveWidgetState extends State<KeepAliveWidget> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    _createBinding();
    return SafeArea(
      left: widget.safeAreaLeft ?? false,
      top: widget.safeAreaTop ?? false,
      right: widget.safeAreaBottom ?? false,
      bottom: widget.safeAreaBottom ?? false,
      child: widget.child ?? Container(),
    );
  }

  void _createBinding() {
    Bindings? binding = widget.bindingCreator?.call();
    binding?.dependencies();
  }

  @override
  bool get wantKeepAlive => true;
}
