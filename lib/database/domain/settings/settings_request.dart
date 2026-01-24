
import 'package:json_annotation/json_annotation.dart';
part 'settings_request.g.dart';

@JsonSerializable(createToJson: false)
class SettingsRequest {
  final String? currency, language, theme;

  SettingsRequest(this.currency, this.language, this.theme);

  factory SettingsRequest.fromJson(Map<String, dynamic> json) => _$SettingsRequestFromJson(json);
}