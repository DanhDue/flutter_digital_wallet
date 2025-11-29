// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/data/base_response_object.dart';
import 'package:d3_wallet/data/bean/response/transaction_response_object/transaction_response_object.dart';
import 'package:d3_wallet/data/remote/app_uri.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'transaction_client.g.dart';

@RestApi()
abstract class TransactionClient {
  factory TransactionClient(Dio dio, {String? baseUrl, ParseErrorLogger? errorLogger}) =
      _TransactionClient;

  @GET(UriPathParameters.signature)
  Future<BaseResponseObject<TransactionResponseObject?>?> getTransactionBySignature(
    @Path("signature") String signature,
    @Query("parsed_json") bool? parsedJson,
    @Query("owners") List<String>? owners,
  );

  @GET("")
  Future<BaseResponseObject<List<TransactionResponseObject?>?>?> getTransactionByOwner(
    @Query("owner") String owner,
    @Query("limit") int? limit,
    @Query("before") String? before,
    @Query("until") String? until,
  );
}
