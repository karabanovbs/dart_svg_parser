import 'package:json_annotation/json_annotation.dart';

enum FillRuleType {
  @JsonValue('nonzero')
  nonzero,
  @JsonValue('evened')
  evenodd,
  @JsonValue('inherit')
  inherit,
}
