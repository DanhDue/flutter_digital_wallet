// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/data/bean/response/mint_token_object/mint_token_object.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_account_object.freezed.dart';
part 'token_account_object.g.dart';

@freezed
abstract class TokenAccountObject with _$TokenAccountObject {
  const factory TokenAccountObject({
    @JsonKey(name: 'address') String? address,
    @JsonKey(name: 'owner') String? owner,
    @JsonKey(name: 'amount') int? amount,
    @JsonKey(name: 'mint_token') MintTokenObject? mintToken,
    @JsonKey(name: 'account_owner') String? accountOwner,
  }) = _TokenAccountObject;

  factory TokenAccountObject.fromJson(Map<String, Object?> json) =>
      _$TokenAccountObjectFromJson(json);

  // @override
  // Map<String, dynamic> toJson() => _$TokenAccountObjectToJson(this as _TokenAccountObject);
}

TokenAccountObject? jsonToNullableUserObject(Object? json) =>
    json == null ? null : TokenAccountObject.fromJson(json as Map<String, dynamic>);

TokenAccountObject jsonToUserObject(Object? json) =>
    TokenAccountObject.fromJson(json as Map<String, dynamic>);

List<TokenAccountObject?> jsonToListNullableUserObjects(Object? json) =>
    List.from(
      json as List,
    ).map((e) => TokenAccountObject.fromJson(e as Map<String, dynamic>)).toList();

List<TokenAccountObject> jsonToListUserObjects(Object? json) =>
    List<Object>.from(
      json as List,
    ).map((e) => TokenAccountObject.fromJson(e as Map<String, dynamic>)).toList();
