// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/app/routes/app_pages.dart';
import 'package:d3_wallet/app/routes/navigation_arguments.dart';
import 'package:d3_wallet/base/base_controller.dart';
import 'package:d3_wallet/data/bean/app_configurations/app_configurations.dart';
import 'package:d3_wallet/data/repositories/app_configs_repository.dart';
import 'package:d3_wallet/utils/constants.dart';
import 'package:d3_wallet/utils/extensions/string_ext.dart';
import 'package:fimber/fimber.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class IntroController extends BaseController {
  dynamic arguments = Get.arguments;

  final isNewAddition = false.obs;
  final appConfigsRepository = Get.find<AppConfigsRepository>();
  late AppConfigurations? appConfigurations;

  @override
  void onInit() {
    super.onInit();
    Fimber.d("onInit()");
  }

  @override
  void onReady() {
    super.onReady();
    Fimber.d("onReady()");
    _loadAppConfig();
  }

  _loadAppConfig() async {
    Fimber.d("_loadAppConfig()");
    isNewAddition.value = (arguments as Map?)?[NavigationArguments.isNewAddition] ?? false;
    appConfigurations = await appConfigsRepository.retrieveAppConfigurations();
  }

  @override
  void onClose() {
    Fimber.d("onClose()");
    super.onClose();
  }

  void importWallet() {
    Fimber.d("importWallet()");
    if (appConfigurations?.localPasswords.isNotBlank() == true) {
      Get.toNamed(Routes.WALLET_IMPORT);
    } else {
      Get.toNamed(Routes.PASSWORD_CREATION, arguments: Constants.ignoreGenNewWallet);
    }
  }

  void createNewWallet() {
    Fimber.d("createNewWallet()");
    Get.toNamed(
      Routes.ONBOARD,
      arguments: {NavigationArguments.appConfigurations: appConfigurations},
    );
  }

  void updateConfig() {
    Fimber.d("updateConfig()");
    _loadAppConfig();
  }
}
