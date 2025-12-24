// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BaseController<T> extends GetxController with StateMixin<T> {
  final Object? constructorArgs;
  BaseController({this.constructorArgs});

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
    Fimber.d("retrieveArgument(key: $key)");

    // 1. Try constructor arguments first (most reliable for nested navigation)
    if (constructorArgs is Map && (constructorArgs as Map).containsKey(key)) {
      Fimber.d("Found in constructorArgs");
      return (constructorArgs as Map)[key] as A?;
    }

    // 2. Try global Get.arguments
    var args = Get.arguments;
    if (args is Map && args.containsKey(key)) {
      Fimber.d("Found in Get.arguments");
      return args[key] as A?;
    }

    // 3. Try Get.routing.args
    try {
      args = Get.routing.args;
      if (args is Map && args.containsKey(key)) {
        Fimber.d("Found in Get.routing.args");
        return args[key] as A?;
      }
    } catch (_) {}

    // 4. Try ModalRoute with Get.context
    // This handles cases where GetX hasn't updated its global state yet
    try {
      args = ModalRoute.of(Get.context!)?.settings.arguments;
      if (args is Map && args.containsKey(key)) {
        Fimber.d("Found in ModalRoute.of(Get.context!)");
        return args[key] as A?;
      }
    } catch (_) {}

    Fimber.w("Argument not found for key: $key");
    return null;
  }
}
