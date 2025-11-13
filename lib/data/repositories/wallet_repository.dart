// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/data/base_response_object.dart';
import 'package:d3_wallet/data/bean/request/wallet_airdrop_request_object/wallet_airdrop_request_object.dart';
import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:d3_wallet/data/remote/api_error.dart';
import 'package:d3_wallet/data/result.dart';

abstract class WalletRepository {
  Future<Result<BaseResponseObject<WalletResponseObject>?, ApiError>> createOrRestoreWallet({
    String? deviceToken,
    String? privateKey,
    String? bs58PrivateKey,
    String? mnemonics,
  });

  Future<Result<BaseResponseObject<WalletResponseObject>?, ApiError>> validateWallet(
    String walletAddress,
  );

  Future<Result<BaseResponseObject<WalletResponseObject>?, ApiError>> airdrop(
    WalletAirdropRequestObject request,
  );
}
