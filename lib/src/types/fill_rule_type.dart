import 'package:json_annotation/json_annotation.dart';

enum FillRuleType {
  @JsonValue('nonzero')
  nonzero,
  @JsonValue('evenodd')
  evenodd,
  @JsonValue('inherit')
  inherit,
}
