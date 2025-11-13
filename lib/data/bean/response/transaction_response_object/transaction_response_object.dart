// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'transaction_response_object.freezed.dart';
part 'transaction_response_object.g.dart';

@freezed
abstract class TransactionResponseObject with _$TransactionResponseObject {
  const factory TransactionResponseObject({
    @JsonKey(name: 'sender') String? sender,
    @JsonKey(name: 'payer') String? payer,
    @JsonKey(name: 'recipient') String? recipient,
    @JsonKey(name: 'source') String? source,
    @JsonKey(name: 'destination') String? destination,
    @JsonKey(name: 'status') String? status,
    @JsonKey(name: 'latest_blockhash') String? latestBlockhash,
    @JsonKey(name: 'amount') double? amount,
    @JsonKey(name: 'fee_sol') double? feeSol,
    @JsonKey(name: 'fee_lamports') double? feeLamports,
    @JsonKey(name: 'token_account_creation_fee_sol') double? tokenAccountCreationFeeSol,
    @JsonKey(name: 'token_account_creation_fee_lamports') double? tokenAccountCreationFeeLamports,
    @JsonKey(name: 'direction') String? direction,
    @JsonKey(name: 'required_for_dest_token_account_creation_fee')
    bool? requiredForDestTokenAccountCreationFee,
  }) = _TransactionResponseObject;

  factory TransactionResponseObject.fromJson(Map<String, Object?> json) =>
      _$TransactionResponseObjectFromJson(json);
}
