// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/data/local/storage_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive_ce.dart';

part 'app_configurations.freezed.dart';
part 'app_configurations.g.dart';

@freezed
@HiveType(typeId: StorageKeys.appConfigurationHiveTypeId)
abstract class AppConfigurations with _$AppConfigurations {
  const factory AppConfigurations({
    @HiveField(0) @JsonKey(name: 'latest_synced_time') int? latestSyncedTime,
    @HiveField(1) @JsonKey(name: 'access_token') String? accessToken,
    @HiveField(2) @JsonKey(name: 'refresh_token') String? refreshToken,
    @HiveField(3) @JsonKey(name: 'base_url') String? baseUrl,
    @HiveField(4) @JsonKey(name: 'local_passwords') String? localPasswords,
    @HiveField(5) @JsonKey(name: 'is_first_initialization') bool? isFirstInitialization,
    @HiveField(6) @JsonKey(name: 'is_biometrics_login') bool? isBiometricsLogin,
    @HiveField(7) @JsonKey(name: 'balanceIsHidden', defaultValue: false) bool? balanceIsHidden,
  }) = _AppConfigurations;

  factory AppConfigurations.fromJson(Map<String, Object?> json) =>
      _$AppConfigurationsFromJson(json);
}
