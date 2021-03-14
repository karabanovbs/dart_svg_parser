// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_element.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupElement _$GroupElementFromJson(Map<String, dynamic> json) {
  return GroupElement()
    ..id = json['id'] as String?
    ..lang = json['lang'] as String?
    ..tabindex = const IntegerConverter().fromJson(json['tabindex'] as String?)
    ..xmlLang = json['xml:lang'] as String?
    ..children = const ChildrenConverter()
        .fromJson(json['_children'] as Iterable<XmlElement>);
}

Map<String, dynamic> _$GroupElementToJson(GroupElement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lang': instance.lang,
      'tabindex': const IntegerConverter().toJson(instance.tabindex),
      'xml:lang': instance.xmlLang,
      '_children': const ChildrenConverter().toJson(instance.children),
    };
