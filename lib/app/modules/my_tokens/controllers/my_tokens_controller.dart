// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/base/base_controller.dart';
import 'package:d3_wallet/base/networking_mixin.dart';
import 'package:d3_wallet/data/bean/response/token_account_object/token_account_object.dart';
import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:d3_wallet/data/repositories/token_repository.dart';
import 'package:d3_wallet/data/repositories/wallet_repository.dart';
import 'package:d3_wallet/utils/constants.dart';
import 'package:d3_wallet/utils/stream_manager.dart';
import 'package:dart_helper_utils/dart_helper_utils.dart';
import 'package:fimber/fimber.dart';
import 'package:get/get.dart';

class MyTokensController extends BaseController with NetworkingMixin {
  late final Rx<WalletResponseObject> selectedWallet = WalletResponseObject().obs;

  final tokenRepo = Get.find<TokenRepository>();
  final walletRepo = Get.find<WalletRepository>();

  var lstTokens = <TokenAccountObject?>[];
  final RxList<TokenAccountObject?> tokens = <TokenAccountObject?>[].obs;
  final balanceIsHidden = false.obs;

  @override
  void onInit() {
    super.onInit();
    Fimber.d("onInit()");
    walletIsChanged.stream.listen((event) {
      Fimber.d("notificationStream event: ${event.toJson().encodedJsonString}");
      if (event.address == selectedWallet.value.address) {
        return;
      }
      selectedWallet.value = event;
      fetchTokenAccounts(selectedWallet.value, isRefreshing: true);
    });
    hiddenBalanceIsChanged.stream.listen((event) {
      Fimber.d("hiddenBalanceIsChanged: $event");
      balanceIsHidden.value = event;
    });
    balanceIsChanged.stream.listen((balanceIsChanged) {
      Fimber.d("balanceIsChanged: $balanceIsChanged");
      if (balanceIsChanged == true) {
        fetchTokenAccounts(selectedWallet.value, isRefreshing: true);
      }
    });
  }

  @override
  void onReady() async {
    super.onReady();
    Fimber.d("onReady()");
  }

  fetchTokenAccounts(WalletResponseObject? selectedWallet, {bool? isRefreshing = false}) async {
    Fimber.d("build: ${selectedWallet?.toJson().encodedJsonString}");
    if (selectedWallet?.address?.isNullOrWhiteSpace ?? true) {
      Fimber.e("Cannot fetch token accounts: no valid wallet selected");
      return;
    }
    if (isRefreshing != true &&
        (selectedWallet == null || selectedWallet.address == this.selectedWallet.value.address)) {
      return;
    }
    if (isRefreshing != true) {
      this.selectedWallet.value = selectedWallet!;
    }
    if (isLoading.value) {
      return;
    }

    if (isRefreshing == true) {
      // reset params.
      lstTokens = [];
      tokens.value = lstTokens;
      tokens.refresh();
    }

    await callMultipleApis(
      [
        walletRepo.validateWallet(this.selectedWallet.value.address ?? ""),
        tokenRepo.getAllTokenAccounts(this.selectedWallet.value.address ?? ""),
      ],
      onAllSuccess: (results) {
        Fimber.d("All API calls succeeded with ${results.length} results");

        // First result is wallet validation (unwrapped WalletResponseObject?)
        if (results.isNotEmpty) {
          final walletData = results[0]?.data;
          Fimber.d("wallet result type: ${walletData.runtimeType}");
          if (walletData is WalletResponseObject) {
            Fimber.d("wallet: ${walletData.toString()}");
            final solTokenInfo = Constants.solanaTokenAccount.copyWith(
              address: walletData.address ?? "",
              owner: walletData.address ?? "",
              amount: walletData.balance,
            );
            Fimber.d("solToken: ${solTokenInfo.toJson()}");
            lstTokens.insert(0, solTokenInfo);
            tokens.value = lstTokens;
            tokens.refresh();
          }
        }

        // Second result is token accounts (unwrapped List<TokenAccountObject?>?)
        if (results.length > 1) {
          final tokenAccountList = results[1]?.data;
          Fimber.d("tokenAccounts result type: ${tokenAccountList.runtimeType}");
          if (tokenAccountList is List) {
            final tokenList = tokenAccountList.cast<TokenAccountObject?>();
            Fimber.d("tokenAccounts: ${tokenList.firstOrNull?.toJson()}");
            lstTokens.addAll(tokenList);
            Fimber.d("lstTokenInfo: $lstTokens");
            tokens.value = lstTokens;
            tokens.refresh();
          }
        }
      },
      onAnyError: (error) {
        Fimber.e("API error: ${error.toString()}");
      },
      loadingType: LoadingType.full,
    );
  }

  @override
  void onClose() {
    super.onClose();
    Fimber.d("onClose()");
  }

  void hiddenBalanceChanged(bool? balanceIsHidden) {
    Fimber.d("hiddenBalanceChanged: $balanceIsHidden");
    if (balanceIsHidden != null) {
      this.balanceIsHidden.value = balanceIsHidden;
    }
  }
}
