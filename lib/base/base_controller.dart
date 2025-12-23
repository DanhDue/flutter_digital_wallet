// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BaseController<T> extends GetxController with StateMixin<T> {
  var isLoading = false.obs;
  Rx<String?> isError = ''.obs;
  var hasNoData = false.obs;
  Rx<String?> showMessage = ''.obs;

  @override
  void dispose() {
    super.dispose();
    Fimber.d('BaseController disposed');
  }

  // change state to null if you want to show init state.
  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.success());
  }

  void showAlertDialog(String title, String message, Function onAction) {
    Get.dialog(
      AlertDialog(
        contentPadding: const .all(20),
        shape: const RoundedRectangleBorder(borderRadius: .all(.circular(15))),
        title: Text(
          title,
          style: Get.context?.appThemes.h2.copyWith(color: Get.context?.appThemes.mainGreen),
        ),
        content: Text(
          message,
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
              onAction.call();
            },
          ),
        ],
      ),
    );
  }

  A? retrieveArgument<A>(String key) {
    return (Get.arguments as Map?)?[key] as A?;
  }
}
