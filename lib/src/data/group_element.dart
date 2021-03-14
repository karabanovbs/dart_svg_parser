import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:svg_parser/src/converters/integer_converter.dart';
import 'package:svg_parser/src/converters/length_converter.dart';
import 'package:svg_parser/src/converters/children_converter.dart';
import 'package:svg_parser/src/types/length_type.dart';
import 'package:xml/xml.dart';

import '../attributes/core_attributes.dart';
import 'package:svg_parser/src/helpers/extensions/xml_attr_to_map.dart';

part 'group_element.g.dart';

@JsonSerializable(explicitToJson: true)
class GroupElement implements CoreAttributes {
  GroupElement();

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

  @JsonKey(name: childrenKey)
  @ChildrenConverter()
  List<CoreAttributes>? children;

  factory GroupElement.fromJson(Map<String, dynamic> json) =>
      _$GroupElementFromJson(json);

  Map<String, dynamic> toJson() => _$GroupElementToJson(this);
}
