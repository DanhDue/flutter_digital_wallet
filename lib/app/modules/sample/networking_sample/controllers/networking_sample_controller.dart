// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/base/base_controller.dart';
import 'package:d3_wallet/base/networking_mixin.dart';
import 'package:d3_wallet/data/repositories/token_repository.dart';
import 'package:d3_wallet/data/repositories/transaction_repository.dart';
import 'package:dart_helper_utils/dart_helper_utils.dart';
import 'package:fimber/fimber.dart';
import 'package:get/get.dart';

class NetworkingSampleController extends BaseController with NetworkingMixin {
  final liveChatBotIsShown = false.obs;
  final liveChatBotIsDancing = false.obs;

  final transactionRepo = Get.find<TransactionRepository>();
  final tokenRepo = Get.find<TokenRepository>();

  @override
  void onInit() {
    super.onInit();
    Fimber.d("onInit()");
  }

  @override
  void onReady() async {
    super.onReady();
    Fimber.d("onReady()");
    liveChatBotIsShown.value = true;
    Future.delayed(const Duration(milliseconds: 850), () {
      if (isClosed) return;
      liveChatBotIsDancing.value = true;
    });
    retrieveTransactionBySignature();
  }

  retrieveMintToken() async {
    callApi(
      tokenRepo.getMintToken("DttvtPZ92yZrzUTeF8jqtDXaQLDGVHVx5acNhEtLVH2w"),
      onSuccess: (response) {
        Fimber.d("wallet: ${response?.data?.toJson().encodedJsonString}");
      },
      onError: (error) {
        Fimber.e(error.toString());
      },
    );
  }

  retrieveTransactionBySignature() async {
    callApi(
      transactionRepo.getTransactionBySignature(
        "3vmjmE6q3rj7WkCe1baig7tzrbV3nzW5BS8KzKkX8dDQvYd329fTKkSLazeU7k2cvFzA2AtRHus7vNNwjaarTiKx",
        parsedJson: true,
        owners: [
          "CRG9hpv6WpMHhiNZKF9XSjTnfS9SavtTJqhTRc3xG4GZ",
          "5Vvc61qF3hzatbifr9x4dvUZrGAZ3UhWSuqNU5EBdgG4",
        ],
      ),
      onSuccess: (response) {
        Fimber.d("wallet: ${response?.data?.toJson().encodedJsonString}");
      },
      onError: (error) {
        Fimber.e(error.toString());
      },
    );
  }

  @override
  void onClose() {
    super.onClose();
    Fimber.d("onClose()");
  }
}
