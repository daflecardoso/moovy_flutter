import 'package:json_annotation/json_annotation.dart';

class BoolFlexConverter implements JsonConverter<bool, Object?> {
  const BoolFlexConverter();

  @override
  bool fromJson(Object? json) {
    if (json == null) return false;
    if (json is bool) return json;
    if (json is num) return json != 0;
    if (json is String) {
      final v = json.trim().toLowerCase();
      return v == '1' || v == 'true';
    }
    throw FormatException('Cannot convert $json to bool');
  }

  @override
  Object toJson(bool value) => value ? 1 : 0;
}