// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/base/base_controller.dart';
import 'package:d3_wallet/data/bean/app_configurations/app_configurations.dart';
import 'package:d3_wallet/data/bean/response/network_object/network_object.dart';
import 'package:d3_wallet/data/bean/response/token_account_object/token_account_object.dart';
import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:d3_wallet/data/repositories/app_configs_repository.dart';
import 'package:d3_wallet/data/repositories/token_repository.dart';
import 'package:d3_wallet/data/repositories/wallet_repository.dart';
import 'package:d3_wallet/utils/constants.dart';
import 'package:fimber/fimber.dart';
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
    // wallets.value = List.generate(
    //   20,
    //   (index) => WalletResponseObject(
    //     name: "Account ${index + 1}",
    //     address: "0x${(index + 1).toRadixString(16).padLeft(40, '0')}",
    //   ),
    // );
  }

  @override
  void onClose() {
    super.onClose();
    Fimber.d("onClose()");
  }

  void backupIsDone() {}

  void updateSelectedNetwork(NetworkObject selectedNetworkValue) {}

  void hideBalance() {}
}
