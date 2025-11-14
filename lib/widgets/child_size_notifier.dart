// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:flutter/material.dart';

class ChildSizeNotifier extends StatefulWidget {
  final Widget child;
  final ValueChanged<Size> onSizeChanged;

  const ChildSizeNotifier({super.key, required this.child, required this.onSizeChanged});

  @override
  _ChildSizeNotifierState createState() => _ChildSizeNotifierState();
}

class _ChildSizeNotifierState extends State<ChildSizeNotifier> {
  final GlobalKey _key = GlobalKey();
  Size? _oldSize;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
  }

  @override
  void didUpdateWidget(covariant ChildSizeNotifier oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
  }

  void _notifySize() {
    final context = _key.currentContext;
    if (context == null) return;
    final newSize = context.size;
    if (newSize != null && newSize != _oldSize) {
      _oldSize = newSize;
      widget.onSizeChanged(newSize);
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
    return Container(key: _key, child: widget.child);
  }
}
