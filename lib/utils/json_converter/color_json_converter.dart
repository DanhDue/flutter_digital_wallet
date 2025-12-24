// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/utils/extensions/color_extension.dart';
import 'package:d3_wallet/utils/extensions/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class ColorJsonConverter implements JsonConverter<Color?, String?> {
  const ColorJsonConverter();
  @override
  Color? fromJson(String? json) => json?.toColor();

  @override
  String? toJson(Color? object) => object?.toHexString();
}
