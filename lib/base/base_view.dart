// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:dart_extensions/dart_extensions.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import 'base_controller.dart';

abstract class BaseView<C extends BaseController> extends GetView<C> {
  BaseView({super.key});

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
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: onCreateViews(context),
          ),
        ),
        Obx(() {
          if (controller.isLoading.value == true) {
            WidgetsBinding.instance.addPostFrameCallback((duration) {
              SmartDialog.showLoading(msg: "");
              // EasyLoading.show();
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
    );
  }

  onHideKeyboard() {
    // call this method here to hide soft keyboard
    FocusManager.instance.primaryFocus?.unfocus();
  }

  var loadingDialogIsShown = false;

  void showLoadingDialog() {
    Fimber.d('showLoadingDialog()');
    loadingDialogIsShown = true;
    Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
  }

  void hideLoadingDialog() {
    Fimber.d("hideLoadingDialog()");
    if (loadingDialogIsShown) {
      loadingDialogIsShown = false;
      Get.back();
    }
  }

  void showErrorDialog(BuildContext context, {String? messageError}) {
    Get.dialog(
      AlertDialog(
        contentPadding: const EdgeInsets.all(20),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
        title: Text(
          LocaleKeys.titleDialog.tr,
          style: Get.context?.appThemes.h2.copyWith(color: Get.context?.appThemes.mainGreen),
        ),
        content: Text(
          messageError?.isEmptyOrNull == true
              ? LocaleKeys.commonErrorMessage.tr
              : messageError ?? '',
          style: Get.context?.appThemes.paragraph.copyWith(color: Get.context?.appThemes.black),
        ),
        actions: [
          TextButton(
            style: ElevatedButton.styleFrom(splashFactory: NoSplash.splashFactory),
            child: Text(
              LocaleKeys.close.tr,
              style: Get.context?.appThemes.paragraphSemiBold.copyWith(
                color: Get.context?.appThemes.mainGreen,
              ),
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  showWrapBottomSheet(BuildContext context, Widget widget, {RouteSettings? routeSettings}) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: false,
      useRootNavigator: true,
      useSafeArea: false,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
      builder: (context) => Wrap(children: [widget]),
      routeSettings: routeSettings,
    );
  }

  void showAlertDialog(
    BuildContext context, {
    String? title,
    String? message,
    Function? onAction,
    String? actionTitle,
  }) {
    Get.dialog(
      AlertDialog(
        contentPadding: const EdgeInsets.all(20),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
        title: Text(
          title ?? '',
          style: Get.context?.appThemes.h2.copyWith(color: Get.context?.appThemes.mainGreen),
        ),
        content: Text(
          message ?? '',
          style: Get.context?.appThemes.paragraph.copyWith(color: Get.context?.appThemes.black),
        ),
        actions: [
          TextButton(
            style: ElevatedButton.styleFrom(
              splashFactory: NoSplash.splashFactory,
              backgroundColor: context.appThemes.transparent,
            ),
            child: Text(
              actionTitle ?? LocaleKeys.close.tr,
              style: Get.context?.appThemes.paragraphSemiBold.copyWith(
                color: Get.context?.appThemes.mainGreen,
              ),
            ),
            onPressed: () {
              Get.back();
              onAction?.call();
            },
          ),
        ],
      ),
    );
  }
}
