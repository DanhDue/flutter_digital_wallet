// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/base/dialog_mixin.dart';
import 'package:d3_wallet/base/base_view.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:dart_extensions/dart_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import '../../../generated/assets.gen.dart';
import 'base_controller.dart';

abstract class BaseAppBarView<C extends BaseController> extends BaseView<C> with DialogMixin {
  BaseAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // call this method here to hide soft keyboard
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Container(
          color: context.appThemes.background,
          child: Column(
            children: [
              const SizedBox(height: 35),
              isAppBarSupported
                  ? Container(
                    color: context.appThemes.background,
                    child: Row(
                      children: [
                        isBackButtonShown
                            ? IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: Assets.images.icFingerScan.svg(width: 24, height: 24),
                            )
                            : const SizedBox(width: 24, height: 24),
                        const SizedBox(width: 3),
                        Expanded(child: expandAppBarWidget(context) ?? Container()),
                        const SizedBox(width: 3),
                        if (actionAppBar(context)?.isNotEmpty == true) ...{
                          Row(children: actionAppBar(context) ?? []),
                        } else ...{
                          const SizedBox(width: 30),
                        },
                      ],
                    ),
                  )
                  : Container(),
              const SizedBox(height: 4),
              titleAppBar?.isNotEmpty == true
                  ? Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        titleAppBar!,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style: context.appThemes.headline.copyWith(
                          color: context.appThemes.mainGreen,
                        ),
                      ),
                    ),
                  )
                  : const SizedBox(),
              const SizedBox(height: 12),
              Expanded(child: child(context)),
              Obx(() {
                if (controller.isError.value?.isNotBlank == true) {
                  String message = controller.isError.value.toString();
                  WidgetsBinding.instance.addPostFrameCallback((duration) {
                    showErrorDialog(messageError: message);
                  });
                  controller.isError.value = "";
                }
                return const SizedBox.shrink();
              }),
              Obx(() {
                if (controller.isLoading.value == true) {
                  WidgetsBinding.instance.addPostFrameCallback((duration) {
                    // EasyLoading.show(dismissOnTap: false);
                    SmartDialog.showLoading(msg: "");
                  });
                } else {
                  WidgetsBinding.instance.addPostFrameCallback((duration) {
                    // EasyLoading.dismiss();
                    SmartDialog.dismiss();
                  });
                }
                return const SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget? expandAppBarWidget(BuildContext context) => null;

  bool get isAppBarSupported => true;

  bool get isBackButtonShown => true;

  Widget child(BuildContext context) => const SizedBox.shrink();

  List<Widget>? actionAppBar(BuildContext context) => null;

  String? get titleAppBar => null;
}
