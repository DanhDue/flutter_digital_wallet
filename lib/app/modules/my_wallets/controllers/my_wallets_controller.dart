// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'dart:convert';

import 'package:d3_wallet/base/base_controller.dart';
import 'package:d3_wallet/data/bean/app_configurations/app_configurations.dart';
import 'package:d3_wallet/data/bean/response/network_object/network_object.dart';
import 'package:d3_wallet/data/bean/response/token_account_object/token_account_object.dart';
import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:d3_wallet/data/repositories/app_configs_repository.dart';
import 'package:d3_wallet/data/repositories/token_repository.dart';
import 'package:d3_wallet/data/repositories/wallet_repository.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/utils/constants.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class MyWalletsController extends BaseController {
  final appConfigsRepository = Get.find<AppConfigsRepository>();
  final walletRepo = Get.find<WalletRepository>();
  final tokenRepo = Get.find<TokenRepository>();
  late AppConfigurations? appConfigurations;
  final selectedWallet = WalletResponseObject().obs;
  final shouldBeShownSCRReminder = false.obs;
  var remindLater = false;
  final selectedNetwork =
      NetworkObject(
        id: NetworkIds.SOLANA,
        name: "DevNet",
        logo: "https://s2.coinmarketcap.com/static/img/coins/200x200/5426.png",
      ).obs;

  final RxList<WalletResponseObject?> wallets = <WalletResponseObject?>[].obs;

  final RxList<TokenAccountObject?> tokens = <TokenAccountObject?>[].obs;

  final fullBalance = 0.0.obs;
  final balanceIsHidden = false.obs;
  @override
  void onInit() {
    super.onInit();
    Fimber.d("onInit()");
  }

  @override
  void onReady() async {
    super.onReady();
    Fimber.d("onReady()");
    try {
      wallets.value = await walletRepo.retrieveYourWallets() ?? [];
      selectedWallet.value = wallets.value.firstOrNull ?? WalletResponseObject();
    } catch (e) {
      Fimber.e("Error retrieving wallets", ex: e);
      wallets.value = [];
      selectedWallet.value = WalletResponseObject();
    } finally {
      isLoading.value = false;
    }
    // Mock wallet data for testing - Generate 20 wallets
    _loadTestWallets();
  }

  @override
  void onClose() {
    super.onClose();
    Fimber.d("MyWalletsController onClose - cleaning up all wallet card controllers");
    cleanupAllWalletCardControllers();
  }

  _loadTestWallets() async {
    final data = await rootBundle.loadString(Assets.jsons.testWallets);
    final walletsJson = json.decode(data);
    if (walletsJson is List) {
      wallets.addAll(
        walletsJson.map((element) => WalletResponseObject.fromJson(element)).toList(),
      );
    }
    selectedWallet.value = wallets.value.firstOrNull ?? WalletResponseObject();
    wallets.refresh();
  }

  /// Clean up all wallet card controllers
  void cleanupAllWalletCardControllers() {
    for (var wallet in wallets) {
      if (wallet != null) {
        final tag = GetXControllerTags.walletCard(wallet.address);
        if (Get.isRegistered<dynamic>(tag: tag)) {
          Get.delete(tag: tag);
          Fimber.d("Deleted controller for wallet with tag: $tag");
        }
      }
    }
  }

  /// Clean up controller for a specific wallet (e.g., when wallet is deleted)
  void cleanupWalletCardController(String? walletAddress) {
    if (walletAddress == null) return;
    final tag = GetXControllerTags.walletCard(walletAddress);
    if (Get.isRegistered<dynamic>(tag: tag)) {
      Get.delete(tag: tag);
      Fimber.d("Deleted controller for removed wallet with tag: $tag");
    }
  }

  /// This method is called when a wallet is removed
  void removeWallet(WalletResponseObject wallet) {
    final wasRemoved = wallets.remove(wallet);
    if (wasRemoved && selectedWallet.value == wallet) {
      // Set to first available wallet or empty object
      selectedWallet.value = wallets.firstOrNull ?? WalletResponseObject();
    }
    cleanupWalletCardController(wallet.address);
  }

  void backupIsDone() {}

  void updateSelectedNetwork(NetworkObject selectedNetworkValue) {}

  void hideBalance() {}

  void updateSelectedWallet(WalletResponseObject? reversedWallet) {
    selectedWallet.value = reversedWallet ?? WalletResponseObject();
  }
}
