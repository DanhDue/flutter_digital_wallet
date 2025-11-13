// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'token_transfer_creation_request_object.freezed.dart';
part 'token_transfer_creation_request_object.g.dart';

@freezed
abstract class TokenTransferCreationRequestObject with _$TokenTransferCreationRequestObject {
  const factory TokenTransferCreationRequestObject({
    @JsonKey(name: 'owner_bs58_private_key') String? ownerBs58PrivateKey,
    @JsonKey(name: 'payer_bs58_private_key') String? payerBs58PrivateKey,
    @JsonKey(name: 'recipient') String? recipient,
    @JsonKey(name: 'amount') double? amount,
    @JsonKey(name: 'mint_address') String? mintAddress,
    @JsonKey(name: 'symbol') String? symbol,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'decimals') double? decimals,
    @JsonKey(name: 'is_preview') bool? isPreview,
    @JsonKey(name: 'pay_for_patner_token_account_creation') bool? payForPatnerTokenAccountCreation,
  }) = _TokenTransferCreationRequestObject;

  factory TokenTransferCreationRequestObject.fromJson(Map<String, Object?> json) =>
      _$TokenTransferCreationRequestObjectFromJson(json);
}
