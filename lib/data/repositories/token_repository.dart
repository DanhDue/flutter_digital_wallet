// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/data/base_response_object.dart';
import 'package:d3_wallet/data/bean/request/token_account_creation_request_object/token_account_creation_request_object.dart';
import 'package:d3_wallet/data/bean/request/token_transfer_creation_request_object/token_transfer_creation_request_object.dart';
import 'package:d3_wallet/data/bean/response/mint_token_object/mint_token_object.dart';
import 'package:d3_wallet/data/bean/response/token_account_object/token_account_object.dart';
import 'package:d3_wallet/data/bean/response/transaction_response_object/transaction_response_object.dart';
import 'package:d3_wallet/data/remote/api_error.dart';
import 'package:d3_wallet/data/result.dart';

abstract class TokenRepository {
  Future<Result<BaseResponseObject<List<TokenAccountObject?>?>?, ApiError>> getAllTokenAccounts(
    String walletAddress,
  );

  Future<Result<BaseResponseObject<TokenAccountObject?>?, ApiError>> createTokenAccount(
    TokenAccountCreationRequestObject request,
  );

  Future<Result<BaseResponseObject<MintTokenObject?>?, ApiError>> getMintToken(String mintAddress);

  Future<Result<BaseResponseObject<TransactionResponseObject?>?, ApiError>> transfer(
    TokenTransferCreationRequestObject request,
  );
}
