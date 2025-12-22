// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/app/modules/comming_soon_modal/bindings/comming_soon_modal_binding.dart';
import 'package:d3_wallet/app/modules/comming_soon_modal/views/comming_soon_modal_view.dart';
import 'package:d3_wallet/app/routes/app_pages.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:dart_extensions/dart_extensions.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

mixin DialogMixin {
  var loadingDialogIsShown = false;

  void showLoadingDialog() {
    Fimber.d('showLoadingDialog()');
    if (loadingDialogIsShown) {
      Fimber.w('Loading dialog already shown, skipping...');
      return;
    }
    loadingDialogIsShown = true;
    try {
      Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
    } catch (e) {
      loadingDialogIsShown = false;
      Fimber.e('Failed to show loading dialog', ex: e);
      rethrow;
    }
  }

  void hideLoadingDialog() {
    Fimber.d("hideLoadingDialog()");
    if (loadingDialogIsShown) {
      loadingDialogIsShown = false;
      Get.back();
    }
  }

  void showErrorDialog({String? messageError}) {
    Get.dialog(
      AlertDialog(
        contentPadding: const EdgeInsets.all(20),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
        title: Text(
          LocaleKeys.titleDialog.tr,
          style: Get.context?.appThemes.h2.copyWith(color: Get.context?.appThemes.mainGreen),
        ),
        content: Text(
          messageError?.isEmptyOrNull == true ? LocaleKeys.commonErrorMessage.tr : messageError!,
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

  Future showWrapBottomSheet(
    BuildContext context,
    Widget widget, {
    RouteSettings? routeSettings,
  }) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: false,
      useRootNavigator: true,
      useSafeArea: false,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      ),
      builder:
          (context) => SingleChildScrollView(
            controller: ModalScrollController.of(context),
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Wrap(children: [widget]),
          ),
      routeSettings: routeSettings,
    );
  }

  void showCommingSoon(BuildContext context) async {
    showWrapBottomSheet(
      context,
      CommingSoonModalView(bindingCreator: () => CommingSoonModalBinding()),
      routeSettings: const RouteSettings(name: Routes.COMMING_SOON_MODAL),
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
