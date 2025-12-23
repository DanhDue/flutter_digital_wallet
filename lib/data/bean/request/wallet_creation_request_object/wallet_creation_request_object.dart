// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'wallet_creation_request_object.freezed.dart';
part 'wallet_creation_request_object.g.dart';

@freezed
abstract class WalletCreationRequestObject with _$WalletCreationRequestObject {
  const factory WalletCreationRequestObject({
    @JsonKey(name: 'userId') String? userId,
    @JsonKey(name: 'deviceToken') String? deviceToken,
    @JsonKey(name: 'privateKey') String? privateKey,
    @JsonKey(name: 'bs58PrivateKey') String? bs58PrivateKey,
    @JsonKey(name: 'mnemonics') String? mnemonics,
  }) = _WalletCreationRequestObject;

  factory WalletCreationRequestObject.fromJson(Map<String, Object?> json) =>
      _$WalletCreationRequestObjectFromJson(json);
}
