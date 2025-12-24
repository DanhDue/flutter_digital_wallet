// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/data/bean/response/account_input_object/account_input_object.dart';
import 'package:d3_wallet/data/bean/response/token_balance_object/token_balance_object.dart';
import 'package:d3_wallet/data/bean/response/transaction_overview_object/transaction_overview_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'transaction_response_object.freezed.dart';
part 'transaction_response_object.g.dart';

@freezed
abstract class TransactionResponseObject with _$TransactionResponseObject {
  const factory TransactionResponseObject({
    @JsonKey(name: 'isLabel') bool? isLabel,
    @JsonKey(name: 'isLast') bool? isLast,
    @JsonKey(name: 'signature') String? signature,
    @JsonKey(name: 'overview') TransactionOverviewObject? overview,
    @JsonKey(name: 'account_inputs') List<AccountInputObject>? accountInputs,
    @JsonKey(name: 'token_balances') List<TokenBalanceObject>? tokenBalances,
    @JsonKey(name: 'transaction_type') String? transactionType,
  }) = _TransactionResponseObject;

  factory TransactionResponseObject.fromJson(Map<String, Object?> json) =>
      _$TransactionResponseObjectFromJson(json);
}
