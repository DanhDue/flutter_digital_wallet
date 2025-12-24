// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'token_account_creation_request_object.freezed.dart';
part 'token_account_creation_request_object.g.dart';

@freezed
abstract class TokenAccountCreationRequestObject with _$TokenAccountCreationRequestObject {
  @JsonSerializable(includeIfNull: false)
  const factory TokenAccountCreationRequestObject({
    @JsonKey(name: 'owner_bs58_private_key') String? ownerBs58PrivateKey,
    @JsonKey(name: 'payer_bs58_private_key') String? payerBs58PrivateKey,
    @JsonKey(name: 'mint_token') String? mintToken,
  }) = _TokenAccountCreationRequestObject;

  factory TokenAccountCreationRequestObject.fromJson(Map<String, Object?> json) =>
      _$TokenAccountCreationRequestObjectFromJson(json);
}
