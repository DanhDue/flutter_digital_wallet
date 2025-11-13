// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/data/base_response_object.dart';
import 'package:d3_wallet/data/bean/request/wallet_airdrop_request_object/wallet_airdrop_request_object.dart';
import 'package:d3_wallet/data/bean/request/wallet_creation_request_object/wallet_creation_request_object.dart';
import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:d3_wallet/data/remote/app_uri.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'wallet_client.g.dart';

@RestApi()
abstract class WalletClient {
  factory WalletClient(Dio dio, {String? baseUrl, ParseErrorLogger? errorLogger}) = _WalletClient;

  @POST("")
  Future<BaseResponseObject<WalletResponseObject>> createOrRestoreWallet(
    @Body() WalletCreationRequestObject request,
  );

  @GET(UriPaths.address)
  Future<BaseResponseObject<WalletResponseObject>> validate(@Path("address") String address);

  @POST(UriPaths.airdrop)
  Future<BaseResponseObject<WalletResponseObject>> airdrop(
    @Body() WalletAirdropRequestObject request,
  );
}
