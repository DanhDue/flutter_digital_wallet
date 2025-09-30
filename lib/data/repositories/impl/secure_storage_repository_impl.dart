// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/data/repositories/secure_storage_repository.dart';
import 'package:dart_extensions/dart_extensions.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class SecureStorageRepositoryImpl extends SecureStorageRepository {
  final _storage = Get.find<FlutterSecureStorage>();

  @override
  Future<void> clear() async {
    Fimber.d("SecureStorageRepository.clear()");
    _storage.deleteAll();
  }

  @override
  Future<String?> get(String key) async {
    final savedValue = await _storage.read(key: key);
    if (savedValue?.isNotBlank == true) {
      Fimber.d("SecureStorageRepository.get(key: $key) -> $savedValue");
      return savedValue;
    } else {
      Fimber.d("SecureStorageRepository.get(key: $key) -> null");
      return null;
    }
  }

  @override
  Future<void> remove(String key) async {
    Fimber.d("SecureStorageRepository.remove(key: $key)");
    _storage.delete(key: key);
  }

  @override
  Future<void> set(String key, String value) async {
    Fimber.d("SecureStorageRepository.set(key: $key, value: $value)");
    _storage.write(key: key, value: value).then((value) {
      Fimber.d("SecureStorageRepository.set -> success.");
      return value;
    });
  }
}
