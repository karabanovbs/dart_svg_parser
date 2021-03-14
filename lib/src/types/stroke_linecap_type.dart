import 'package:json_annotation/json_annotation.dart';

enum StrokeLinecapType {
  @JsonValue('butt')
  butt,
  @JsonValue('round')
  round,
  @JsonValue('square')
  square,
}
