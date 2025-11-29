// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/data/base_response_object.dart';
import 'package:d3_wallet/data/bean/response/transaction_response_object/transaction_response_object.dart';
import 'package:d3_wallet/data/remote/api_error.dart';
import 'package:d3_wallet/data/result.dart';

abstract class TransactionRepository {
  Future<Result<BaseResponseObject<TransactionResponseObject?>?, ApiError>>
  getTransactionBySignature(String signature, {bool? parsedJson = true, List<String>? owners});

  Future<Result<BaseResponseObject<List<TransactionResponseObject?>?>?, ApiError>>
  getTransactionByOwner(String owner, {int? limit = 5, String? before, String? until});
}
