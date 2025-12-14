// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'dart:convert';

class Base64Utils {
  static final Base64Utils _instance = Base64Utils._internal();

  Base64Utils._internal();

  factory Base64Utils() {
    return _instance;
  }

  String encode(String data) {
    return base64.encode(utf8.encode(data));
  }

  String decode(String base64String) {
    try {
      return utf8.decode(base64.decode(base64String));
    } catch (e) {
      return '';
    }
  }

  bool isBase64(String str) {
    try {
      base64.decode(str);
      return true;
    } catch (e) {
      return false;
    }
  }
}
