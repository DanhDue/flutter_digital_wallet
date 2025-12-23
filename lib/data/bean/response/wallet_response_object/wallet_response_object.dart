// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/data/local/storage_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive_ce.dart';

part 'wallet_response_object.freezed.dart';
part 'wallet_response_object.g.dart';

/// Converter to handle int/double to num conversion for backward compatibility
class NumConverter implements JsonConverter<num?, Object?> {
  const NumConverter();

  @override
  num? fromJson(Object? json) {
    if (json == null) return null;
    if (json is num) return json;
    if (json is String) {
      return double.tryParse(json) ?? int.tryParse(json);
    }
    return null;
  }

  @override
  Object? toJson(num? object) => object;
}

@freezed
@HiveType(typeId: StorageKeys.walletHiveTypeId)
abstract class WalletResponseObject with _$WalletResponseObject {
  const factory WalletResponseObject({
    @HiveField(0) @JsonKey(name: 'userId') String? userId,
    @HiveField(1) @JsonKey(name: 'emailIsConfirmed') bool? emailIsConfirmed,
    @HiveField(2) @JsonKey(name: 'isValid') bool? isValid,
    @HiveField(3) @JsonKey(name: 'privateKey') String? privateKey,
    @HiveField(4) @JsonKey(name: 'bs58PrivateKey') String? bs58PrivateKey,
    @HiveField(5) @JsonKey(name: 'address') String? address,
    @HiveField(6) @JsonKey(name: 'mnemonics') String? mnemonics,
    @HiveField(7) @JsonKey(name: 'balance') @NumConverter() num? balance,
    @HiveField(8) @JsonKey(name: 'error') String? error,
    @HiveField(9) @JsonKey(name: 'signature') String? signature,
    @HiveField(10) @JsonKey(name: 'scr_is_backed_up', defaultValue: false) bool? scrIsBackedUp,
    @HiveField(11)
    @JsonKey(name: 'scr_backup_reminder_is_shown', defaultValue: false)
    bool? scrBackupReminderIsShown,
    @HiveField(12) @JsonKey(name: 'title') String? title,
    @HiveField(13) @JsonKey(name: 'name') String? name,
    @HiveField(14) @JsonKey(name: 'password') String? password,
    @HiveField(15) @JsonKey(name: 'noAccent') String? noAccentName,
  }) = _WalletResponseObject;

  factory WalletResponseObject.fromJson(Map<String, Object?> json) =>
      _$WalletResponseObjectFromJson(json);
}
