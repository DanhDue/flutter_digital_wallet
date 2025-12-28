// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import 'base_controller.dart';

abstract class BaseView<C extends BaseController> extends GetView<C> {
  const BaseView({super.key});

  @protected
  Widget? onCreateViews(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            onHideKeyboard();
          },
          child: SizedBox(width: .infinity, height: .infinity, child: onCreateViews(context)),
        ),
        Obx(() {
          if (controller.isLoading.value == true) {
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
    );
  }

  onHideKeyboard() {
    // call this method here to hide soft keyboard
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
