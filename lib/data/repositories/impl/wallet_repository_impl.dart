// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/data/base_response_object.dart';
import 'package:d3_wallet/data/bean/request/wallet_airdrop_request_object/wallet_airdrop_request_object.dart';
import 'package:d3_wallet/data/bean/request/wallet_creation_request_object/wallet_creation_request_object.dart';
import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:d3_wallet/data/local/selected_account_storage.dart';
import 'package:d3_wallet/data/local/token_account_storage.dart';
import 'package:d3_wallet/data/local/wallets_storage.dart';
import 'package:d3_wallet/data/remote/api_error.dart';
import 'package:d3_wallet/data/remote/wallet_client/wallet_client.dart';
import 'package:d3_wallet/data/repositories/safe_call_api_mixin.dart';
import 'package:d3_wallet/data/repositories/wallet_repository.dart';
import 'package:d3_wallet/data/result.dart';
import 'package:dart_helper_utils/dart_helper_utils.dart';
import 'package:get/get.dart';

class WalletRepositoryImpl extends WalletRepository with SafeCallApiMixin {
  final _selectedAccountStorage = Get.find<SelectedAccountStorage>();
  final _walletsStorage = Get.find<WalletsStorage>();
  final _tokenAccountStorage = Get.find<TokenAccountStorage>();
  final walletClient = Get.find<WalletClient>();

  @override
  Future<Result<BaseResponseObject<WalletResponseObject>?, ApiError>> createOrRestoreWallet({
    String? deviceToken,
    String? privateKey,
    String? bs58PrivateKey,
    String? mnemonics,
  }) => safeApiCall(
    () => walletClient.createOrRestoreWallet(
      WalletCreationRequestObject(
        deviceToken: deviceToken,
        privateKey: privateKey,
        bs58PrivateKey: bs58PrivateKey,
        mnemonics: mnemonics,
      ),
    ),
  );

  @override
  Future<Result<BaseResponseObject<WalletResponseObject>?, ApiError>> validateWallet(
    String walletAddress,
  ) => safeApiCall(() => walletClient.validate(walletAddress));

  @override
  Future<Result<BaseResponseObject<WalletResponseObject>?, ApiError>> airdrop(
    WalletAirdropRequestObject request,
  ) => safeApiCall(() => walletClient.airdrop(request));

  @override
  Future<List<WalletResponseObject?>?> retrieveYourWallets() async {
    return _walletsStorage.retrieveYourWallets();
  }

  @override
  Future<void> clear() async {
    await _selectedAccountStorage.clear();
    final wallets = await _walletsStorage.retrieveYourWallets();
    wallets?.forEach((item) async {
      await _tokenAccountStorage.clear(item?.address ?? "");
    });
    await _walletsStorage.clearYourWallets();
  }

  @override
  Future<void> updateYourWallets(List<WalletResponseObject?>? wallets) async {
    await _walletsStorage.clearYourWallets();
    if (wallets.isNotEmptyOrNull == true) await _walletsStorage.updateYourWallets(wallets);
  }
}
