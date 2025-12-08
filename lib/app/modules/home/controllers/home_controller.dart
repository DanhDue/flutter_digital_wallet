// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/base/base_controller.dart';
import 'package:d3_wallet/base/networking_mixin.dart';
import 'package:d3_wallet/data/repositories/transaction_repository.dart';
import 'package:dart_helper_utils/dart_helper_utils.dart';
import 'package:fimber/fimber.dart';
import 'package:get/get.dart';

class HomeController extends BaseController with NetworkingMixin {
  final liveChatBotIsShown = false.obs;
  final liveChatBotIsDancing = false.obs;

  final transactionRepo = Get.find<TransactionRepository>();

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

    // final walletResponse = await tokenRepo.createTokenAccount(
    //   TokenAccountCreationRequestObject(
    //     ownerBs58PrivateKey:
    //         "4HZEpa5xeaUQJtyGPRUqchytC4utgQPqGSQLUEgTmUBz9EBZ2zwpFAs1YJyEGqX4csByWZqvoqTZCH2UfFp6KGxh",
    //     payerBs58PrivateKey:
    //         "4yxDiGDbW7MKUy6PN628ZDsSDT51zrys3vWWSkh58twVrSkqnxQ93EW2wLEaw2hVR1Rw7c72B5nLkCbkMpwQ3E6X",
    //     mintToken: "5mK9uYHWrqdPz8NnhBZGfpwYwhcv8kdHgwngZfvTrSUQ",
    //   ),
    // );

    // final walletResponse = await tokenRepo.getAllTokenAccounts(
    //   "CRG9hpv6WpMHhiNZKF9XSjTnfS9SavtTJqhTRc3xG4GZ",
    // );

    // final walletResponse = await tokenRepo.getMintToken(
    //   "DttvtPZ92yZrzUTeF8jqtDXaQLDGVHVx5acNhEtLVH2w",
    // );

    // final walletResponse = await tokenRepo.transfer(
    //   TokenTransferCreationRequestObject(
    //     ownerBs58PrivateKey:
    //         "4yxDiGDbW7MKUy6PN628ZDsSDT51zrys3vWWSkh58twVrSkqnxQ93EW2wLEaw2hVR1Rw7c72B5nLkCbkMpwQ3E6X",
    //     payerBs58PrivateKey:
    //         "bqoPDmymK4nn7tJWeFRoVt78v7s1t2NnUUsQobMfv1jLGaYYnZF1sVrusz3djjt415GooSFaVHpGAWXDC5Mpq9V",
    //     recipient: "CRG9hpv6WpMHhiNZKF9XSjTnfS9SavtTJqhTRc3xG4GZ",
    //     amount: 111,
    //     mintAddress: "DttvtPZ92yZrzUTeF8jqtDXaQLDGVHVx5acNhEtLVH2w",
    //     symbol: "ZEO",
    //     name: "Zeno",
    //     decimals: 9,
    //     isPreview: true,
    //     payForPatnerTokenAccountCreation: false,
    //   ),
    // );

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
      showLoading: false,
    );
  }

  @override
  void onClose() {
    super.onClose();
    Fimber.d("onClose()");
  }
}
