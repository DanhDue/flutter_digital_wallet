// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/data/base_response_object.dart';
import 'package:d3_wallet/data/bean/response/transaction_response_object/transaction_response_object.dart';
import 'package:d3_wallet/data/remote/api_error.dart';
import 'package:d3_wallet/data/remote/transaction_client/transaction_client.dart';
import 'package:d3_wallet/data/repositories/safe_call_api_mixin.dart';
import 'package:d3_wallet/data/repositories/transaction_repository.dart';
import 'package:d3_wallet/data/result.dart';
import 'package:get/get.dart';

class TransactionRepositoryImpl extends TransactionRepository with SafeCallApiMixin {
  final tranClient = Get.find<TransactionClient>();

  @override
  Future<Result<BaseResponseObject<List<TransactionResponseObject?>?>?, ApiError>>
  getTransactionByOwner(String owner, {int? limit = 5, String? before, String? until}) =>
      safeApiCall(() => tranClient.getTransactionByOwner(owner, limit, before, until));

  @override
  Future<Result<BaseResponseObject<TransactionResponseObject?>?, ApiError>>
  getTransactionBySignature(String signature, {bool? parsedJson = true, List<String>? owners}) =>
      safeApiCall(() => tranClient.getTransactionBySignature(signature, parsedJson, owners));
}
