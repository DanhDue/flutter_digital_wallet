// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

class EnvironmentConfig {
  static const APP_NAME = String.fromEnvironment('APP_NAME', defaultValue: "Wallet");
  static const APP_SUFFIX = String.fromEnvironment('APP_SUFFIX', defaultValue: ".dev");
  static const BASE_URL = String.fromEnvironment('BASE_URL', defaultValue: "http://danhdue.com/");
  static const USE_TALKER = bool.fromEnvironment('USE_TALKER', defaultValue: false);
}
