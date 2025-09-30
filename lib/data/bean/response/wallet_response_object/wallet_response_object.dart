// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/data/local/storage_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'wallet_response_object.freezed.dart';
part 'wallet_response_object.g.dart';

@freezed
@HiveType(typeId: StorageKeys.walletHiveTypeId)
abstract class WalletResponseObject with _$WalletResponseObject {
  const factory WalletResponseObject({
    @HiveField(0) @JsonKey(name: 'userId') String? userId,
    @HiveField(1) @JsonKey(name: 'address') String? address,
    @HiveField(2) @JsonKey(name: 'mnemonics') String? mnemonics,
    @HiveField(3) @JsonKey(name: 'balance') double? balance,
    @HiveField(4) @JsonKey(name: 'network') String? network,
    @HiveField(5) @JsonKey(name: 'isValid') bool? isValid,
    @HiveField(6) @JsonKey(name: 'title') String? title,
    @HiveField(7) @JsonKey(name: 'name') String? name,
    @HiveField(8) @JsonKey(name: 'tokenAccount') String? tokenAccount,
    @HiveField(9) @JsonKey(name: 'password') String? password,
    @HiveField(10) @JsonKey(name: 'solanaBalance') double? solanaBalance,
    @HiveField(11) @JsonKey(name: 'privateKey') String? privateKey,
    @HiveField(12) @JsonKey(name: 'bs58PrivateKey') String? bs58PrivateKey,
    @HiveField(13) @JsonKey(name: 'noAccent') String? noAccentName,
    @HiveField(14) @JsonKey(name: 'scr_is_backed_up', defaultValue: false) bool? scrIsBackedUp,
    @HiveField(15)
    @JsonKey(name: 'scr_backup_reminder_is_shown', defaultValue: false)
    bool? scrBackupReminderIsShown,
  }) = _WalletResponseObject;

  factory WalletResponseObject.fromJson(Map<String, Object?> json) =>
      _$WalletResponseObjectFromJson(json);
}
