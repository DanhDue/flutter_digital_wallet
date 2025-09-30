// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:flutter/material.dart';

extension ColorExtension on Color? {
  String? toHexString({bool alpha = false, bool short = false}) {
    final r = (this?.r ?? 0 * 0xFF).floor() & 0xFF;
    final g = (this?.g ?? 0 * 0xFF).floor() & 0xFF;
    final b = (this?.b ?? 0 * 0xFF).floor() & 0xFF;
    final a = (this?.a ?? 0 * 0xFF).floor() & 0xFF;

    final isShort =
        short &&
        ((r >> 4) == (r & 0xF)) &&
        ((g >> 4) == (g & 0xF)) &&
        ((b >> 4) == (b & 0xF)) &&
        (!alpha || (a >> 4) == (a & 0xF));

    if (isShort) {
      final rgb =
          (r & 0xF).toRadixString(16) + (g & 0xF).toRadixString(16) + (b & 0xF).toRadixString(16);

      return alpha ? (a & 0xF).toRadixString(16) + rgb : rgb;
    } else {
      final rgb =
          r.toRadixString(16).padLeft(2, '0') +
          g.toRadixString(16).padLeft(2, '0') +
          b.toRadixString(16).padLeft(2, '0');

      return alpha ? a.toRadixString(16).padLeft(2, '0') + rgb : rgb;
    }
  }
}
