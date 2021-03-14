import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:svg_parser/src/converters/integer_converter.dart';
import 'package:svg_parser/src/converters/length_converter.dart';
import 'package:svg_parser/src/converters/children_converter.dart';
import 'package:svg_parser/src/types/length_type.dart';
import 'package:xml/xml.dart';

import '../attributes/core_attributes.dart';
import 'package:svg_parser/src/helpers/extensions/xml_attr_to_map.dart';

part 'svg_element.g.dart';

@JsonSerializable(explicitToJson: true)
class SvgElement implements CoreAttributes {
  SvgElement();

  factory SvgElement.fromXml(String svgString) {
    final document = XmlDocument.parse(svgString);
    var root = document.rootElement;

    if (root.name.toString() != 'svg') {
      throw FormatException('not root svg');
    }

    return SvgElement.fromJson(
      root.toMap(),
    );
  }

  @override
  @JsonKey(name: 'id')
  String? id;

  @override
  @JsonKey(name: 'lang')
  String? lang;

  @override
  @JsonKey(
    name: 'tabindex',
  )
  @IntegerConverter()
  int? tabindex;

  @override
  @JsonKey(name: 'xml:lang')
  String? xmlLang;

  @JsonKey(name: 'height')
  @LengthConverter()
  LengthType? height;

  @JsonKey(name: 'width')
  @LengthConverter()
  LengthType? width;

  @JsonKey(name: 'x')
  @LengthConverter()
  LengthType? x;

  @JsonKey(name: 'y')
  @LengthConverter()
  LengthType? y;

  @JsonKey(name: childrenKey)
  @ChildrenConverter()
  List<CoreAttributes>? children;

  factory SvgElement.fromJson(Map<String, dynamic> json) =>
      _$SvgElementFromJson(json);

  Map<String, dynamic> toJson() => _$SvgElementToJson(this);
}
