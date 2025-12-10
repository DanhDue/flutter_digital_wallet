// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'mnemonic_info_object.freezed.dart';
part 'mnemonic_info_object.g.dart';

@freezed
abstract class MnemonicInfoObject with _$MnemonicInfoObject {
  const factory MnemonicInfoObject({
    @JsonKey(name: 'hiddenWordIndex') int? hiddenWordIndex,
    @JsonKey(name: 'allWordsIndex') int? allWordsIndex,
    @JsonKey(name: 'enterredIndex') int? enterredIndex,
    @JsonKey(name: 'word') String? word,
    @JsonKey(name: 'enterWord') String? enterWord,
    @JsonKey(name: 'isHidden', defaultValue: true) bool? isHidden,
  }) = _MnemonicInfoObject;

  factory MnemonicInfoObject.fromJson(Map<String, Object?> json) =>
      _$MnemonicInfoObjectFromJson(json);
}
