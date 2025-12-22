// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

/// Generic JSON converter for Map<String, T> where T is a JSON-serializable object.
///
/// Usage:
/// ```dart
/// @MapJsonConverter(MyObject.fromJson)
/// Future<Map<String, MyObject>> getMyObjects();
/// ```
class MapJsonConverter<T> implements JsonConverter<Map<String, T>, Map<String, dynamic>> {
  const MapJsonConverter(this.fromJsonT);

  /// Function to convert a JSON map to type T
  final T Function(Map<String, dynamic>) fromJsonT;

  @override
  Map<String, T> fromJson(Map<String, dynamic> json) {
    return json.map((key, value) {
      if (value is Map<String, dynamic>) {
        return MapEntry(key, fromJsonT(value));
      }
      throw ArgumentError('Invalid value type for key "$key". Expected Map<String, dynamic>.');
    });
  }

  @override
  Map<String, dynamic> toJson(Map<String, T> object) {
    return object.map((key, value) {
      final dynamic val = value;
      if (val is Map<String, dynamic>) {
        return MapEntry(key, val);
      }
      // Assume the object has a toJson method
      return MapEntry(key, (val as dynamic).toJson() as Map<String, dynamic>);
    });
  }
}
