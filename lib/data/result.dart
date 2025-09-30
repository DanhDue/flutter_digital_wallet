// Copyright (c) 2022, one of the D3F outsourcing projects. All rights reserved.

// coverage:ignore-file

import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
sealed class Result<T, E extends Exception> with _$Result<T, E> {
  const factory Result.success(T data) = Success;

  const factory Result.failure(E error) = Failure;
}
