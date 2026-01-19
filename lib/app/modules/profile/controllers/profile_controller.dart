// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/app/modules/home/constants/nav_ids.dart';
import 'package:d3_wallet/app/routes/app_pages.dart';
import 'package:d3_wallet/base/base_controller.dart';
import 'package:fimber/fimber.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class ProfileController extends BaseController {
  @override
  void onInit() {
    super.onInit();
    Fimber.d("onInit()");
  }

  @override
  void onReady() {
    super.onReady();
    Fimber.d("onReady()");
  }

  @override
  void onClose() {
    super.onClose();
    Fimber.d("onClose()");
  }

  logout() {
    Fimber.d("logout()");
    Get.offAllNamed(Routes.LOGIN);
  }

  navigateToProfileDetail() {
    Fimber.d("navigateToProfileDetail()");
    Get.toNamed(Routes.PROFILE_DETAIL, id: NavIds.profile);
  }

  navigateToTalker() {
    Fimber.d("navigateToTalker()");
    Get.toNamed(Routes.TALKER);
  }
}
