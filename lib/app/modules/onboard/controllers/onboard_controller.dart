// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/app/routes/app_pages.dart';
import 'package:d3_wallet/app/routes/navigation_arguments.dart';
import 'package:d3_wallet/base/base_controller.dart';
import 'package:d3_wallet/base/networking_mixin.dart';
import 'package:d3_wallet/data/bean/app_configurations/app_configurations.dart';
import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:d3_wallet/data/repositories/wallet_repository.dart';
import 'package:dart_extensions/dart_extensions.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_utils/src/extensions/num_extensions.dart';
import 'package:get/route_manager.dart';

class OnboardController extends BaseController with NetworkingMixin {
  late AppConfigurations? appConfigurations;
  final passwordIsCreated = false.obs;
  final shouldBeConfirmMnemonic = false.obs;
  final mnemonicIsVerified = false.obs;
  final currentPage = 0.obs;

  late final Rx<WalletResponseObject?> wallet = WalletResponseObject().obs;

  final walletRepo = Get.find<WalletRepository>();

  final passwordAndWalletIsCreated = false.obs;

  @override
  void onInit() {
    super.onInit();
    Fimber.d("onInit()");
    appConfigurations = retrieveArgument<AppConfigurations>(NavigationArguments.appConfigurations);
  }

  @override
  void onReady() {
    super.onReady();
    Fimber.d("onReady()");
    if (appConfigurations != null) {
      updateCreatedAppConfigurations(appConfigurations);
      jumpToPage(OnboardPageIndex.secureWalletPageIndex);
    }
  }

  @override
  void onClose() {
    super.onClose();
    Fimber.d("onClose()");
  }

  void updateCreatedAppConfigurations(AppConfigurations? appConfigurations) {
    this.appConfigurations = appConfigurations ?? AppConfigurations();
    passwordIsCreated.value = true;
  }

  mnemonicIsGenereated() {
    shouldBeConfirmMnemonic.value = true;
  }

  createWalletAndSaveAppConfigurations({bool? toHome = false}) async {
    callApi(
      walletRepo.createOrRestoreWallet(),
      onSuccess: (result) async {
        wallet.value = result?.data;
        if (toHome == true) {
          await updateWallets();
          Get.offAllNamed(Routes.HOME);
        } else {
          jumpToPage(OnboardPageIndex.mnemonicCreationPageIndex);
        }
      },
      onError: (error) {
        Fimber.e(error.toString());
        SmartDialog.showToast(error.toString());
      },
      loadingType: LoadingType.overlay,
    );
  }

  void updateMnemonicIsVerified(bool isVerified) {
    mnemonicIsVerified.value = isVerified;
  }

  void jumpToPage(int i) {
    currentPage.value = i;
  }

  Future<void> updateWallets() async {
    final yourWallets = await walletRepo.retrieveYourWallets();
    if (yourWallets == null) {
      await walletRepo.updateYourWallets([wallet.value]);
      return;
    }
    final oldWallet = yourWallets?.firstOrNullWhere(
      (item) => item?.address == wallet.value?.address,
    );
    if (oldWallet != null) {
      final oldWalletIndex = yourWallets.indexOf(oldWallet);
      if (oldWalletIndex.isGreaterThan(-1) == true) {
        yourWallets.removeAt(oldWalletIndex);
        yourWallets.insert(
          oldWalletIndex,
          oldWallet.copyWith(scrIsBackedUp: true, scrBackupReminderIsShown: true),
        );
        await walletRepo.updateYourWallets(yourWallets);
      }
    } else {
      yourWallets.add(wallet.value);
      await walletRepo.updateYourWallets(yourWallets);
    }
  }
}

class OnboardPageIndex {
  static const int passwordCreationPageIndex = 0;
  static const int secureWalletPageIndex = 1;
  static const int mnemonicDescriptionPageIndex = 2;
  static const int mnemonicCreationPageIndex = 3;
  static const int mnemonicConfirmationPageIndex = 4;
}
