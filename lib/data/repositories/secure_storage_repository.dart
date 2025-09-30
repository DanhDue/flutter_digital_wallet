// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

abstract class SecureStorageRepository {
  Future<String?> get(String key);
  Future<void> set(String key, String value);
  Future<void> remove(String key);
  Future<void> clear();
}
