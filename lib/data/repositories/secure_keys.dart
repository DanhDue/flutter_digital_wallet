// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'dart:convert';

import 'package:d3_wallet/data/repositories/secure_storage_repository.dart';
import 'package:dart_extensions/dart_extensions.dart';
import 'package:fimber/fimber.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SecureKeys {
  final _secureStorage = Get.find<SecureStorageRepository>();

  /// This method is used to get or create a new secure key for the box.
  Future<List<int>> getOrCreateSecureKey(String boxName) async {
    // check if the key is already stored in the secure storage.
    var savedKey = await _secureStorage.get(boxName);
    // if the key is stored.
    if (savedKey?.isNotBlank == true) {
      Fimber.d("_getOrCreateSecureKey: sKey: $savedKey");
      return base64Decode(savedKey!).toList();
    } else {
      // generate a new key.
      final newKey = Hive.generateSecureKey();
      Fimber.d("_getOrCreateSecureKey: newKey: $newKey");
      // and store key in the secure storage.
      _secureStorage.set(boxName, base64Encode(newKey));
      return newKey;
    }
  }

  Future<HiveAesCipher> retrieveHiveAesCipher(String secureKey) async {
    final encryptedKey = await getOrCreateSecureKey(secureKey);
    return HiveAesCipher(encryptedKey);
  }
}
