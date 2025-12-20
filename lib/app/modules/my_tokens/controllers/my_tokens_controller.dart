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

  fetchTokenAccounts(WalletResponseObject? wallet, {bool? isRefreshing = false}) async {
    Fimber.d("fetchTokenAccounts wallet: ${wallet?.address}");
    if (wallet?.address?.isNullOrWhiteSpace ?? true) {
      Fimber.e("Cannot fetch token accounts: no valid wallet selected");
      return;
    }

    // Capture the request address to prevent race conditions
    final requestAddress = wallet!.address!;

    if (isRefreshing != true && (requestAddress == selectedWallet.value.address)) {
      return;
    }

    if (isRefreshing != true) {
      selectedWallet.value = wallet;
    }

    if (isLoading.value) {
      return;
    }

    await callMultipleApis(
      [walletRepo.validateWallet(requestAddress), tokenRepo.getAllTokenAccounts(requestAddress)],
      onAllSuccess: (results) {
        // IMPORTANT: Verify we are still looking for the same wallet
        if (requestAddress != selectedWallet.value.address) {
          Fimber.d(
            "Ignoring stale response for $requestAddress (current: ${selectedWallet.value.address})",
          );
          return;
        }

        Fimber.d("All API calls succeeded for $requestAddress");
        final List<TokenAccountObject?> localLstTokens = [];

        // First result is wallet validation (unwrapped WalletResponseObject?)
        if (results.isNotEmpty) {
          final walletData = results[0]?.data;
          if (walletData is WalletResponseObject) {
            final solTokenInfo = Constants.solanaTokenAccount.copyWith(
              address: walletData.address ?? "",
              owner: walletData.address ?? "",
              amount: walletData.balance?.toDouble(),
            );
            localLstTokens.insert(0, solTokenInfo);
          }
        }

        // Second result is token accounts (unwrapped List<TokenAccountObject?>?)
        if (results.length > 1) {
          final tokenAccountList = results[1]?.data;
          if (tokenAccountList is List) {
            final tokenList = tokenAccountList.cast<TokenAccountObject?>();
            localLstTokens.addAll(tokenList);
          }
        }

        // Sync tokens list with the new data
        tokens.value = localLstTokens;
        tokens.refresh();
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
