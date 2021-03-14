import 'package:svg_parser/src/attributes/core_attributes.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:svg_parser/src/attributes/presentation_attributes.dart';
import 'package:svg_parser/src/converters/length_converter.dart';
import 'package:svg_parser/src/converters/paint_converter.dart';
import 'package:svg_parser/src/types/fill_rule_type.dart';
import 'package:svg_parser/src/types/length_type.dart';
import 'package:svg_parser/src/types/paint_type.dart';
import 'package:svg_parser/src/types/stroke_linecap_type.dart';

part 'path_element.g.dart';

@JsonSerializable()
class PathElement implements CoreAttributes, PresentationAttributes {
  PathElement({
    required this.d,
  });

  @override
  String? id;

  @override
  String? lang;

  @override
  int? tabindex;

  @override
  String? xmlLang;

  @override
  @PaintConverter()
  PaintType? fill;

  @override
  @JsonKey(name: 'fill-rule')
  FillRuleType? fillRule;

  @override
  @PaintConverter()
  PaintType? stroke;

  @override
  @JsonKey(name: 'stroke-linecap')
  StrokeLinecapType? strokeLinecap;

  @override
  @JsonKey(name: 'stroke-width')
  @LengthConverter()
  LengthType? strokeWidth;

  @override
  String? transform;

  @JsonKey(defaultValue: '')
  final String d;

  num? pathLength;


  factory PathElement.fromJson(Map<String, dynamic> json) =>
      _$PathElementFromJson(json);

  Map<String, dynamic> toJson() => _$PathElementToJson(this);
}
