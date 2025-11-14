// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/data/base_response_object.dart';
import 'package:d3_wallet/data/bean/app_configurations/app_configurations.dart';
import 'package:d3_wallet/data/bean/response/health_check_response_object/health_check_response_object.dart';
import 'package:d3_wallet/data/local/storage_keys.dart';
import 'package:d3_wallet/data/remote/api_error.dart';
import 'package:d3_wallet/data/remote/app_client/health_check_client.dart';
import 'package:d3_wallet/data/repositories/app_configs_repository.dart';
import 'package:d3_wallet/data/repositories/safe_call_api_mixin.dart';
import 'package:d3_wallet/data/repositories/secure_keys.dart';
import 'package:d3_wallet/data/result.dart';
import 'package:fimber/fimber.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AppConfigurationsRepositoryImpl extends AppConfigsRepository with SafeCallApiMixin {
  final healthzClient = Get.find<HealthCheckClient>();

  final _secureKeys = Get.find<SecureKeys>();
  // Need to update this variable whenever read/write any changes.
  AppConfigurations? appConfigurations;

  @override
  Future<AppConfigurations?> retrieveAppConfigurations() async {
    Fimber.d("Future<AppConfigurations?> retrieveAppConfigurations()");
    final encryptedKey = await _secureKeys.getOrCreateSecureKey(StorageKeys.appConfigBoxName);
    Fimber.d("retrieve - encryptedKey: $encryptedKey");
    // open the box with the secure key.
    var encryptedBox = await Hive.openBox<AppConfigurations>(
      StorageKeys.appConfigBoxName,
      encryptionCipher: HiveAesCipher(encryptedKey),
    );
    // read the app configurations from the box.
    appConfigurations = encryptedBox.get(StorageKeys.appConfigBoxName);
    return appConfigurations;
  }

  @override
  Future saveAppConfigurations(AppConfigurations? appConfigurations) async {
    Fimber.d("saveAppConfigurations(AppConfigurations? appConfigurations)");
    if (appConfigurations == null) return;
    this.appConfigurations = appConfigurations;
    final encryptedKey = await _secureKeys.getOrCreateSecureKey(StorageKeys.appConfigBoxName);
    Fimber.d("save - encryptedKey: $encryptedKey");
    // open the box with the secure key.
    var encryptedBox = await Hive.openBox<AppConfigurations>(
      StorageKeys.appConfigBoxName,
      encryptionCipher: HiveAesCipher(encryptedKey),
    );
    // save the app configurations to the box.
    encryptedBox.put(StorageKeys.appConfigBoxName, appConfigurations);
  }

  @override
  Future clearAppData() async {
    Fimber.d("clearAppData()");
    appConfigurations = null;
    final encryptedKey = await _secureKeys.getOrCreateSecureKey(StorageKeys.appConfigBoxName);
    Fimber.d("save - encryptedKey: $encryptedKey");
    // open the box with the secure key.
    var encryptedBox = await Hive.openBox<AppConfigurations>(
      StorageKeys.appConfigBoxName,
      encryptionCipher: HiveAesCipher(encryptedKey),
    );
    encryptedBox.clear();
  }

  @override
  Future saveLocalPassword(String? password) async {
    if (appConfigurations != null) {
      await saveAppConfigurations(appConfigurations?.copyWith(localPasswords: password));
    } else {
      await retrieveAppConfigurations();
      await saveAppConfigurations(
        (appConfigurations ?? AppConfigurations()).copyWith(localPasswords: password),
      );
    }
  }

  @override
  Future<Result<BaseResponseObject<HealthCheckResponseObject?>?, ApiError>> healthz() =>
      safeApiCall(() => healthzClient.healthz());
}
