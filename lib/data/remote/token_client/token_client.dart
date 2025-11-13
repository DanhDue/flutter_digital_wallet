// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/data/base_response_object.dart';
import 'package:d3_wallet/data/bean/request/token_account_creation_request_object/token_account_creation_request_object.dart';
import 'package:d3_wallet/data/bean/request/token_transfer_creation_request_object/token_transfer_creation_request_object.dart';
import 'package:d3_wallet/data/bean/response/mint_token_object/mint_token_object.dart';
import 'package:d3_wallet/data/bean/response/token_account_object/token_account_object.dart';
import 'package:d3_wallet/data/bean/response/transaction_response_object/transaction_response_object.dart';
import 'package:d3_wallet/data/remote/app_uri.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'token_client.g.dart';

@RestApi()
abstract class TokenClient {
  factory TokenClient(Dio dio, {String? baseUrl, ParseErrorLogger? errorLogger}) = _TokenClient;

  @GET("${UriPaths.accounts}/${UriPathParameters.address}")
  Future<BaseResponseObject<List<TokenAccountObject?>?>?> getAllTokenAccounts(
    @Path("address") String address,
  );

  @POST(UriPaths.account)
  Future<BaseResponseObject<TokenAccountObject?>?> createTokenAccount(
    @Body() TokenAccountCreationRequestObject request,
  );

  @GET(UriPathParameters.address)
  Future<BaseResponseObject<MintTokenObject?>?> getMintToken(@Path("address") String mintAddress);

  @POST(UriPaths.transfer)
  Future<BaseResponseObject<TransactionResponseObject?>?> transfer(
    @Body() TokenTransferCreationRequestObject request,
  );
}
