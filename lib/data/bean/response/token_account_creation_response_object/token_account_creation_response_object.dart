// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/data/bean/response/mint_token_object/mint_token_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'token_account_creation_response_object.freezed.dart';
part 'token_account_creation_response_object.g.dart';

@freezed
abstract class TokenAccountCreationResponseObject with _$TokenAccountCreationResponseObject {
  const factory TokenAccountCreationResponseObject({
    @JsonKey(name: 'address') String? address,
    @JsonKey(name: 'owner') String? owner,
    @JsonKey(name: 'amount') int? amount,
    @JsonKey(name: 'mint') String? mint,
    @JsonKey(name: 'mint_token') MintTokenObject? mintToken,
    @JsonKey(name: 'account_owner') String? accountOwner,
  }) = _TokenAccountCreationResponseObject;

  factory TokenAccountCreationResponseObject.fromJson(Map<String, Object?> json) =>
      _$TokenAccountCreationResponseObjectFromJson(json);
}
