// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'svg_element.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SvgElement _$SvgElementFromJson(Map<String, dynamic> json) {
  return SvgElement()
    ..id = json['id'] as String?
    ..lang = json['lang'] as String?
    ..tabindex = const IntegerConverter().fromJson(json['tabindex'] as String?)
    ..xmlLang = json['xml:lang'] as String?
    ..height = const LengthConverter().fromJson(json['height'] as String?)
    ..width = const LengthConverter().fromJson(json['width'] as String?)
    ..x = const LengthConverter().fromJson(json['x'] as String?)
    ..y = const LengthConverter().fromJson(json['y'] as String?)
    ..children = const ChildrenConverter()
        .fromJson(json['_children'] as Iterable<XmlElement>);
}

Map<String, dynamic> _$SvgElementToJson(SvgElement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lang': instance.lang,
      'tabindex': const IntegerConverter().toJson(instance.tabindex),
      'xml:lang': instance.xmlLang,
      'height': const LengthConverter().toJson(instance.height),
      'width': const LengthConverter().toJson(instance.width),
      'x': const LengthConverter().toJson(instance.x),
      'y': const LengthConverter().toJson(instance.y),
      '_children': const ChildrenConverter().toJson(instance.children),
    };
