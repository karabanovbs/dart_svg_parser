import 'package:json_annotation/json_annotation.dart';
import 'package:svg_parser/src/attributes/core_attributes.dart';
import 'package:svg_parser/src/data/circle_element.dart';
import 'package:svg_parser/src/data/group_element.dart';
import 'package:svg_parser/src/data/unknown_element.dart';
import 'package:svg_parser/src/data/path_element.dart';
import 'package:xml/xml.dart';
import 'package:svg_parser/src/helpers/extensions/xml_attr_to_map.dart';

class ChildrenConverter
    implements JsonConverter<List<CoreAttributes>?, Iterable<XmlElement>?> {
  const ChildrenConverter();

  @override
  List<CoreAttributes>? fromJson(Iterable<XmlElement>? json) {
    return json?.map<CoreAttributes>((e) {
      if (e.name.toString() == 'path') {
        return PathElement.fromJson(e.toMap());
      }
      if (e.name.toString() == 'circle') {
        return CircleElement.fromJson(e.toMap());
      }
      if (e.name.toString() == 'g') {
        return GroupElement.fromJson(e.toMap());
      }
      return UnknownElement();
    }).toList();
  }

  @override
  Iterable<XmlElement>? toJson(List<CoreAttributes>? object) {
    return null;
  }
}
