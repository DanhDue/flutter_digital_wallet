// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:jiffy/jiffy.dart';
import 'package:json_annotation/json_annotation.dart';

class JiffyLongJsonConverter implements JsonConverter<Jiffy?, int?> {
  const JiffyLongJsonConverter();

  @override
  Jiffy? fromJson(int? timestamp) {
    return Jiffy.parseFromMillisecondsSinceEpoch((timestamp ?? 0) * 1000);
  }

  @override
  int? toJson(Jiffy? date) => date?.millisecondsSinceEpoch;
}
