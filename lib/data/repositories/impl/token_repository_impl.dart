// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/data/base_response_object.dart';
import 'package:d3_wallet/data/bean/request/token_account_creation_request_object/token_account_creation_request_object.dart';
import 'package:d3_wallet/data/bean/request/token_transfer_creation_request_object/token_transfer_creation_request_object.dart';
import 'package:d3_wallet/data/bean/response/mint_token_object/mint_token_object.dart';
import 'package:d3_wallet/data/bean/response/token_account_object/token_account_object.dart';
import 'package:d3_wallet/data/bean/response/transaction_response_object/transaction_response_object.dart';
import 'package:d3_wallet/data/remote/api_error.dart';
import 'package:d3_wallet/data/remote/token_client/token_client.dart';
import 'package:d3_wallet/data/repositories/safe_call_api_mixin.dart';
import 'package:d3_wallet/data/repositories/token_repository.dart';
import 'package:d3_wallet/data/result.dart';
import 'package:get/get.dart';

class TokenRepositoryImpl extends TokenRepository with SafeCallApiMixin {
  final tokenClient = Get.find<TokenClient>();

  @override
  Future<Result<BaseResponseObject<List<TokenAccountObject?>?>?, ApiError>> getAllTokenAccounts(
    String walletAddress,
  ) => safeApiCall(() => tokenClient.getAllTokenAccounts(walletAddress));

  @override
  Future<Result<BaseResponseObject<TokenAccountObject?>?, ApiError>> createTokenAccount(
    TokenAccountCreationRequestObject request,
  ) => safeApiCall(() => tokenClient.createTokenAccount(request));

  @override
  Future<Result<BaseResponseObject<MintTokenObject?>?, ApiError>> getMintToken(
    String mintAddress,
  ) => safeApiCall(() => tokenClient.getMintToken(mintAddress));

  @override
  Future<Result<BaseResponseObject<TransactionResponseObject?>?, ApiError>> transfer(
    TokenTransferCreationRequestObject request,
  ) => safeApiCall(() => tokenClient.transfer(request));
}
