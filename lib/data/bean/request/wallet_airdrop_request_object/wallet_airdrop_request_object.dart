// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_airdrop_request_object.freezed.dart';
part 'wallet_airdrop_request_object.g.dart';

@freezed
abstract class WalletAirdropRequestObject with _$WalletAirdropRequestObject {
  const factory WalletAirdropRequestObject({
    @JsonKey(name: 'address') String? address,
    @JsonKey(name: 'amount') @Default(5.0) double? amount,
  }) = _WalletAirdropRequestObject;

  factory WalletAirdropRequestObject.fromJson(Map<String, Object?> json) =>
      _$WalletAirdropRequestObjectFromJson(json);
}
